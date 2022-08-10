
####This code comes from http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#4_QC__Pre-processing


# Shift counts to one
demoData <- shiftCountsOne(demoData, useDALogic = TRUE)

QC_params <-
  list(minSegmentReads = 1000, # Minimum number of reads (1000)
       percentTrimmed = 80,    # Minimum % of reads trimmed (80%)
       percentStitched = 80,   # Minimum % of reads stitched (80%)
       percentAligned = 75,    # Minimum % of reads aligned (80%)
       percentSaturation = 50, # Minimum sequencing saturation (50%)
       minNegativeCount = 1,   # Minimum negative control counts (10)
       maxNTCCount = 9000,     # Maximum counts observed in NTC well (1000)
       minNuclei = 20,         # Minimum # of nuclei estimated (100)
       minArea = 1000)         # Minimum segment area (5000)
demoData <-
  setSegmentQCFlags(demoData, 
                    qcCutoffs = QC_params)        

# Collate QC Results
QCResults <- protocolData(demoData)[["QCFlags"]]
flag_columns <- colnames(QCResults)
QC_Summary <- data.frame(Pass = colSums(!QCResults[, flag_columns]),
                         Warning = colSums(QCResults[, flag_columns]))
QCResults$QCStatus <- apply(QCResults, 1L, function(x) {
  ifelse(sum(x) == 0L, "PASS", "WARNING")
})
QC_Summary["TOTAL FLAGS", ] <-
  c(sum(QCResults[, "QCStatus"] == "PASS"),
    sum(QCResults[, "QCStatus"] == "WARNING"))

library(ggplot2)

col_by <- "segment"

# Graphical summaries of QC statistics plot function
QC_histogram <- function(assay_data = NULL,
                         annotation = NULL,
                         fill_by = NULL,
                         thr = NULL,
                         scale_trans = NULL) {
  plt <- ggplot(assay_data,
                aes_string(x = paste0("unlist(`", annotation, "`)"),
                           fill = fill_by)) +
    geom_histogram(bins = 50) +
    geom_vline(xintercept = thr, lty = "dashed", color = "black") +
    theme_bw() + guides(fill = "none") +
    facet_wrap(as.formula(paste("~", fill_by)), nrow = 4) +
    labs(x = annotation, y = "Segments, #", title = annotation)
  if(!is.null(scale_trans)) {
    plt <- plt +
      scale_x_continuous(trans = scale_trans)
  }
  plt
}

QC_histogram(sData(demoData), "Trimmed (%)", col_by, 80)

QC_histogram(sData(demoData), "Aligned (%)", col_by, 75)


QC_histogram(sData(demoData), "Saturated (%)", col_by, 50) +
  labs(title = "Sequencing Saturation (%)",
       x = "Sequencing Saturation (%)")

QC_histogram(sData(demoData), "area", col_by, 1000, scale_trans = "log10")


QC_histogram(sData(demoData), "nuclei", col_by, 20)


negativeGeoMeans <- 
  esBy(negativeControlSubset(demoData), 
       GROUP = "Module", 
       FUN = function(x) { 
         assayDataApply(x, MARGIN = 2, FUN = ngeoMean, elt = "exprs") 
       }) 
protocolData(demoData)[["NegGeoMean"]] <- negativeGeoMeans

# explicitly copy the Negative geoMeans from sData to pData
negCols <- paste0("NegGeoMean_", modules)
pData(demoData)[, negCols] <- sData(demoData)[["NegGeoMean"]]
for(ann in negCols) {
  plt <- QC_histogram(pData(demoData), ann, col_by, 2, scale_trans = "log10")
  print(plt)
}

pData(demoData) <- pData(demoData)[, !colnames(pData(demoData)) %in% negCols]

# show all NTC values, Freq = # of Segments with a given NTC count:
kable(table(NTC_Count = sData(demoData)$NTC),
      col.names = c("NTC Count", "# of Segments"))

kable(QC_Summary, caption = "QC Summary Table for each Segment")

demoData <- demoData[, QCResults$QCStatus == "PASS"]

# Subsetting our dataset has removed samples which did not pass QC
dim(demoData)
#> Features  Samples 
#>    18642      229

# Generally keep the qcCutoffs parameters unchanged. Set removeLocalOutliers to 
# FALSE if you do not want to remove local outliers
demoData <- setBioProbeQCFlags(demoData, 
                               qcCutoffs = list(minProbeRatio = 0.1,
                                                percentFailGrubbs = 20), 
                               removeLocalOutliers = TRUE)

ProbeQCResults <- fData(demoData)[["QCFlags"]]

# Define QC table for Probe QC
qc_df <- data.frame(Passed = sum(rowSums(ProbeQCResults[, -1]) == 0),
                    Global = sum(ProbeQCResults$GlobalGrubbsOutlier),
                    Local = sum(rowSums(ProbeQCResults[, -2:-1]) > 0
                                & !ProbeQCResults$GlobalGrubbsOutlier))

#Subset object to exclude all that did not pass Ratio & Global testing
ProbeQCPassed <- 
  subset(demoData, 
         fData(demoData)[["QCFlags"]][,c("LowProbeRatio")] == FALSE &
           fData(demoData)[["QCFlags"]][,c("GlobalGrubbsOutlier")] == FALSE)
dim(ProbeQCPassed)
#> Features  Samples 
#>    18641      229
demoData <- ProbeQCPassed 

# Check how many unique targets the object has
length(unique(featureData(demoData)[["TargetName"]]))
#> [1] 18504

# collapse to targets
target_demoData <- aggregateCounts(demoData)
dim(target_demoData)
#> Features  Samples 
#>    18504      229
exprs(target_demoData)[1:5, 1:2]
#>       DSP-1001250007851-H-A02.dcc DSP-1001250007851-H-A03.dcc
#> A2M                           485                         262
#> NAT2                           15                          18
#> ACADM                          31                          15
#> ACADS                          27                          17
#> ACAT1                          29                          24