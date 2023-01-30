kidney_data <- get_de_params("kidney")
goi <- c("CD274", "CD8A", "CD68", "EPCAM",
         "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
kidney_data$object <- kidney_data$object[goi,]

test_that("Run Diff Exp Analysis with default parameters - kidney data", {
    
    reslist.1 <- do.call(DiffExpr,kidney_data) #Runs with default parameters

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
    
    
    ###Testing Between groups:
    kidney_test <- kidney_data
    kidney_test$analysisType <- "Between Groups"
    reslist.2 <- do.call(DiffExpr,kidney_test)
      
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
    
    kidney_test <- kidney_data
    kidney_test$analysisType <- "Between Groups"
    
    kidney_test$groupCol <- "segment" #Wrong selected group column
    
    expect_error(do.call(DiffExpr,kidney_test),fixed=TRUE,"DKD is not in group column.\nnormal is not in group column.")
})

test_that("Run Diff Exp Analysis with wrong selected region column", {

  kidney_test <- kidney_data
  
  kidney_test$regionCol <- "segment" #Wrong selected region column
  
  expect_error(do.call(DiffExpr,kidney_test),fixed=TRUE,
      "glomerulus is not in region column.\ntubule is not in region column.\n")
  
})

test_that("Run Diff Exp Analysis with wrong entry for Groups", {
  
  kidney_test <- kidney_data
  
  kidney_test$groups <- c("Dkd","normal") #Misspecifying the group name
  
  expect_error(do.call(DiffExpr,kidney_test),fixed=TRUE, "Dkd is not in group column.\n")
  
})

test_that("Run Diff Exp Analysis with wrong entry for regions", {
  
  kidney_test <- kidney_data
  
  kidney_test$regions <- c("glomerul", "tubule") #
  
  expect_error(do.call(DiffExpr,kidney_test),fixed=TRUE, "glomerul is not in region column.\n")
  
})

# test_that("Run Within Group Analysis with fewer than 2 regions (wrong variable entry)", {
#   
#   kidney_test$regionCol <- "tubule"
#   
#   expect_error(do.call(DiffExpr,kidney_test),fixed=TRUE, "Cannot run Within Group Analysis with 1 Region.\n")
#   
# })

#test_that("Run Between Group Analysis with fewer than 2 groups (wrong variable entry)", {
  
#   expect_error(DiffExpr(object = data, 
#                         analysisType = "Between Groups",
#                         groups = c("DKD"), 
#                         groupCol = "class",
#                         regions = c("tubule","glomerulus"), 
#                         regionCol = "region",
#                         slideCol = "slide name",
#                         nCores = 4), "Cannot run Between Group Analysis with 1 Group.\n")
#   
# })


## Using Mouse Data:

thymus_data <- get_de_params("thymus")

goi <- c("Plb1", "Ccr7", "Oas2", "Oas1a", "Oas1b", "Rhbdl2", "Dlst", 
         "Naa15", "Rab11a", "Desi1", "Tfdp1", "Foxn1")
thymus_data$object <- thymus_data$object[goi,]


test_that("Run Diff Exp Analysis with default parameters - Mouse Thymus data", {
  
  reslist.1 <- do.call(DiffExpr,thymus_data) #Runs with default parameters
  
  grid.draw(reslist.1$sample_table)
  grid.newpage()
  grid.draw(reslist.1$summary_table)
  expected.elements <- c("results","sample_table","summary_table")
  expect_setequal(names(reslist.1),expected.elements)
  
  lfc_col1 <- colnames(reslist.1$result)[grepl("logFC",colnames(reslist.1$result))]
  pval_col1 <- colnames(reslist.1$result)[grepl("_pval",colnames(reslist.1$result))]
  
  lfc.1 <- reslist.1$result %>% dplyr::filter(Gene == "Ccr7" & Subset == "Thymus") %>% pull(lfc_col1) %>% as.numeric()
  pval.1 <- reslist.1$result %>% dplyr::filter(Gene == "Ccr7" & Subset == "Thymus") %>% pull(pval_col1) %>% as.numeric()
  expect_equal(lfc.1, -1.6451,tolerance=1e-3)
  expect_equal(pval.1, 2.74e-07,tolerance=1e-3)
  
  
  ###Testing Between groups:
  thymus_test <- thymus_data
  
  #Setting parameters for testing Between Groups:
  thymus_test$analysisType <- "Between Groups"
  thymus_test$groups <- c("Tumor", "Medullar")
  thymus_test$regions = c("PanCK")
  thymus_test$regionCol = "segment"
  thymus_test$groupCol = "region"
  
  reslist.2 <- do.call(DiffExpr,thymus_test)
  
  grid.draw(reslist.2$sample_table)
  grid.newpage()
  grid.draw(reslist.2$summary_table)
  expected.elements <- c("results","sample_table","summary_table")
  expect_setequal(names(reslist.2),expected.elements)
  
  lfc_col2 <- colnames(reslist.2$result)[grepl("logFC",colnames(reslist.2$result))]
  pval_col2 <- colnames(reslist.2$result)[grepl("_pval",colnames(reslist.2$result))]
  
  lfc.2 <- reslist.2$result %>% dplyr::filter(Gene == "Ccr7" & Subset == "PanCK") %>% pull(lfc_col2) %>% as.numeric()
  pval.2 <- reslist.2$result %>% dplyr::filter(Gene == "Ccr7" & Subset == "PanCK") %>% pull(pval_col2) %>% as.numeric()
  expect_equal(lfc.2, -1.868,tolerance=1e-3)
  expect_equal(pval.2, 5.15e-06,tolerance=1e-3)
})

## Using 