# This code is a modification from
# "Analyzing GeoMx-NGS RNA Expression Data with GeomxTools" vignette
# https://tinyurl.com/2p8x3hss
# GeomxTools NAMESPACE default QC cutoffs https://tinyurl.com/5n6wv8uc
geomxToolsDefaults <- getAnywhere("DEFAULTS")$objs[[1]]

#' @title qcProc: Quality Control and Preprocessing
#' @description  Selects ROI/AOI segments and target probes based on quality
#' control and then generates gene-level count data.
#' @details A probe is removed globally from the dataset if either it does not
#' reach the *min.probe.ratio* threshold or the probe is an outlier according to
#'  Grubb’s test in at least *percent.fail.grubbs* of segments. A probe is
#'  removed locally (from a given segment) if the probe is an outlier in that
#'  segment and *remove.local.outliers* is set to TRUE.
#'
#' The count for any gene with multiple probes per segment is calculated as the
#' geometric mean of those probes.
#' @param object object of class *NanoStringGeoMxSet* with raw data and metadata
#'  supplied
#' @param min.segment.reads minimum number of reads
#' @param percent.trimmed minimum % of reads trimmed
#' @param percent.stitched minimum % of reads stitched
#' @param percent.aligned minimum % of reads aligned
#' @param percent.saturation minimum sequencing saturation
#' @param min.negative.count minimum negative control counts
#' @param max.ntc.count maximum counts observed in NTC well
#' @param min.nuclei minimum # of nuclei estimated
#' @param min.area minimum segment area
#' @param min.probe.ratio numeric between 0 and 1 to flag probes that have
#' (geomean probe in all segments) / (geomean probes within target) less than or
#'  equal to this ratio
#' @param outlier.test.alpha significance cut-off for Grubb's test to flag
#' outlier probes
#' @param percent.fail.grubbs numeric to flag probes that fail Grubb's test in
#' greater than or equal this percent of segments
#' @param remove.local.outliers boolean to determine if local outliers should be
#' excluded from exprs matrix
#' @param shift.count.zero boolean to shift 0 counts (if TRUE shift 0s by 1,
#' otherwise shift all counts by 1)
#' @param print.plots boolean to display plots or set to FALSE otherwise; ggplot
#' objects are returned in either case
#' @importFrom Biobase protocolData pData fData featureData
#' @importFrom BiocGenerics annotation
#' @importFrom GeomxTools shiftCountsOne setSegmentQCFlags setBioProbeQCFlags
#' aggregateCounts
#' @importFrom ggplot2 ggplot aes_string geom_histogram geom_vline facet_wrap
#' element_text ggtitle labs theme theme_bw guides scale_x_continuous
#' @importFrom gridExtra grid.arrange
#' @importFrom knitr kable
#' @importFrom NanoStringNCTools esBy negativeControlSubset assayDataApply sData
#' @importFrom patchwork plot_layout plot_annotation patchworkGrob wrap_plots
#' @export
#' @return A list of two objects:
#' - QC-filtered *NanoStringGeoMxSet* object with gene-level targets as features
#'  and the *QCFlags* data.frame appended to *protocolData* ("object")
#' - QC plots in a list of ggplot objects ("plot")

