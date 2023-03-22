test_that("Normalization Success for Kidney", {
 
  kidney.dat <- selectDatasetNormalization("kidney")
  
  normalization.output <- do.call(geomxnorm,kidney.dat)
  
  expected.elements = c("multi.plot", "boxplot", "object")
  expect_setequal(names(normalization.output), expected.elements)
  
})

test_that("Normalization Success for thymus", {
  
  thymus.dat <- selectDatasetNormalization("thymus")
  
  normalization.output <- do.call(geomxnorm,thymus.dat)
  
  expected.elements = c("multi.plot", "boxplot", "object")
  expect_setequal(names(normalization.output), expected.elements)
  
})

test_that("Normalization Success for colon", {
  
  colon.dat <- selectDatasetNormalization("colon")
  
  normalization.output <- do.call(geomxnorm,colon.dat)
  
  expected.elements = c("multi.plot", "boxplot", "object")
  expect_setequal(names(normalization.output), expected.elements)
  
})

test_that("Normalization Success for nsclc", {
  
  nsclc.dat <- selectDatasetNormalization("nsclc")
  
  normalization.output <- do.call(geomxnorm,nsclc.dat)
  
  expected.elements = c("multi.plot", "boxplot", "object")
  expect_setequal(names(normalization.output), expected.elements)
  
})

test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")

  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$object <- c(1,2,3,5)
  expect_error(do.call(geomxnorm,kidney.dat), "Error: You have the wrong data class, must be NanoStringGeoMxSet")
})
  
test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$norm <- c("quantile")
  expect_error(do.call(geomxnorm,kidney.dat), "Error: quantile needs to be quant")
})

test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$norm <- c("Quantile")
  expect_error(do.call(geomxnorm,kidney.dat), "Error: Quantile needs to be quant")
})

test_that("Normalization Success", {
  kidney.dat <- selectDatasetNormalization("kidney")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$norm <- c("Quant")
  expect_error(do.call(geomxnorm,kidney.dat), "Error: Quant needs to be quant")
})


#
#test_that("Normalization Success", {
#  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
#  
#  expect_error(geomxnorm(target_demoDataNorm, "quantile"), "Error: quantile needs to be quant")
#})
#
#test_that("Normalization Success", {
#  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
#  
#  expect_error(geomxnorm(target_demoDataNorm, "Quantile"), "Error: Quantile needs to be quant")
#})
#
#test_that("Normalization Success", {
#  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
#  
#  expect_error(geomxnorm(target_demoDataNorm, "Neg"), "Error: Neg needs to be neg")
#})
#
#test_that("Normalization Success", {
#  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
#  
#  expect_error(geomxnorm(target_demoDataNorm, "negative"), "Error: negative needs to be neg")
#})
#
#test_that("Normalization Success", {
#  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
#  
#  expect_error(geomxnorm(target_demoDataNorm, "Negative"), "Error: Negative needs to be neg")
#})
#