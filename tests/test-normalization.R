load_all()
library(DSPWorkflow)

test_that("Normalization Success", {
  load("/rstudio-files/ccr-dceg-data/users/Chad/target_demoData.Rdata") 
  
  dsp.list <- GeoMxNorm(Data = target_demoData, Norm = "neg")
  print(dsp.list$boxplot)
  expected.elements = c("plot", "boxplot")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})