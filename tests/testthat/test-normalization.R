test_that("Normalization Success for Kidney", {
 
  kidney.dat <- selectDatasetNormalization("kidney")
  
  normalization.output <- do.call(geomxNorm,kidney.dat)
  
  expected.elements = c("multi.plot", "boxplot.raw", "boxplot.norm", "object")
  expect_setequal(names(normalization.output), expected.elements)
  
})

test_that("Normalization Success for thymus", {
  
  thymus.dat <- selectDatasetNormalization("thymus")
  
  normalization.output <- do.call(geomxNorm,thymus.dat)
  
  expected.elements = c("multi.plot", "boxplot.raw", "boxplot.norm", "object")
  expect_setequal(names(normalization.output), expected.elements)
  
})

test_that("Normalization Success for colon", {
  
  colon.dat <- selectDatasetNormalization("colon")
  
  normalization.output <- do.call(geomxNorm,colon.dat)
  
  expected.elements = c("multi.plot", "boxplot.raw", "boxplot.norm",  "object")
  expect_setequal(names(normalization.output), expected.elements)
  
})

test_that("Normalization Success for nsclc", {
  
  nsclc.dat <- selectDatasetNormalization("nsclc")
  
  normalization.output <- do.call(geomxNorm,nsclc.dat)
  
  expected.elements = c("multi.plot", "boxplot.raw", "boxplot.norm",  "object")
  expect_setequal(names(normalization.output), expected.elements)
  
})

test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")

  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$object <- c(1,2,3,5)
  expect_error(do.call(geomxNorm,kidney.dat), "Error: You have the wrong data class, must be NanoStringGeoMxSet")
})
  
test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$norm <- c("quantile")
  expect_error(do.call(geomxNorm,kidney.dat), "Error: quantile needs to be q3")
})

test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$norm <- c("Quantile")
  expect_error(do.call(geomxNorm,kidney.dat), "Error: Quantile needs to be q3")
})

test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$norm <- c("quant")
  expect_error(do.call(geomxNorm,kidney.dat), "Error: quant needs to be q3")
})

test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$norm <- c("negative")
  expect_error(do.call(geomxNorm,kidney.dat), "Error: negative needs to be neg")
})

test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$norm <- c("Negative")
  expect_error(do.call(geomxNorm,kidney.dat), "Error: Negative needs to be neg")
})

test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$norm <- c("Neg")
  expect_error(do.call(geomxNorm,kidney.dat), "Error: Neg needs to be neg")
})
