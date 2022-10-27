test_that("Filtering Success", {
  target_demoDataFil<- readRDS(test_path("fixtures", "target_demoDataFiltering.rds"))
  demoDataFil <- readRDS(test_path("fixtures", "demoDataFiltering.rds"))
  PKFil <- readRDS(test_path("fixtures", "pkcsFiltering.rds"))
  genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  
  dsp.list <- filtering(Data = target_demoDataFil, dsp_obj = demoDataFil, PKCS = PKFil, LOQcutoff = 2, LOQmin = 2, CutSegment = .1, GOI = genes)
  expected.elements = c("Stacked Bar Plot", "Table of Cuts", "Sankey Plot", "Genes Deccted Plot", "target_demoData Dataset")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)  
})