test_that("Normalization Success", {
  #load("/rstudio-files/ccr-dceg-data/users/Chad/DSP/tests/testthat/fixtures/target_demoDataNorm.Rdata") 
  target_demoDataNorm <- readRDS(test_path("fixtures", "target_demoDataNorm.rds"))
 
  dsp.list <- GeoMxNorm(target_demoDataNorm, "quant")
  #dsp.list <- GeoMxNorm(Data = target_demoData, Norm = "quant")
  expected.elements = c("plot", "boxplot")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
})