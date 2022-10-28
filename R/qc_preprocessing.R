####This code comes from 
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#4_QC__Pre-processing


#' QcProc: Quality Control and Preprocessing
#'
#' Selects ROI/AOI segments and target probes based on quality control and then generates gene-level count data.
#' 
#' A probe is removed globally from the dataset if either it does not reach the *minProbeRatio* threshold or the probe is an outlier according to Grubb’s test in at least *percentFailGrubbs* of segments. A probe is removed locally (from a given segment) if the probe is an outlier in that segment and *removeLocalOtliers* is set to TRUE (default).
#' 
#' The count for any gene with multiple probes per segment is calculated as the geometric mean of those probes.
#'
#' @param object object of class *NanoStringGeoMxSet* with raw data and metadata supplied
#' @param minSegmentReads minimum number of reads
#' @param percentTrimmed minimum % of reads trimmed
#' @param percentStitched minimum % of reads stitched
#' @param percentAligned minimum % of reads aligned
#' @param percentSaturation minimum sequencing saturation
#' @param minNegativeCount minimum negative control counts
#' @param maxNTCCount maximum counts observed in NTC well
#' @param minNuclei minimum # of nuclei estimated
#' @param minArea minimum segment area
#' @param minProbeRatio numeric between 0 and 1 to flag probes that have (geomean probe in all segments) / (geomean probes within target) less than or equal to this ratio
#' @param outlierTestAlpha significance cut-off for Grubb's test to flag outlier probes
#' @param percentFailGrubbs numeric to flag probes that fail Grubb's test in greater than or equal this percent of segments
#' @param removeLocalOutliers boolean to determine if local outliers should be excluded from exprs matrix
#' 
#' @importFrom Biobase protocolData pData fData featureData
#' @importFrom BiocGenerics annotation
#' @importFrom GeomxTools shiftCountsOne setSegmentQCFlags setBioProbeQCFlags aggregateCounts
#' @importFrom ggplot2 ggplot aes_string geom_histogram geom_vline facet_wrap element_text ggtitle labs theme theme_bw guides scale_x_continuous
#' @importFrom gridExtra grid.arrange
#' @importFrom knitr kable
#' @importFrom NanoStringNCTools esBy negativeControlSubset assayDataApply sData
#' @importFrom patchwork plot_layout plot_annotation patchworkGrob
#'
#' @export
#' @return A list of two objects: QC-filtered *NanoStringGeoMxSet* object with gene-level targets as features and the *QCFlags* data frame appended to *protocolData* and QC plots
#' 
#' 
#' 
QcProc <- function(object,
                   minSegmentReads = 1000,
                   percentTrimmed = 80,
                   percentStitched = 80,
                   percentAligned = 80,
                   percentSaturation = 50,
                   minNegativeCount = 10,
                   maxNTCCount = 1000,         # DIF 60
                   minNuclei = 100,            # DIF 200
                   minArea = 5000,             # DIF 16000
                   minProbeRatio = 0.1,
                   outlierTestAlpha = 0.01,    # MIS
                   percentFailGrubbs = 20,
                   removeLocalOutliers = TRUE
                   )
{
  # DEFAULTS <- list() #from https://github.com/Nanostring-Biostats/GeomxTools/blob/master/R/NanoStringGeoMxSet-qc.R
  # #loqCutoff = 1.0,            # MIS
  # highCountCutoff = 10000     # MIS
                 
                  
                  
  # Functions ====
  
  ## graphical summaries of QC statistics plot function
  QcHist <- function(assay_data = NULL,
                     annotation = NULL,
                     fill_by = NULL,
                     thr = NULL,
                     scale_trans = NULL) {
    plt <- ggplot(assay_data,
                  aes_string(
                    x = paste0("unlist(`", annotation, "`)"),
                    fill = fill_by
                  )) +
      geom_histogram(bins = 50) +
      geom_vline(xintercept = thr,
                 lty = "dashed",
                 color = "black") +
      theme_bw() + guides(fill = "none") +
      facet_wrap(as.formula(paste("~", fill_by)), nrow = 4) +
      labs(x = sub(" |_", "\n", tolower(annotation)), y = NULL) +
      theme(axis.text.x = element_text(angle = 60, vjust = 1, hjust=1))
    if (!is.null(scale_trans)) {
      plt <- plt +
        scale_x_continuous(trans = scale_trans)
    }
    plt
  }
  
  # Segment QC (4.1) ====
  
  ## shift counts to one
  object = shiftCountsOne(object, useDALogic = TRUE)
  
  ## assess sequencing quality and adequate tissue sampling for every ROI/AOI segment
  qc.params <-
    list(
      minSegmentReads = minSegmentReads,
      percentTrimmed = percentTrimmed,
      percentStitched = percentStitched,
      percentAligned = percentAligned,
      percentSaturation = percentSaturation,
      minNegativeCount = minNegativeCount,
      maxNTCCount = maxNTCCount,
      minNuclei = minNuclei,
      minArea = minArea
    )
  
  # set segment QC flags
  object <- setSegmentQCFlags(object, qcCutoffs = qc.params)
  
  # collate QC Results
  seg.qc.results <- protocolData(object)[["QCFlags"]]
  
  flag_columns <- colnames(seg.qc.results)
  
  seg.qc.summary <-
    data.frame(Pass = colSums(!seg.qc.results[, flag_columns]),
               Warning = colSums(seg.qc.results[, flag_columns]))
  
  seg.qc.results$QCStatus <- apply(seg.qc.results, 1L, function(x) {
    ifelse(sum(x) == 0L, "PASS", "WARNING")
  })
  
  seg.qc.summary["TOTAL FLAGS", ] <-
    c(sum(seg.qc.results[, "QCStatus"] == "PASS"), sum(seg.qc.results[, "QCStatus"] == "WARNING"))
  
  # Visualize Segment QC ====
  
  color.by <- "segment"
  trimmed <- QcHist(sData(object), "Trimmed (%)", color.by, percentTrimmed)
  aligned <- QcHist(sData(object), "Aligned (%)", color.by, percentAligned)
  stitched <- QcHist(sData(object), "Stitched (%)", color.by, percentStitched)
  saturated <-
    QcHist(sData(object), "Saturated (%)", color.by, percentSaturation) +
    labs(x = "sequencing\nsaturation (%)")
  area <-
    QcHist(sData(object), "area", color.by, minArea, scale_trans = "log10")
  nuclei <- QcHist(sData(object), "nuclei", color.by, minNuclei)
  
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
  for (ann in neg.cols) {
    neg.plot <-
      QcHist(pData(object), ann, color.by, 2, scale_trans = "log10")
  }
  
  segments.plot = trimmed + aligned + stitched + saturated + nuclei + area + neg.plot +
    plot_layout(nrow=1) + plot_annotation(
      title = "Quality Control (QC)",
      subtitle = "ROI/AOI Seqments",
      tag_levels = "A",
      caption = "DSPWorkflow::QcProc()",
      theme = theme(
        text = element_text(color = 'gray50'),
        plot.caption = element_text(face = 'italic')
      )
    )
      
  segments.plot <- patchworkGrob(segments.plot)
  segments.plot <- grid.arrange(segments.plot, left = "Segments, #")
  
  pData(object) <-
    pData(object)[, !colnames(pData(object)) %in% neg.cols]
  
  #show all NTC values, Freq =  of Segments with a given NTC count:
  kable(table(NTC_Count = sData(object)$NTC),
        col.names = c("NTC Count", " of Segments"))
  kable(seg.qc.summary, caption = "QC Summary Table for each Segment")
  
  ## Remove flagged segments
  object <- object[, seg.qc.results$QCStatus == "PASS"]
  dim(object)
  
  
  # Probe QC Flags (4.2) ====

  ## Generally keep the qcCutoffs parameters unchanged
  
  object <-
    setBioProbeQCFlags(
      object,
      qcCutoffs = list(
        minProbeRatio = minProbeRatio,
        minSegmentReads = minSegmentReads,
        percentFailGrubbs = percentFailGrubbs
      ),
      removeLocalOutliers = removeLocalOutliers
    )
  probe.qc.results <- fData(object)[["QCFlags"]]
  
  ## Define QC table for Probe QC
  probe.qc.df <-
    data.frame(
      Passed = sum(rowSums(probe.qc.results[, -1]) == 0),
      Global = sum(probe.qc.results$GlobalGrubbsOutlier),
      Local = sum(
        rowSums(probe.qc.results[, -2:-1]) > 0 &
          !probe.qc.results$GlobalGrubbsOutlier
      )
    )
  
  ## Subset object to exclude all that did not pass Ratio & Global testing
  probe.qc.passed <-
    subset(object,
           fData(object)[["QCFlags"]][, c("LowProbeRatio")] == FALSE &
             fData(object)[["QCFlags"]][, c("GlobalGrubbsOutlier")] == FALSE)
  dim(probe.qc.passed)
  object <- probe.qc.passed
  
  
  # Gene-level Counts (4.3) ====
  
  ## Check how many unique targets the object has
  length(unique(featureData(object)[["TargetName"]]))
  
  ## collapse to targets
  dsp.target <- aggregateCounts(object)
  dim(dsp.target)
  
  return(list(dsp.target = dsp.target, segments.qc = segments.plot))
  
}
