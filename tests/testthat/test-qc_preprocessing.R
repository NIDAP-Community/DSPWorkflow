test_that("Test Human Kidney dataset", {
  
  kidney.dat <- selectDatasetQC("kidney")
  
  output <- do.call(QcProc,kidney.dat)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Colon Dataset", {
  
  colon.dat <- selectDatasetQC("colon")
  
  output <- do.call(QcProc,colon.dat)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Mouse Thymus Dataset", {
  
  thymus.dat <- selectDatasetQC("thymus")
  
  output <- do.call(QcProc,thymus.dat)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Human NSCLC Dataset", {
  
  nsclc.dat <- selectDatasetQC("nsclc")
  
  output <- do.call(QcProc,nsclc.dat)
  
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Check for an error message when running QC for a dataset with a required parameter listed as a string", {
  
  kidney.dat <- selectDatasetQC("kidney")
  thymus.dat <- selectDatasetQC("thymus")
  
  # Assign strings to a required parameter
  kidney.dat$minSegmentReads <- "one thousand"
  thymus.dat$percentAligned <- "80"
  
  expect_error(do.call(QcProc,kidney.dat), fixed=TRUE, "minSegmentReads is not numeric. Please specify a numeric value.\n")
  expect_error(do.call(QcProc,thymus.dat), fixed=TRUE, "percentAligned is not numeric. Please specify a numeric value.\n")
  
})

test_that("Check for a warning message when running QC for a dataset missing an optional parameter", {
  
  colon.dat <- selectDatasetQC("colon")
  nsclc.dat <- selectDatasetQC("nsclc")
  
  expect_warning(do.call(QcProc,colon.dat), "Nuclei is not found in the annotation")
  expect_warning(do.call(QcProc,nsclc.dat), "NTC is not found in the annotation")
  
})

test_that("Check for an error message when running QC for a dataset with an optional parameter listed as NULL", {
  
  kidney.dat <- selectDatasetQC("kidney")
  thymus.dat <- selectDatasetQC("thymus")
  
  # Assign strings to a required parameter
  kidney.dat$minNuclei <- NULL
  thymus.dat$minArea <- NULL
  
  expect_error(do.call(QcProc,kidney.dat), fixed=TRUE, "Nuclei is part of the annotation, please specify a numeric value for minNuclei.\n")
  expect_error(do.call(QcProc,thymus.dat), fixed=TRUE, "Area is part of the annotation, please specify a numeric value for minArea.\n")
  
})



