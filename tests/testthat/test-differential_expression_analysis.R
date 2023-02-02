test_that("Run Diff Exp Analysis with default parameters - kidney data", {
    kidney_data <- getsubset("kidney","Within")    
    reslist.1 <- do.call(DiffExpr,kidney_data) #Runs with default parameters
    
    #Test saving plots and calculated FC and pvals
    #announce_snapshot_file("output/kidney_within.png")
    saveplots(reslist.1,"output/kidney_within.png",10)
    expect_snapshot_file("output","kidney_within.png")
    
    res <- calcfc("kidney",reslist.1$results,"Within")
    expect_equal(res$lfc, -2.014,tolerance=1e-3)
    expect_equal(res$pval, 0.0274,tolerance=1e-3)

    expected.elements <- c("results","sample_table","summary_table")
    expect_setequal(names(reslist.1),expected.elements)
    
    ###Testing Between groups:
    kidney_data <- getsubset("kidney","Between")
    reslist.2 <- do.call(DiffExpr,kidney_data)
    
    #Test saving plots and calculated FC and pvals  
    #announce_snapshot_file("output/kidney_between.png")
    saveplots(reslist.2,"output/kidney_between.png",10)
    expect_snapshot_file("output","kidney_between.png")
    
    res <- calcfc("kidney",reslist.2$results,"Between")
    expect_equal(res$lfc, -1.408,tolerance=1e-3)
    expect_equal(res$pval, 0.01268,tolerance=1e-3)
})

test_that("Run Diff Exp Analysis with wrong selected group column", {
    
    kidney_data <- getsubset("kidney","Between")
    kidney_data$groupCol <- "segment" #Wrong selected group column
    
    expect_error(do.call(DiffExpr,kidney_data),fixed=TRUE,"DKD is not in group column.\nnormal is not in group column.")
})

test_that("Run Diff Exp Analysis with wrong selected region column", {

  kidney_data <- getsubset("kidney","Within")
  kidney_data$regionCol <- "segment" #Wrong selected region column
  expect_error(do.call(DiffExpr,kidney_data),fixed=TRUE,
      "glomerulus is not in region column.\ntubule is not in region column.\n")
  
})

test_that("Run Diff Exp Analysis with wrong entry for Groups", {
  
  kidney_data <- getsubset("kidney","Within")
  kidney_test$groups <- c("Dkd","normal") #Misspecifying the group name
  expect_error(do.call(DiffExpr,kidney_test),fixed=TRUE, 
               "Dkd is not in group column.\n")
  
})

test_that("Run Diff Exp Analysis with wrong entry for regions", {
  
  kidney_data <- getsubset("kidney","Within")
  kidney_data$regions <- c("glomerul", "tubule") #
  expect_error(do.call(DiffExpr,kidney_data),fixed=TRUE, 
               "glomerul is not in region column.\n")
  
})

test_that("Run Within Group Analysis with fewer than 2 regions (wrong variable entry)", {

  kidney_data <- getsubset("kidney","Within")
  kidney_data$regions <- "tubule"
  expect_error(do.call(DiffExpr,kidney_data),fixed=TRUE, 
               "Cannot run Within Group Analysis with 1 Region.\n")

})

test_that("Run Between Group Analysis with fewer than 2 groups (wrong variable entry)", {

  kidney_data <- getsubset("kidney","Between")
  kidney_data$groups = c("DKD")
  expect_error(do.call(DiffExpr,kidney_data),fixed=TRUE, 
               "Cannot run Between Group Analysis with 1 Group.\n")
})

