library(devtools)
library(testthat)
load_all()

library(DSPWorkflow)
library(Rtsne)
library(umap)
library(NanoStringNCTools)
library(GeomxTools)


load("/rstudio-files/ccr-dceg-data/users/aleksandra/DSPWorkflow/target.Data.rda") 
output <- GeomxDimensionReduction(Object = target.Data, point.size = 1, point.alpha = 1)

test_that("DSP object and dimension reduction plots returned", {
  
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("dimension reductions present in DSP object", {
  
  expect_true(sum(grepl("PC1|PC2", colnames(pData(output$dsp.object)))) == 2)
  expect_true(sum(grepl("UMAP1|UMAP2", colnames(pData(output$dsp.object)))) == 2)
  expect_true(sum(grepl("tSNE1|tSNE2", colnames(pData(output$dsp.object))))== 2)
  
})

