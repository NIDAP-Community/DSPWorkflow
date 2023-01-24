test_that("Filtering Success", {
  target_demoDataFil<- readRDS(test_path("fixtures", "target_demoDataFiltering.rds"))
  demoDataFil <- readRDS(test_path("fixtures", "demoDataFiltering.rds"))
  PKFil <- readRDS(test_path("fixtures", "pkcsFiltering.rds"))
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  dsp.list <- filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = 2, LOQmin = 2, CutSegment = .1, GOI = genes)
  expected.elements = c("Stacked Bar Plot", "Table of Cuts", "Sankey Plot", "Genes Deccted Plot", "target_demoData Dataset")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)  
})

test_that("Filtering Success", {
  target_demoDataFil<- c(1,2,3,5)
  demoDataFil <- readRDS(test_path("fixtures", "demoDataFiltering.rds"))
  PKFil <- readRDS(test_path("fixtures", "pkcsFiltering.rds"))
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = 2, LOQmin = 2, CutSegment = .1, GOI = genes), "Error: You have the wrong data class, must be NanoStringGeoMxSet")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- readRDS(test_path("fixtures", "target_demoDataFiltering.rds"))
  demoDataFil <- readRDS(test_path("fixtures", "demoDataFiltering.rds"))
  PKFil <- readRDS(test_path("fixtures", "pkcsFiltering.rds"))
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = c("A"), LOQmin = 2, CutSegment = .1, GOI = genes), "Error: You have the wrong data class, must be numeric")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- readRDS(test_path("fixtures", "target_demoDataFiltering.rds"))
  demoDataFil <- readRDS(test_path("fixtures", "demoDataFiltering.rds"))
  PKFil <- readRDS(test_path("fixtures", "pkcsFiltering.rds"))
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = 2, LOQmin = c("A"), CutSegment = .1, GOI = genes), "Error: You have the wrong data class, must be numeric")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- readRDS(test_path("fixtures", "target_demoDataFiltering.rds"))
  demoDataFil <- readRDS(test_path("fixtures", "demoDataFiltering.rds"))
  PKFil <- 10
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = 2, LOQmin = 2, CutSegment = .1, GOI = genes), "Error: You have the wrong data class, must be character")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- readRDS(test_path("fixtures", "target_demoDataFiltering.rds"))
  demoDataFil <- readRDS(test_path("fixtures", "demoDataFiltering.rds"))
  PKFil <- readRDS(test_path("fixtures", "pkcsFiltering.rds"))
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = 2, LOQmin = 2, CutSegment = c("A"), GOI = genes), "Error: You have the wrong data class, must be numeric")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- readRDS(test_path("fixtures", "target_demoDataFiltering.rds"))
  demoDataFil <- readRDS(test_path("fixtures", "demoDataFiltering.rds"))
  PKFil <- readRDS(test_path("fixtures", "pkcsFiltering.rds"))
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = 2, LOQmin = 2, CutSegment = 10, GOI = genes), "Error: You need perecentage in decimals between 0-1")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- readRDS(test_path("fixtures", "target_demoDataFiltering.rds"))
  demoDataFil <- c(1,2,3,5)
  PKFil <- readRDS(test_path("fixtures", "pkcsFiltering.rds"))
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  expect_error(filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = 2, LOQmin = 2, CutSegment = .1, GOI = genes), "Error: You have the wrong data class, must be NanoStringGeoMxSet")
  
})

test_that("Filtering Success", {
  target_demoDataFil<- readRDS(test_path("fixtures", "target_demoDataFiltering.rds"))
  demoDataFil <- readRDS(test_path("fixtures", "demoDataFiltering.rds"))
  PKFil <- readRDS(test_path("fixtures", "pkcsFiltering.rds"))
  genes <- c(1,2,3,4,5)
  
  expect_error(filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = 2, LOQmin = 2, CutSegment = 10, GOI = genes), "Error: You have the wrong data class, must be character vector")
  
})