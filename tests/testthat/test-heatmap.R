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

test_that("making heatmap plot---with wrong ngenes", {
  
  data <- getDataset("nsclc")
  data$ngenes <- 1
  
  expect_error(do.call(heatMap, data),
               fixed = TRUE,
               "ngenes must be interger > 1.\n")
})

test_that("making heatmap plot---with wrong ngenes", {
  
  data <- getDataset("nsclc")
  data$ngenes <- "TP53"
  
  expect_error(do.call(heatMap, data),
               fixed = TRUE,
               "ngenes must be interger > 1.\n")
})