test_that("Run Diff Exp Analysis with default parameters - Mouse Thymus data", {
  
  thymus_data <- getsubset("thymus","Within")
  reslist.1 <- do.call(DiffExpr,thymus_data) #Runs with default parameters
  
  #Test saving plots and calculated FC and pvals
  
  #announce_snapshot_file("output/thymus_within.png")
  saveplots(reslist.1,"output/thymus_within.png",10)
  expect_snapshot_file("output","thymus_within.png")
  
  res <- calcfc("thymus",reslist.1$results,"Within")
  expect_equal(res$lfc, -1.6451,tolerance=1e-3)
  expect_equal(res$pval, 2.74e-07,tolerance=1e-3)
  
  expected.elements <- c("results","sample_table","summary_table")
  expect_setequal(names(reslist.1),expected.elements)
  
  ###Testing Between groups:
  thymus_data <- getsubset("thymus","Between")
  
  #Setting parameters for testing Between Groups:
  reslist.2 <- do.call(DiffExpr,thymus_data)
  
  #announce_snapshot_file("output/thymus_between.png")
  saveplots(reslist.1,"output/thymus_between.png",10)
  expect_snapshot_file("output","thymus_between.png")
  
  expected.elements <- c("results","sample_table","summary_table")
  expect_setequal(names(reslist.2),expected.elements)
  
  res <- calcfc("thymus",reslist.2$results,"Between")
  expect_equal(res$lfc, -1.868,tolerance=1e-3)
  expect_equal(res$pval, 5.15e-06,tolerance=1e-3)
})

test_that("Run Diff Exp Analysis with default parameters - Colon data", {
  
  colon_data <- getsubset("colon","Within")
  reslist.1 <- do.call(DiffExpr,colon_data) #Runs with default parameters
  
  #Test saving plots and calculated FC and pvals  
  
  #announce_snapshot_file("output/colon_within.png")
  saveplots(reslist.1,"output/colon_within.png",10)
  expect_snapshot_file("output","colon_within.png")
  
  res <- calcfc("colon",reslist.1$results,"Within")
  expect_equal(res$lfc, -4.698,tolerance=1e-3)
  expect_equal(res$pval, 0.05631,tolerance=1e-3)
  
  expected.elements <- c("results","sample_table","summary_table")
  expect_setequal(names(reslist.1),expected.elements)
  
  ###Testing Between groups:
  colon_data <- getsubset("colon","Between")
  
  #Setting parameters for testing Between Groups:
  reslist.2 <- do.call(DiffExpr,colon_data)
  
  #announce_snapshot_file("output/colon_between.png")
  saveplots(reslist.2,"output/colon_between.png",10)
  expect_snapshot_file("output","colon_between.png")
  
  expected.elements <- c("results","sample_table","summary_table")
  expect_setequal(names(reslist.2),expected.elements)
  
  res <- calcfc("colon",reslist.2$results,"Between")
  expect_equal(res$lfc, -4.431,tolerance=1e-3)
  expect_equal(res$pval, 6.95e-06,tolerance=1e-3)
})

test_that("Run Diff Exp Analysis with default parameters - NSCLC data", {
  
  nsclc_data <- getsubset("nsclc","Within")
  reslist.1 <- do.call(DiffExpr,nsclc_data) #Runs with default parameters
  
  #Test saving plots and calculated FC and pvals  
  #announce_snapshot_file("output/nsclc_within.png")
  saveplots(reslist.1,"output/nsclc_within.png",40)
  expect_snapshot_file("output","nsclc_within.png")
  
  res <- calcfc("nsclc",reslist.1$results,"Within")
  expect_equal(res$lfc, -2.09,tolerance=1e-3)
  expect_equal(res$pval, 8.51e-07,tolerance=1e-3)
  
  expected.elements <- c("results","sample_table","summary_table")
  expect_setequal(names(reslist.1),expected.elements)
  
  ###Testing Between groups:
  nsclc_data <- getsubset("nsclc","Between")
  
  #Setting parameters for testing Between Groups:
  reslist.2 <- do.call(DiffExpr,nsclc_data)
  
  #announce_snapshot_file("output/nsclc_between.png")
  saveplots(reslist.2,"output/nsclc_between.png",40)
  expect_snapshot_file("output","nsclc_between.png")
  
  expected.elements <- c("results","sample_table","summary_table")
  expect_setequal(names(reslist.2),expected.elements)
  
  res <- calcfc("nsclc",reslist.2$results,"Between")
  expect_equal(res$lfc, 2.55,tolerance=1e-3)
  expect_equal(res$pval, 9.77e-09,tolerance=1e-3)
})