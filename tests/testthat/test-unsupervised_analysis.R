test_that("Test Human Kidney dataset", {
  
  kidney.dat <- select_normalized_RTD("kidney")
  
  output <-
    DimReduct(
      object = kidney.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Colon Dataset", {
  
  colon.dat <- select_normalized_RTD("colon")
  
  output <-
    DimReduct(
      object = colon.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Mouse Thymus Dataset", {
  
  thymus.dat <- select_normalized_RTD("thymus")
  
  output <-
    DimReduct(
      object = thymus.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Human NSCLC Dataset", {
  
  nsclc.dat <- select_normalized_RTD("nsclc")
  
  output <-
    DimReduct(
      object = nsclc.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("dsp.object", "plot.list")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("dimension reductions present in DSP object", {
  
  kidney.dat <- select_normalized_RTD("kidney")
  
  output <-
    DimReduct(
      object = kidney.dat,
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

test_that("Check warning message when replacing pre-existing analysis", {
  
  kidney.dat <- select_normalized_RTD("kidney")
  
  output <-
    DimReduct(
      object = kidney.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  
  # Run again with different parameters to replace previous analysis
  expect_warning(DimReduct(
                     object = output$dsp.object,
                     point.size = 5,
                     point.alpha = 5,
                     color.variable1 = "region",
                     shape.variable = "segment"
                   ), "found in the input DSP object and will be replaced by this calculation")
  
})
