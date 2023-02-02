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

