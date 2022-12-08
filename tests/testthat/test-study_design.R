test_that("Load Kidney dataset", {
  # The data directory containing all PKC, DCC, and annotation files
  datadir <- "/rstudio-files/ccr-dceg-data/data/WTA_NGS_Example"
  
  DCCFiles <- dir(file.path(datadir, "dccs"), pattern = ".dcc$",
                  full.names = TRUE, recursive = TRUE)
  
  # Multiple PKC file grabber currently not functional
  PKCFiles <- unzip(dir(file.path(datadir, "pkcs"), pattern = ".pkc*",
              full.names = TRUE, recursive = TRUE))
  
  #PKCFiles <- "/rstudio-files/ccr-dceg-data/data/Kidney_Dataset//pkcs/TAP_H_WTA_v1.0.pkc"
  
  SampleAnnotationFile <- dir(file.path(datadir, "annotation"), pattern = ".xlsx$",
                              full.names = TRUE, recursive = TRUE)
  
  # Optional parameters for selecting annotation column names that are used by the GeoMX object
  DccColName <- "Sample_ID"
  ProtocolColNames <- c("aoi", "roi")
  ExperimentColNames = c("panel")
  AnnotationSheetName = "Template"
  

  dsp.list <- StudyDesign(dccFiles = DCCFiles, pkcFiles = PKCFiles,
                           phenoDataFile = SampleAnnotationFile,
                           phenoDataSheet = AnnotationSheetName,
                           phenoDataDccColName = DccColName,
                           protocolDataColNames = ProtocolColNames,
                           experimentDataColNames = ExperimentColNames)
  print(dsp.list$plot)
  expected.elements = c("plot", "dsp.obj")
  expect_setequal(names(dsp.list), expected.elements)
  #expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
})
