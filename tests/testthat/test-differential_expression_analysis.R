test_that("Run Diff Exp Analysis", {
    
    data <- readRDS(test_path("fixtures","NSdataNorm.rds"))
    goi <- c("CD274", "CD8A", "CD68", "EPCAM",
             "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
    data <- data[goi,]
    Gene <- Subset <- NULL
    
    reslist.1 <- DiffExpr(object = data, 
                          analysisType = "Within Groups",
                          groups = c("DKD", "normal"), 
                          groupCol = "class",
                          regions = c("glomerulus", "tubule"), 
                          regionCol = "region",
                          slideCol = "slide name",
                          nCores = 4)

    grid.draw(reslist.1$sample_table)
    grid.newpage()
    grid.draw(reslist.1$summary_table)
    expected.elements <- c("results","sample_table","summary_table")
    expect_setequal(names(reslist.1),expected.elements)
    
    lfc_col1 <- colnames(reslist.1$result)[grepl("logFC",colnames(reslist.1$result))]
    pval_col1 <- colnames(reslist.1$result)[grepl("_pval",colnames(reslist.1$result))]

    lfc.1 <- reslist.1$result %>% dplyr::filter(Gene == "CALB1" & Subset == "normal") %>% pull(lfc_col1) %>% as.numeric()
    pval.1 <- reslist.1$result %>% dplyr::filter(Gene == "CALB1" & Subset == "normal") %>% pull(pval_col1) %>% as.numeric()
    expect_equal(lfc.1, -2.014,tolerance=1e-3)
    expect_equal(pval.1, 0.0274,tolerance=1e-3)
    
    reslist.2 <- DiffExpr(object = data, 
                          analysisType = "Between Groups",
                          groups = c("DKD", "normal"), 
                          groupCol = "class",
                          regions = c("glomerulus", "tubule"), 
                          regionCol = "region",
                          slideCol = "slide name",
                          nCores = 4)
      
    grid.draw(reslist.2$sample_table)
    grid.newpage()
    grid.draw(reslist.2$summary_table)
    expected.elements <- c("results","sample_table","summary_table")
    expect_setequal(names(reslist.2),expected.elements)
    
    lfc_col2 <- colnames(reslist.2$result)[grepl("logFC",colnames(reslist.2$result))]
    pval_col2 <- colnames(reslist.2$result)[grepl("_pval",colnames(reslist.2$result))]
     
    lfc.2 <- reslist.2$result %>% dplyr::filter(Gene == "CALB1" & Subset == "tubule") %>% pull(lfc_col2) %>% as.numeric()
    pval.2 <- reslist.2$result %>% dplyr::filter(Gene == "CALB1" & Subset == "tubule") %>% pull(pval_col2) %>% as.numeric()
    expect_equal(lfc.2, -1.408,tolerance=1e-3)
    expect_equal(pval.2, 0.01268,tolerance=1e-3)
})

test_that("Run Diff Exp Analysis with wrong selected group column", {
    
    data <- readRDS(test_path("fixtures","NSdataNorm.rds"))
    goi <- c("CD274", "CD8A", "CD68", "EPCAM",
             "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
    data <- data[goi,]
    Gene <- Subset <- NULL
    
    expect_error(DiffExpr(object = data, 
                          analysisType = "Within Groups",
                          groups = c("DKD", "normal"), 
                          groupCol = "segment",
                          regions = c("glomerulus", "tubule"), 
                          regionCol = "region",
                          slideCol = "slide name",
                          nCores = 4), "DKD is not in group column.\nnormal is not in group column.")
    
})

test_that("Run Diff Exp Analysis with wrong selected region column", {
  
  data <- readRDS(test_path("fixtures","NSdataNorm.rds"))
  goi <- c("CD274", "CD8A", "CD68", "EPCAM",
           "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  data <- data[goi,]
  Gene <- Subset <- NULL
  
  expect_error(DiffExpr(object = data, 
                        analysisType = "Within Groups",
                        groups = c("DKD", "normal"), 
                        groupCol = "class",
                        regions = c("glomerulus", "tubule"), 
                        regionCol = "segment",
                        slideCol = "slide name",
                        nCores = 4), "glomerulus is not in region column.\ntubule is not in region column.\n")
  
})

test_that("Run Diff Exp Analysis with wrong entry for Groups", {
  
  data <- readRDS(test_path("fixtures","NSdataNorm.rds"))
  goi <- c("CD274", "CD8A", "CD68", "EPCAM",
           "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  data <- data[goi,]
  Gene <- Subset <- NULL
  
  expect_error(DiffExpr(object = data, 
                        analysisType = "Within Groups",
                        groups = c("DKd", "normal"), 
                        groupCol = "class",
                        regions = c("glomerulus", "tubule"), 
                        regionCol = "region",
                        slideCol = "slide name",
                        nCores = 4), "DKd is not in group column")
  
})

test_that("Run Diff Exp Analysis with wrong entry for regions", {
  
  data <- readRDS(test_path("fixtures","NSdataNorm.rds"))
  goi <- c("CD274", "CD8A", "CD68", "EPCAM",
           "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  data <- data[goi,]
  Gene <- Subset <- NULL
  
  expect_error(DiffExpr(object = data, 
                        analysisType = "Within Groups",
                        groups = c("DKD", "normal"), 
                        groupCol = "class",
                        regions = c("glomerul", "tubule"), 
                        regionCol = "region",
                        slideCol = "slide name",
                        nCores = 4), "glomerul is not in region column.\n")
  
})

test_that("Run Within Group Analysis with fewer than 2 regions (wrong variable entry)", {
  
  data <- readRDS(test_path("fixtures","NSdataNorm.rds"))
  goi <- c("CD274", "CD8A", "CD68", "EPCAM",
           "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  data <- data[goi,]
  Gene <- Subset <- NULL
  
  expect_error(DiffExpr(object = data, 
                        analysisType = "Within Groups",
                        groups = c("DKD", "normal"), 
                        groupCol = "class",
                        regions = c("tubule"), 
                        regionCol = "region",
                        slideCol = "slide name",
                        nCores = 4), "Cannot run Within Group Analysis with 1 Region.\n")
  
})

test_that("Run Between Group Analysis with fewer than 2 groups (wrong variable entry)", {
  
  data <- readRDS(test_path("fixtures","NSdataNorm.rds"))
  goi <- c("CD274", "CD8A", "CD68", "EPCAM",
           "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
  data <- data[goi,]
  Gene <- Subset <- NULL
  
  expect_error(DiffExpr(object = data, 
                        analysisType = "Between Groups",
                        groups = c("DKD"), 
                        groupCol = "class",
                        regions = c("tubule","glomerulus"), 
                        regionCol = "region",
                        slideCol = "slide name",
                        nCores = 4), "Cannot run Between Group Analysis with 1 Group.\n")
  
})
