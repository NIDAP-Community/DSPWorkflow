test_that("Test Human Kidney dataset", {
  
  kidney_dat <- select_normalized_RTD("kidney")
  
  output <-
    DimReduct(
      object = kidney_dat$inputObject,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Colon Dataset", {
  
  colon_dat <- select_normalized_RTD("colon")
  
  output <-
    DimReduct(
      object = colon_dat$inputObject,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Mouse Thymus Dataset", {
  
  thymus_dat <- select_normalized_RTD("thymus")
  
  output <-
    DimReduct(
      object = thymus_dat$inputObject,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Human NSCLC Dataset", {
  
  nsclc_dat <- select_normalized_RTD("nsclc")
  
  output <-
    DimReduct(
      object = nsclc_dat$inputObject,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("dimension reductions present in DSP object", {
  
  kidney_dat <- select_normalized_RTD("kidney")
  
  output <-
    DimReduct(
      object = kidney_dat$inputObject,
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
