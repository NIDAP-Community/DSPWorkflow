test_that("making heatmap plot---Test Human Kidney dataset", {
  
  kidney.data <- getDataset("kidney")
  
  invisible(capture.output(res <- do.call(heatMap, kidney.data)))
  
  expected.elements <- c("plot.genes","plot")
  expect_setequal(names(res), expected.elements)
  
})

test_that("making heatmap plot---Test Huamn Colon Dataset", {
  
  kidney.data <- getDataset("colon")
  
  invisible(capture.output(res <- do.call(heatMap, kidney.data)))
  
  expected.elements <- c("plot.genes","plot")
  expect_setequal(names(res), expected.elements)
  
})

test_that("making heatmap plot---Test Mouse Thymus Dataset", {
  
  kidney.data <- getDataset("thymus")
  
  invisible(capture.output(res <- do.call(heatMap, kidney.data)))
  
  expected.elements <- c("plot.genes","plot")
  expect_setequal(names(res), expected.elements)
  
})

test_that("making heatmap plot---Test Human NSCLC Dataset", {
  
  kidney.data <- getDataset("nsclc")
  
  invisible(capture.output(res <- do.call(heatMap, kidney.data)))
  
  expected.elements <- c("plot.genes","plot")
  expect_setequal(names(res), expected.elements)
  
})
