test_that("Test Kidney Data", {
  
  kidney.dat <- selectDatasetFiltering("kidney")
  
  filtering.output <- do.call(filtering,kidney.dat)
  
  expected.elements = c("stacked.bar.plot", 
                        "tab", 
                        "sankey.plot", 
                        "genes.detected.plot", 
                        "object")
  
  expect_setequal(names(filtering.output), expected.elements)
  
})

test_that("Test Colon Data", {
  
  colon.dat <- selectDatasetFiltering("colon")
  
  filtering.output <- do.call(filtering,colon.dat)
  
  expected.elements = c("stacked.bar.plot", 
                        "tab", 
                        "sankey.plot", 
                        "genes.detected.plot", 
                        "object")
  
  expect_setequal(names(filtering.output), expected.elements)
  
})

test_that("Test thymus Data", {
  
  thymus.dat <- selectDatasetFiltering("thymus")
  
  filtering.output <- do.call(filtering,thymus.dat)
  
  expected.elements = c("stacked.bar.plot", 
                        "tab", 
                        "sankey.plot", 
                        "genes.detected.plot", 
                        "object")
  
  expect_setequal(names(filtering.output), expected.elements)
  
})

test_that("Test nsclc Data", {
  
  nsclc.dat <- selectDatasetFiltering("nsclc")
  
  filtering.output <- do.call(filtering,nsclc.dat)
  
  expected.elements = c("stacked.bar.plot", 
                        "tab", 
                        "sankey.plot", 
                        "genes.detected.plot", 
                        "object")
  
  expect_setequal(names(filtering.output), expected.elements)
  
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
 
  kidney.dat$object <- c(1,2,3,5)
  expect_error(do.call(filtering,kidney.dat), "Error: You have the wrong data class, must be NanoStringGeoMxSet")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$loq.cutoff <- c("A")
  expect_error(do.call(filtering,kidney.dat), "Error: You have the wrong data class, must be numeric")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$loq.min <- c("A")
  expect_error(do.call(filtering,kidney.dat), "Error: You have the wrong data class, must be numeric")
})

#test_that("Filtering Success", {
  #kidney.dat <- selectDatasetFiltering("kidney")
  
  #kidney.dat$pkc.file <- 10
  #expect_error(do.call(filtering,kidney.dat), "Error: You have the wrong data class, must be character")
#})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$cut.segment <- c("A")
  expect_error(do.call(filtering,kidney.dat), "Error: You have the wrong data class, must be numeric")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$cut.segment <- 10
  expect_error(do.call(filtering,kidney.dat), "Error: You need perecentage in decimals between 0-1")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$goi <- c(1,2,3,4,5)
  expect_error(do.call(filtering,kidney.dat), "Error: You have the wrong data class, must be character vector")
})