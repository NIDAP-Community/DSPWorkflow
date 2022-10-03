test_that("Run Diff Exp Analysis", {
    
    data <- readRDS(test_path("fixtures","NSdataNorm.rds"))
    goi <- c("CD274", "CD8A", "CD68", "EPCAM",
             "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
    data <- data[goi,]
    groups <- c("DKD", "normal")
    element = "log_q"
    nCores = 1
    regions <- c("glomerulus", "tubule")
    slideCol <- "slide name"
    classCol <- "class"
    multiCore = TRUE
    pAdjust = NULL
    pairwise = NULL
    analysisType <- "Within Groups" 
    fclim <- 1.5
    
    reslist.1 <- DiffExpr(data, element, analysisType, regions, 
                          groups, slideCol, classCol, fclim,
                          multiCore , nCores, pAdjust, pairwise)
    grid.draw(reslist.1$sample_table)
    grid.newpage()
    grid.draw(reslist.1$summary_table)
    expected.elements <- c("results","sample_table","summary_table")
    expect_setequal(names(reslist.1),expected.elements)
    
    lfc.1 <- reslist.1$result %>% filter(Gene == "CALB1") %>% filter(Subset == "normal") %>% pull(.data[[colnames(reslist.1$result)[grepl("logFC",colnames(reslist.1$result))]]])
    pval.1 <- reslist.1$result %>% filter(Gene == "CALB1") %>% filter(Subset == "normal") %>% pull(.data[[colnames(reslist.1$result)[grepl("_pval",colnames(reslist.1$result))]]])
    expect_equal(lfc.1, -2.014,tolerance=1e-3)
    expect_equal(pval.1, 0.0274,tolerance=1e-3)
    
    analysisType <- "Between Groups" 
    reslist.2 <- DiffExpr(data, element, analysisType, regions, 
                      groups, slideCol, classCol, fclim,
                     multiCore , nCores, pAdjust, pairwise)
    grid.draw(reslist.2$sample_table)
    grid.newpage()
    grid.draw(reslist.2$summary_table)
    expected.elements <- c("results","sample_table","summary_table")
    expect_setequal(names(reslist.2),expected.elements)
    
    lfc.2 <- reslist.2$result %>% filter(Gene == "CALB1") %>% filter(Subset == "tubule") %>% pull(.data[[colnames(reslist.2$result)[grepl("logFC",colnames(reslist.2$result))]]])
    pval.2 <- reslist.2$result %>% filter(Gene == "CALB1") %>% filter(Subset == "tubule") %>% pull(.data[[colnames(reslist.2$result)[grepl("_pval",colnames(reslist.2$result))]]])
    expect_equal(lfc.2, -1.408,tolerance=1e-3)
    expect_equal(pval.2, 0.01268,tolerance=1e-3)
})
