test_that("DSP object and dimension reduction plots returned", {
  
  target.Data <- readRDS(test_path("fixtures", "target.Data.rds"))
  output <-
    DimReduct(
      object = target.Data,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("dimension reductions present in DSP object", {
  load(test_path("fixtures", "target.Data.rda"))
  output <-
    DimReduct(
      object = target.Data,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  
  expect_true(sum(grepl("PC1|PC2", colnames(
    pData(output$dsp.object)
  ))) == 2)
  expect_true(sum(grepl("UMAP1|UMAP2", colnames(
    pData(output$dsp.object)
  ))) == 2)
  expect_true(sum(grepl("tSNE1|tSNE2", colnames(
    pData(output$dsp.object)
  ))) == 2)
  
})
