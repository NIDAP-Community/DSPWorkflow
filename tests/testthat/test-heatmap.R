test_that("making heatmap plot---Test Human Kidney dataset", {
  
  data <- getDataset("kidney")
  
  invisible(capture.output(res <- do.call(heatMap, data)))
  
  expected.elements <- c("plot.genes","plot")
  expect_setequal(names(res), expected.elements)
  
})

test_that("making heatmap plot---Test Huamn Colon Dataset", {
  
  data <- getDataset("colon")
  
  invisible(capture.output(res <- do.call(heatMap, data)))
  
  expected.elements <- c("plot.genes","plot")
  expect_setequal(names(res), expected.elements)
  
})

test_that("making heatmap plot---Test Mouse Thymus Dataset", {
  
  data <- getDataset("thymus")
  
  invisible(capture.output(res <- do.call(heatMap, data)))
  
  expected.elements <- c("plot.genes","plot")
  expect_setequal(names(res), expected.elements)
  
})

test_that("making heatmap plot---Test Human NSCLC Dataset", {
  
  data <- getDataset("nsclc")
  
  invisible(capture.output(res <- do.call(heatMap, data)))
  
  expected.elements <- c("plot.genes","plot")
  expect_setequal(names(res), expected.elements)
  
})