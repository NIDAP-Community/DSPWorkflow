test_that("Test Human Kidney dataset", {
  
  kidney_dat <- select_dataset_qc("kidney")
  
  output <- do.call(QcProc,kidney_dat)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Colon Dataset", {
  
  colon_dat <- select_dataset_qc("colon")
  
  output <- do.call(QcProc,colon_dat)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Mouse Thymus Dataset", {
  
  thymus_dat <- select_dataset_qc("thymus")
  
  output <- do.call(QcProc,thymus_dat)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Human NSCLC Dataset", {
  
  nsclc_dat <- select_dataset_qc("nsclc")
  
  output <- do.call(QcProc,nsclc_dat)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Check for an error message when running QC for a dataset with a required parameter listed as a string", {
  
  kidney_dat <- select_dataset_qc("kidney")
  thymus_dat <- select_dataset_qc("thymus")
  
  # Assign strings to a required parameter
  kidney_dat$minSegmentReads <- "one thousand"
  thymus_dat$percentAligned <- "80"
  
  expect_error(do.call(QcProc,kidney_dat), fixed=TRUE, "minSegmentReads is not numeric. Please specify a numeric value.\n")
  expect_error(do.call(QcProc,thymus_dat), fixed=TRUE, "percentAligned is not numeric. Please specify a numeric value.\n")
  
})

test_that("Check for a warning message when running QC for a dataset missing an optional parameter", {
  
  colon_dat <- select_dataset_qc("colon")
  nsclc_dat <- select_dataset_qc("nsclc")
  
  expect_warning(do.call(QcProc,colon_dat), "Nuclei is not found in the annotation")
  expect_warning(do.call(QcProc,nsclc_dat), "NTC is not found in the annotation")
  
})

#test_that("Check for an error message when running QC for a dataset with an optional parameter listed as NULL", {
  
#  kidney_dat <- select_dataset_qc("kidney")
#  thymus_dat <- select_dataset_qc("thymus")
  
  # Assign strings to a required parameter
#  kidney_dat$minNuclei <- NULL
#  thymus_dat$minArea <- NULL
  
#  expect_error(do.call(QcProc,kidney_dat), fixed=TRUE, "Nuclei is part of the annotation, please specify a numeric value for minNuclei.\n")
#  expect_error(do.call(QcProc,thymus_dat), fixed=TRUE, "Area is part of the annotation, please specify a numeric value for minArea.\n")
  
#})