qcProc <-  function(object,
                   min.segment.reads = 1000,
                   percent.trimmed = 80,
                   percent.stitched = 80,
                   percent.aligned = 80,
                   percent.saturation = 50,
                   min.negative.count = 10,
                   max.ntc.count = 60,
                   min.nuclei = 200,
                   min.area = 16000,
                   min.probe.count = 10,
                   min.probe.ratio = 0.1,
                   outlier.test.alpha = 0.01,
                   percent.fail.grubbs = 20,
                   remove.local.outliers = FALSE,
                   shift.counts.zero = TRUE,
                   print.plots = FALSE) {
  # Prerun ####
  ## functions ####
  ## graphical summaries of QC statistics
  .qcHist <- function(assay.data = NULL,
                      annotation = NULL,
                      fill.by = NULL,
                      thr = NULL,
                      scale.trans = NULL) {
    plt <- ggplot(assay.data,
                  aes_string(
                    x = paste0("unlist(`", annotation, "`)"),
                    fill = fill.by
                  )) +
      geom_histogram(bins = 50) +
      geom_vline(xintercept = thr,
                 lty = "dashed",
                 color = "black") +
      theme_bw() + guides(fill = "none") +
      facet_wrap(as.formula(paste("~", fill.by)), nrow = 4) +
      labs(x = sub(" |_", "\n", tolower(annotation)), y = NULL) +
      theme(axis.text.x = element_text(
        angle = 60,
        vjust = 1,
        hjust = 1
      ))
    if (!is.null(scale.trans)) {
      plt <- plt +
        scale_x_continuous(trans = scale.trans)
    }
    plt
  }
  ## settings ####
  ## shift counts (useDALogic=TRUE adds 1 only to 0s)
  object <- shiftCountsOne(object, useDALogic = shift.counts.zero)
  ## list of user-defined segment QC params for annotations and variables
  ## expected to be always present in the input object
  qc.params <-
    list(
      minSegmentReads = min.segment.reads,
      percentTrimmed = percent.trimmed,
      percentStitched = percent.stitched,
      percentAligned = percent.aligned,
      percentSaturation = percent.saturation,
      minNegativeCount = min.negative.count
    )
  ## checks ####
  ## create alternative qc.params with qcProc args names for use in messages
  qc.params.alias <- qc.params
  names(qc.params.alias) <-
    c(
      "min.segment.reads",
      "percent.trimmed",
      "percent.stitched",
      "percent.aligned",
      "percent.saturation",
      "min.negative.count"
    )
  ## check whether required parameters are specified as numeric
  param.is.numeric <- sapply(qc.params.alias, is.numeric)
  if (!all(param.is.numeric)) {
    bad.param <- qc.params.alias[!param.is.numeric]
    message.info <-
      sprintf("%s is not numeric, please specify a numeric value\n",
              names(bad.param))
    stop(message.info)
  }
  ## check whether optional param are specified as numeric and found in the
  ## annotation table
  ## annotation columns names
  opt.columns <- c("NTC", "nuclei", "area")
  ## qc.params list with optional params
  opt.params <-
    list(
      "maxNTCCount" = max.ntc.count,
      "minNuclei" = min.nuclei,
      "minArea" = min.area
    )
  ## alternative qc params list named with DSPWorkflow args
  opt.params.alias <-
    list(
      "max.ntc.count" = max.ntc.count,
      "min.nuclei" = min.nuclei,
      "min.area" = min.area
    )
  ## check if params are NULL
  param.is.null <- sapply(opt.params.alias, is.null)
  ## check if params are numeric
  param.is.numeric <- sapply(opt.params.alias, is.numeric)
  ## check if params are found in the annotation
  param.is.found <-
    sapply(opt.columns, `%in%`, colnames(sData(object)))
  ## define bad params
  is.bad <- param.is.found & (param.is.null | !param.is.numeric)
  ## define good params
  is.good <- param.is.found & param.is.numeric
  ## warn if params are not found
  if (any(!param.is.found)) {
    ann.columns <- opt.columns[!param.is.found]
    params <- names(opt.params.alias)[!param.is.found]
    message.info <-
      sprintf(
        "%s not found in the annotation, %s will not be considered\n",
        paste(ann.columns, collapse = ", "),
        paste(params, collapse = ", ")
      )
    warning(message.info)
  }
  ## stop if there are bad params
  if (any(is.bad)) {
    ann.columns <- opt.columns[is.bad]
    bad.params <- names(opt.params.alias)[is.bad]
    message.info <-
      sprintf(
        "%s is part of the annotation, please specify a numeric value for %s\n",
        paste(ann.columns, collapse = ", "),
        paste(bad.params, collapse = ", ")
      )
    stop(message.info)
  }
  ## if there are add good params, add them to qc.params list
  if (any(is.good)) {
    opt.params <- opt.params[is.good]
    qc.params <- c(qc.params, opt.params)
  }
  # Segment QC ####
  ## add segment QC flags to protocolData
  object <- setSegmentQCFlags(object, qcCutoffs = qc.params)
  # collate QC results
  seg.qc.results <- protocolData(object)[["QCFlags"]]
  flag.columns <- colnames(seg.qc.results)
  seg.qc.summary <-
    data.frame(Pass = colSums(!seg.qc.results[, flag.columns]),
               Warning = colSums(seg.qc.results[, flag.columns]))
  seg.qc.results$QCStatus <- apply(seg.qc.results, 1L, function(x) {
    ifelse(sum(x) == 0L, "PASS", "WARNING")
  })
  seg.qc.summary["TOTAL FLAGS", ] <-
    c(sum(seg.qc.results[, "QCStatus"] == "PASS"),
      sum(seg.qc.results[, "QCStatus"] == "WARNING"))
  # Segment QC plots
  ## create plots for the required params
  color.by <- "segment"
  trimmed <-
    .qcHist(sData(object), "Trimmed (%)", color.by, percent.trimmed)
  aligned <-
    .qcHist(sData(object), "Aligned (%)", color.by, percent.aligned)
  stitched <-
    .qcHist(sData(object), "Stitched (%)", color.by, percent.stitched)
  saturated <-
    .qcHist(sData(object), "Saturated (%)", color.by, percent.saturation) +
    labs(x = "sequencing\nsaturation (%)")
  ## create plots for optional parameters (return NULL if not used)
  if (!is.null(qc.params$minNuclei)) {
    nuclei <- .qcHist(sData(object), "nuclei", color.by, min.nuclei)
  } else {
    nuclei <- NULL
  }
  if (!is.null(qc.params$minArea)) {
    area <-
      .qcHist(sData(object), "area", color.by, min.area, scale.trans = "log10")
  } else {
    area <- NULL
  }
  # Negative Controls ####
  ## negative control estimates
  ## calculate the negative geometric means for each module
  neg.gm <-
    esBy(
      negativeControlSubset(object),
      GROUP = "Module",
      FUN = function(x) {
        assayDataApply(x,
                       MARGIN = 2,
                       FUN = ngeoMean,
                       elt = "exprs")
      }
    )
  protocolData(object)[["NegGeoMean"]] <- neg.gm
  ## explicitly copy the Negative geoMeans from sData to pData
  pkcs <- annotation(object)
  modules <- gsub(".pkc", "", pkcs)
  neg.cols <- paste0("NegGeoMean_", modules)
  pData(object)[, neg.cols] <- sData(object)[["NegGeoMean"]]
  ## negative control plots
  for (ann in neg.cols) {
    neg.plot <-
      .qcHist(pData(object), ann, color.by, 2, scale.trans = "log10")
  }
  # Visualization ####
  ## list all plots
  plot.list <- list(
    "trimmed" = trimmed,
    "aligned" = aligned,
    "stitched" = stitched,
    "saturated" = saturated,
    "nuclei" = nuclei,
    "area" = area,
    "neg.plot" = neg.plot
  )
  ## remove NULL plots for optional params if not used
  find.plots <- sapply(plot.list, function(x) !is.null(x))
  plot.list <- plot.list[find.plots]
  ## print plots if TRUE
  if (print.plots) {
    patch <- wrap_plots(plot.list, nrow = 1, ncol = length(plot.list))
    print(
      patch +
        plot_annotation(
          title = "Quality Control (QC)",
          subtitle = "ROI/AOI Seqments",
          tag_levels = "A",
          theme = theme(text = element_text(color = "gray50"))
        )
    )
  }
  ## detach neg_geomean columns ahead of aggregateCounts call
  pData(object) <-
    pData(object)[, !colnames(pData(object)) %in% neg.cols]
  # Summarize & Remove Segments ####
  ## summarize NTC values (Frequency of Segments with a given NTC count)
  if (!is.null(qc.params$maxNTCCount)) {
    print(kable(
      table(NTC_Count = sData(object)$NTC),
      col.names = c("NTC Count", "# of Segments"),
      caption = "Summary for the NTC values"
    ))
  }
  ## summarize Segment QC call (Pass/Warning per QC parameter)
  print(kable(seg.qc.summary, caption = "QC Summary for each Segment"))
  ## object size before segment removal
  size.before <- dim(object)
  ## remove flagged segments
  object <- object[, seg.qc.results$QCStatus == "PASS"]
  ## object size after segment removal
  size.after <- dim(object)
  ## print object size before and after segment removal
  print(kable(
    data.frame(size.before, size.after),
    col.names = c("# Before Removal", "# After Removal"),
    caption = "Summary for Segment QC Removal"
  ))
  # Probe QC ####
  ## Generally keep the qcCutoffs parameters unchanged
  object <-
    setBioProbeQCFlags(
      object,
      qcCutoffs = list(
        minProbeRatio = min.probe.ratio,
        minSegmentReads = min.segment.reads,
        percentFailGrubbs = percent.fail.grubbs
      ),
      removeLocalOutliers = remove.local.outliers
    )
  probe.qc.results <- fData(object)[["QCFlags"]]
  ## define QC table for Probe QC
  probe.qc.df <-
    data.frame(
      Passed = sum(rowSums(probe.qc.results[, - 1]) == 0),
      Global = sum(probe.qc.results$GlobalGrubbsOutlier),
      Local = sum(
        rowSums(probe.qc.results[, - 2 : - 1]) > 0 &
          !probe.qc.results$GlobalGrubbsOutlier
      )
    )
  ## subset object to exclude all that did not pass Ratio & Global testing
  probe.qc.passed <-
    subset(object,
           fData(object)[["QCFlags"]][, c("LowProbeRatio")] == FALSE &
             fData(object)[["QCFlags"]][, c("GlobalGrubbsOutlier")] == FALSE)
  object <- probe.qc.passed
  ## summarize Probe QC removal
  print(kable(probe.qc.df,
              caption = "Summary for Probe QC Calls (Grubb's Outlier Test)"))
  size.before <- size.after
  size.after <- dim(object)
  print(kable(
    data.frame(size.before, size.after),
    col.names = c("# Before Removal", "# After Removal"),
    caption = "Summary for Probe QC Removal"
  ))
  # Gene-level Counts ####
  ## collapse targets
  object <- aggregateCounts(object)
  ## summarize target collapsing
  size.before <- size.after
  size.after <- dim(object)
  print(kable(
    data.frame(size.before, size.after),
    col.names = c("# Before Collapsing", "# After Collapsing"),
    caption = "Summary for Gene-level Counts"
  ))
  # Return ####
  output <- list("object" = object, "plot" = plot.list)
  invisible(output)
}
