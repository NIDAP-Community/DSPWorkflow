test_that("Test Human Kidney dataset", {
  
  kidney.dat <- select_normalized_RTD("kidney")
  
  output <-
    dimReduct(
      object = kidney.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("object", "plot")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Colon Dataset", {
  
  colon.dat <- select_normalized_RTD("colon")
  
  output <-
    dimReduct(
      object = colon.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("object", "plot")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Mouse Thymus Dataset", {
  
  thymus.dat <- select_normalized_RTD("thymus")
  
  output <-
    dimReduct(
      object = thymus.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("object", "plot")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("Test Human NSCLC Dataset", {
  
  nsclc.dat <- select_normalized_RTD("nsclc")
  
  output <-
    dimReduct(
      object = nsclc.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  expected.elements = c("object", "plot")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

test_that("dimension reductions present in the input object", {
  
  kidney.dat <- select_normalized_RTD("kidney")
  
  output <-
    dimReduct(
      object = kidney.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      shape.variable = "class"
    )
  
  expect_true(sum(grepl("PC1|PC2", colnames(
    pData(output$object)
  ))) == 2)
  expect_true(sum(grepl("UMAP1|UMAP2", colnames(
    pData(output$object)
  ))) == 2)
  expect_true(sum(grepl("tSNE1|tSNE2", colnames(
    pData(output$object)
  ))) == 2)
  
})

test_that("Check message when replacing pre-existing analysis", {
  
  # Load object
  kidney.dat <- select_normalized_RTD("kidney")
  
  # Run first time and expect no message
  expect_message(output <-
    dimReduct(
      object = kidney.dat,
      point.size = 1,
      point.alpha = 1,
      color.variable1 = "region",
      color.variable2 = "class",
      shape.variable = "segment"
    ), regexp = "adding in the phenoData")
  
  # Run again with different  parameters to replace previous analysis
  # (expect message)
  expect_warning(
    output <-
      dimReduct(
      object = output$object,
      point.size = 5,
      point.alpha = 5,
      color.variable1 = "region",
      color.variable2 = "class",
      shape.variable = NULL
    ),
    regexp = "found in the phenoData"
  )
  
})
