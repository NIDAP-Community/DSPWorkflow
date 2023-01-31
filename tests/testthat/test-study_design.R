test_that("Test Kidney dataset", {
  
  kidney_dat <- select_dataset_sd("kidney")
  
  study_design_ouput <- do.call(StudyDesign,kidney_dat)
  
  #dsp.list <- StudyDesign(dccFiles = kidney_dat$DCCFiles, pkcFiles = kidney_dat$PKCFiles,
  #                        phenoDataFile = kidney_dat$SampleAnnotationFile,
  #                        phenoDataSheet = kidney_dat$AnnotationSheetName,
  #                        phenoDataDccColName = kidney_dat$DccColName,
  #                        protocolDataColNames = kidney_dat$ProtocolColNames,
  #                        experimentDataColNames = kidney_dat$ExperimentColNames)

  expected.elements = c("plot", "dsp.obj")
  expect_setequal(names(study_design_output), expected.elements)
  
})

test_that("Test Colon Dataset", {
  
  colon_dat <- select_dataset_sd("colon")
  
  dsp.list <- StudyDesign(dccFiles = colon_dat$DCCFiles, pkcFiles = colon_dat$PKCFiles,
                          phenoDataFile = colon_dat$SampleAnnotationFile,
                          phenoDataSheet = colon_dat$AnnotationSheetName,
                          phenoDataDccColName = colon_dat$DccColName,
                          protocolDataColNames = colon_dat$ProtocolColNames,
                          experimentDataColNames = colon_dat$ExperimentColNames)
  
  expected.elements = c("plot", "dsp.obj")
  expect_setequal(names(dsp.list), expected.elements)
  
})

test_that("Test Mouse Thymus Dataset", {
  
  thymus_dat <- select_dataset_sd("thymus")
  
  dsp.list <- StudyDesign(dccFiles = thymus_dat$DCCFiles, pkcFiles = thymus_dat$PKCFiles,
                          phenoDataFile = thymus_dat$SampleAnnotationFile,
                          phenoDataSheet = thymus_dat$AnnotationSheetName,
                          phenoDataDccColName = thymus_dat$DccColName,
                          protocolDataColNames = thymus_dat$ProtocolColNames,
                          experimentDataColNames = thymus_dat$ExperimentColNames)
  
  expected.elements = c("plot", "dsp.obj")
  expect_setequal(names(dsp.list), expected.elements)
  
})

test_that("Test Human NSCLC Dataset", {
  
  nsclc_dat <- select_dataset_sd("nsclc")
  
  dsp.list <- StudyDesign(dccFiles = nsclc_dat$DCCFiles, pkcFiles = nsclc_dat$PKCFiles,
                          phenoDataFile = nsclc_dat$SampleAnnotationFile,
                          phenoDataSheet = nsclc_dat$AnnotationSheetName,
                          phenoDataDccColName = nsclc_dat$DccColName,
                          protocolDataColNames = nsclc_dat$ProtocolColNames,
                          experimentDataColNames = nsclc_dat$ExperimentColNames)
  
  expected.elements = c("plot", "dsp.obj")
  expect_setequal(names(dsp.list), expected.elements)
  
})

