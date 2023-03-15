test_that("Test Kidney Data", {
  
  kidney.dat <- selectDatasetFiltering("kidney")
  
  input.data.object <- kidney.dat$object
  input.data.pkc <- kidney.dat$pkcFile
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  dsp.list <- filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes)
  
  expected.elements = c("Stacked Bar Plot", "Table of Cuts", "Sankey Plot", "Genes Detected Plot", "target_demoData Dataset")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})

test_that("Test Colon Data", {
  
  colon.dat <- selectDatasetFiltering("colon")
  
  input.data.object <- colon.dat$object
  input.data.pkc <- colon.dat$pkcFile
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  dsp.list <- filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes)
  
  expected.elements = c("Stacked Bar Plot", "Table of Cuts", "Sankey Plot", "Genes Detected Plot", "target_demoData Dataset")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})

test_that("Test thymus Data", {
  
  thymus.dat <- selectDatasetFiltering("thymus")
  
  input.data.object <- thymus.dat$object
  input.data.pkc <- thymus.dat$pkcFile
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  dsp.list <- filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes)
  
  expected.elements = c("Stacked Bar Plot", "Table of Cuts", "Sankey Plot", "Genes Detected Plott", "target_demoData Dataset")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})

test_that("Test nsclc Data", {
  
  nsclc.dat <- selectDatasetFiltering("nsclc")
  
  input.data.object <- nsclc.dat$object
  input.data.pkc <- nsclc.dat$pkcFile
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  dsp.list <- filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes)
  
  expected.elements = c("Stacked Bar Plot", "Table of Cuts", "Sankey Plot", "Genes Detected Plot", "target_demoData Dataset")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})

test_that("Filtering Success", {
  target_demoDataFil<- c(1,2,3,5)
  kidney.dat <- selectDatasetFiltering("kidney")
  
  input.data.object <- kidney.dat$object
  input.data.pkc <- kidney.dat$pkcFile
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(data = target_demoDataFil, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be NanoStringGeoMxSet")
})

test_that("Filtering Success", {
  target_demoDataFil<- c(1,2,3,5)
  kidney.dat <- selectDatasetFiltering("kidney")
  
  input.data.object <- kidney.dat$object
  input.data.pkc <- kidney.dat$pkcFile
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(data = input.data.object, pkcs = kidney.dat$pkcFile, loq.cutoff = c("A"), loq.min = 2, cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be numeric")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- c(1,2,3,5)
  kidney.dat <- selectDatasetFiltering("kidney")
  
  input.data.object <- kidney.dat$object
  input.data.pkc <- kidney.dat$pkcFile
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(data = kidney.dat$object, pkcs = kidney.dat$pkcFile, loq.cutoff = 2, loq.min = c("A"), cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be numeric")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- c(1,2,3,5)
  kidney.dat <- selectDatasetFiltering("kidney")
  
  input.data.object <- kidney.dat$object
  input.data.pkc <- 10
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be character")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- c(1,2,3,5)
  kidney.dat <- selectDatasetFiltering("kidney")
  
  input.data.object <- kidney.dat$object
  input.data.pkc <- kidney.dat$pkcFile
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = c("A"), goi = genes), "Error: You have the wrong data class, must be numeric")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- c(1,2,3,5)
  kidney.dat <- selectDatasetFiltering("kidney")
  
  input.data.object <- kidney.dat$object
  input.data.pkc <- kidney.dat$pkcFile
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = 10, goi = genes), "Error: You need perecentage in decimals between 0-1")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- c(1,2,3,5)
  kidney.dat <- selectDatasetFiltering("kidney")
  
  input.data.object <- kidney.dat$object
  input.data.pkc <- kidney.dat$pkcFile
  genes <- c(1,2,3,4,5)
  
  expect_error(filtering(data = input.data.object, pkcs = input.data.pkc, loq.cutoff = 2, loq.min = 2, cut.segment = .1, goi = genes), "Error: You have the wrong data class, must be character vector")
  
})