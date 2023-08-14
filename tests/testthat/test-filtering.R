test_that("Test Kidney Data", {
  
  kidney.dat <- selectDatasetFiltering("kidney")
  
  filtering.output <- do.call(filtering,kidney.dat)
  
  expected.elements = c("stacked.bar.plot", 
                        "segment.table", 
                        "goi.table", 
                        "sankey.plot", 
                        "genes.detected.plot", 
                        "object")
  
  expect_setequal(names(filtering.output), expected.elements)
  
})

test_that("Test Colon Data", {
  
  colon.dat <- selectDatasetFiltering("colon")
  
  filtering.output <- do.call(filtering,colon.dat)
  
  expected.elements = c("stacked.bar.plot", 
                        "segment.table", 
                        "goi.table", 
                        "sankey.plot", 
                        "genes.detected.plot", 
                        "object")
  
  expect_setequal(names(filtering.output), expected.elements)
  
})

test_that("Test thymus Data", {
  
  thymus.dat <- selectDatasetFiltering("thymus")
  
  filtering.output <- do.call(filtering,thymus.dat)
  
  expected.elements = c("stacked.bar.plot", 
                        "segment.table", 
                        "goi.table", 
                        "sankey.plot", 
                        "genes.detected.plot", 
                        "object")
  
  expect_setequal(names(filtering.output), expected.elements)
  
})

test_that("Test nsclc Data", {
  
  nsclc.dat <- selectDatasetFiltering("nsclc")
  
  filtering.output <- do.call(filtering,nsclc.dat)
  
  expected.elements = c("stacked.bar.plot", 
                        "segment.table", 
                        "goi.table", 
                        "sankey.plot", 
                        "genes.detected.plot", 
                        "object")
  
  expect_setequal(names(filtering.output), expected.elements)
  
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
 
  kidney.dat$object <- c(1,2,3,5)
  expect_error(do.call(filtering,kidney.dat), "Error: The input object must be a NanoStringGeoMxSet")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$loq.cutoff <- c("A")
  expect_error(do.call(filtering,kidney.dat), "Error: LOQ cutoff must be numeric")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$loq.min <- c("A")
  expect_error(do.call(filtering,kidney.dat), "Error: LOQ min must be numeric")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$segment.gene.rate.cutoff <- c("A")
  expect_error(do.call(filtering,kidney.dat), "Error: segment.gene.rate.cutoff must be numeric")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$segment.gene.rate.cutoff <- 10
  expect_error(do.call(filtering,kidney.dat), "Error: segment.gene.rate.cutoff must be between 0-1")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$study.gene.rate.cutoff <- 10
  expect_error(do.call(filtering,kidney.dat), "Error: study.gene.rate.cutoff must be between 0-1")
})

test_that("Filtering Success", {
  kidney.dat <- selectDatasetFiltering("kidney")
  
  kidney.dat$goi <- c(1,2,3,4,5)
  expect_error(do.call(filtering,kidney.dat), "Error: You have the wrong data class, must be character vector")
})