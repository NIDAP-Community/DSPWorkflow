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

#test_that("Filtering Success", {
#  target_demoDataFil<- c(1,2,3,5)
#  kidney.dat <- selectDatasetFiltering("kidney")
#  
#  input.data.object <- kidney.dat$object
#  input.data.pkc <- kidney.dat$pkcFile
#  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
#  
#  expect_error(filtering(data = target_demoDataFil, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be NanoStringGeoMxSet")
#})
#
#test_that("Filtering Success", {
#  target_demoDataFil<- c(1,2,3,5)
#  kidney.dat <- selectDatasetFiltering("kidney")
#  
#  input.data.object <- kidney.dat$object
#  input.data.pkc <- kidney.dat$pkcFile
#  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
#  
#  expect_error(filtering(data = input.data.object, pkcs = kidney.dat$pkcFile, loq.cutoff = c("A"), loq.min = 2, cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be numeric")
#  
#})
#
#test_that("Filtering Success", {
#  target_demoDataFil<- c(1,2,3,5)
#  kidney.dat <- selectDatasetFiltering("kidney")
#  
#  input.data.object <- kidney.dat$object
#  input.data.pkc <- kidney.dat$pkcFile
#  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
#  
#  expect_error(filtering(data = kidney.dat$object, pkcs = kidney.dat$pkcFile, loq.cutoff = 2, loq.min = c("A"), cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be numeric")
#  
#})
#
#test_that("Filtering Success", {
#  target_demoDataFil<- c(1,2,3,5)
#  kidney.dat <- selectDatasetFiltering("kidney")
#  
#  input.data.object <- kidney.dat$object
#  input.data.pkc <- 10
#  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
#  
#  expect_error(filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be character")
#  
#})
#
#test_that("Filtering Success", {
#  target_demoDataFil<- c(1,2,3,5)
#  kidney.dat <- selectDatasetFiltering("kidney")
#  
#  input.data.object <- kidney.dat$object
#  input.data.pkc <- kidney.dat$pkcFile
#  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
#  
#  expect_error(filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = c("A"), goi = genes), "Error: You have the wrong data class, must be numeric")
#  
#})
#
#test_that("Filtering Success", {
#  target_demoDataFil<- c(1,2,3,5)
#  kidney.dat <- selectDatasetFiltering("kidney")
#  
#  input.data.object <- kidney.dat$object
#  input.data.pkc <- kidney.dat$pkcFile
#  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
#  
#  expect_error(filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = 10, goi = genes), "Error: You need perecentage in decimals between 0-1")
#  
#})
#
#test_that("Filtering Success", {
#  target_demoDataFil<- c(1,2,3,5)
#  kidney.dat <- selectDatasetFiltering("kidney")
#  
#  input.data.object <- kidney.dat$object
#  input.data.pkc <- kidney.dat$pkcFile
#  genes <- c(1,2,3,4,5)
#  
#  expect_error(filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be character vector")
#  
#})#