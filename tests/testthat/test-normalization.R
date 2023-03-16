test_that("Normalization Success for Kidney", {
  #load("/rstudio-files/ccr-dceg-data/users/Chad/DSP/tests/testthat/fixtures/target_demoDataNorm.Rdata") 
  #target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
 
  
  target_demoDataNorm<- selectNormalizedRtd("kidney")
  
  dsp.list <- geomxnorm(target_demoDataNorm$object, "quant")
  #dsp.list <- GeoMxNorm(Data = target_demoData, Norm = "quant")
  expected.elements = c("plot", "Boxplot", "Normalized Dataframe")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
})

test_that("Normalization Success for thymus", {
  #load("/rstudio-files/ccr-dceg-data/users/Chad/DSP/tests/testthat/fixtures/target_demoDataNorm.Rdata") 
  #target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
  
  target_demoDataNorm<- selectNormalizedRtd("thymus")
  
  dsp.list <- geomxnorm(target_demoDataNorm$object, "quant")
  #dsp.list <- GeoMxNorm(Data = target_demoData, Norm = "quant")
  expected.elements = c("plot", "Boxplot", "Normalized Dataframe")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
})

test_that("Normalization Success for colon", {
  #load("/rstudio-files/ccr-dceg-data/users/Chad/DSP/tests/testthat/fixtures/target_demoDataNorm.Rdata") 
  #target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
  
  target_demoDataNorm<- selectNormalizedRtd("colon")
  
  dsp.list <- geomxnorm(target_demoDataNorm$object, "quant")
  #dsp.list <- GeoMxNorm(Data = target_demoData, Norm = "quant")
  expected.elements = c("plot", "Boxplot", "Normalized Dataframe")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
})

test_that("Normalization Success for nsclc", {
  #load("/rstudio-files/ccr-dceg-data/users/Chad/DSP/tests/testthat/fixtures/target_demoDataNorm.Rdata") 
  #target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
  
  target_demoDataNorm<- selectNormalizedRtd("nsclc")
  
  dsp.list <- geomxnorm(target_demoDataNorm$object, "quant")
  #dsp.list <- GeoMxNorm(Data = target_demoData, Norm = "quant")
  expected.elements = c("plot", "Boxplot", "Normalized Dataframe")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
})

test_that("Normalization Success", {
  target_demoDataNorm <- c(1,2,3,5)
  
  expect_error(geomxnorm(target_demoDataNorm, "quant"), "Error: You have the wrong data class, must be NanoStringGeoMxSet")
})

test_that("Normalization Success", {
  #target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
  target_demoDataNorm<- select_dataset_normalization("kidney")
  
  expect_error(geomxnorm(target_demoDataNorm$object, "Quant"), "Error: Quant needs to be quant")
})

test_that("Normalization Success", {
  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
  
  expect_error(geomxnorm(target_demoDataNorm, "quantile"), "Error: quantile needs to be quant")
})

test_that("Normalization Success", {
  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
  
  expect_error(geomxnorm(target_demoDataNorm, "Quantile"), "Error: Quantile needs to be quant")
})

test_that("Normalization Success", {
  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
  
  expect_error(geomxnorm(target_demoDataNorm, "Neg"), "Error: Neg needs to be neg")
})

test_that("Normalization Success", {
  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
  
  expect_error(geomxnorm(target_demoDataNorm, "negative"), "Error: negative needs to be neg")
})

test_that("Normalization Success", {
  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
  
  expect_error(geomxnorm(target_demoDataNorm, "Negative"), "Error: Negative needs to be neg")
})
