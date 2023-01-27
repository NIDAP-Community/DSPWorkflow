test_that("Test Human Kidney dataset", {
  
  kidney_dat <- select_dataset_qc("kidney")
  
  output <- QcProc(
    object = kidney_dat$inputObject,
    minSegmentReads = kidney_dat$minSegmentReads, 
    percentTrimmed = kidney_dat$percentTrimmed,    
    percentStitched = kidney_dat$percentStitched,   
    percentAligned = kidney_dat$percentAligned,    
    percentSaturation = kidney_dat$percentSaturation, 
    minNegativeCount = kidney_dat$minNegativeCount,   
    maxNTCCount = kidney_dat$maxNTCCount,     
    minNuclei = kidney_dat$minNuclei,         
    minArea = kidney_dat$minArea)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Colon Dataset", {
  
  colon_dat <- select_dataset_qc("colon")
  
  dsp.obj <- colon_dat$inputObject
  output <- QcProc(
    object = colon_dat$inputObject,
    minSegmentReads = colon_dat$minSegmentReads, 
    percentTrimmed = colon_dat$percentTrimmed,    
    percentStitched = colon_dat$percentStitched,   
    percentAligned = colon_dat$percentAligned,    
    percentSaturation = colon_dat$percentSaturation, 
    minNegativeCount = colon_dat$minNegativeCount,   
    maxNTCCount = colon_dat$maxNTCCount,     
    minNuclei = colon_dat$minNuclei,         
    minArea = colon_dat$minArea)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Mouse Thymus Dataset", {
  
  thymus_dat <- select_dataset_qc("thymus")
  
  dsp.obj <- thymus_dat$inputObject
  output <- QcProc(
    object = thymus_dat$inputObject,
    minSegmentReads = thymus_dat$minSegmentReads, 
    percentTrimmed = thymus_dat$percentTrimmed,    
    percentStitched = thymus_dat$percentStitched,   
    percentAligned = thymus_dat$percentAligned,    
    percentSaturation = thymus_dat$percentSaturation, 
    minNegativeCount = thymus_dat$minNegativeCount,   
    maxNTCCount = thymus_dat$maxNTCCount,     
    minNuclei = thymus_dat$minNuclei,         
    minArea = thymus_dat$minArea)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Human NSCLC Dataset", {
  
  nsclc_dat <- select_dataset_qc("nsclc")
  
  dsp.obj <- nsclc_dat$inputObject
  output <- QcProc(
    object = nsclc_dat$inputObject,
    minSegmentReads = nsclc_dat$minSegmentReads, 
    percentTrimmed = nsclc_dat$percentTrimmed,    
    percentStitched = nsclc_dat$percentStitched,   
    percentAligned = nsclc_dat$percentAligned,    
    percentSaturation = nsclc_dat$percentSaturation, 
    minNegativeCount = nsclc_dat$minNegativeCount,   
    maxNTCCount = nsclc_dat$maxNTCCount,     
    minNuclei = nsclc_dat$minNuclei,         
    minArea = nsclc_dat$minArea)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

