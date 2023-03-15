test_that("Run Diff Exp Analysis with default parameters - kidney data", {
  kidney.data <- getSubset("kidney", "Within")
  reslist.1 <-
    do.call(diffExpr, kidney.data) #Runs with default parameters
  
  #Test saving images and calculated FC and pvals
  expect_snapshot_file(
    ggsave(
      "kidney_within.png",
      reslist.1$tables,
      width = 10,
      height = 10
    ),
    "kidney_within.png"
  )
  
  res <- calcFC("kidney", reslist.1$results, "Within")
  expect_equal(res$lfc, -2.014, tolerance = 1e-3)
  expect_equal(res$pval, 0.0274, tolerance = 1e-3)
  
  expected.elements <- c("results", "tables")
  expect_setequal(names(reslist.1), expected.elements)
  
  ###Testing Between groups:
  kidney.data <- getSubset("kidney", "Between")
  reslist.2 <- do.call(diffExpr, kidney.data)
  
  #Test saving images and calculated FC and pvals
  #announce_snapshot_file("output/kidney_between.png")
  expect_snapshot_file(
    ggsave(
      "kidney_between.png",
      reslist.1$tables,
      width = 10,
      height = 10
    ),
    "kidney_between.png"
  )
  
  res <- calcFC("kidney", reslist.2$results, "Between")
  expect_equal(res$lfc, -1.408, tolerance = 1e-3)
  expect_equal(res$pval, 0.01268, tolerance = 1e-3)
})

test_that("Run Diff Exp Analysis with wrong selected group column", {
  kidney.data <- getSubset("kidney", "Between")
  kidney.data$group.col <- "segment" #Wrong selected group column
  
  expect_error(
    do.call(diffExpr, kidney.data),
    fixed = TRUE,
    "DKD is not in group column.\nnormal is not in group column."
  )
})

test_that("Run Diff Exp Analysis with wrong selected region column", {
      kidney.data <- getSubset("kidney", "Within")
      kidney.data$region.col <- "segment" #Wrong selected region column
      expect_error(
        do.call(diffExpr, kidney.data),
        fixed = TRUE,
        "glomerulus is not in region column.\ntubule is not in region column.\n"
      )
  
})

test_that("Run Diff Exp Analysis with wrong entry for Groups", {
        kidney.data <- getSubset("kidney", "Within")
        kidney.data$groups <-
          c("Dkd", "normal") #Misspecifying the group name
        expect_error(do.call(diffExpr, kidney.data),
                     fixed = TRUE,
                     "Dkd is not in group column.\n")
})

test_that("Run Diff Exp Analysis with wrong entry for regions", {
        kidney.data <- getSubset("kidney", "Within")
        kidney.data$regions <- c("glomerul", "tubule") #
        expect_error(do.call(diffExpr, kidney.data),
                     fixed = TRUE,
                     "glomerul is not in region column.\n")
        
})

test_that("Run Within Group Analysis with fewer than 2 regions (wrong variable 
          entry)",
          {
            kidney.data <- getSubset("kidney", "Within")
            kidney.data$regions <- "tubule"
            expect_error(
              do.call(diffExpr, kidney.data),
              fixed = TRUE,
              "Cannot run Within Group Analysis with 1 Region.\n"
            )
          })

test_that("Run Between Group Analysis with fewer than 2 groups (wrong variable 
          entry)",
          {
            kidney.data <- getSubset("kidney", "Between")
            kidney.data$groups = c("DKD")
            expect_error(
              do.call(diffExpr, kidney.data),
              fixed = TRUE,
              "Cannot run Between Group Analysis with 1 Group.\n"
            )
          })

test_that("Run Diff Exp Analysis with default parameters - Mouse Thymus data", {
            thymus.data <- getSubset("thymus", "Within")
            reslist.1 <-
              do.call(diffExpr, thymus.data) #Runs with default parameters
            
            #Test saving images and calculated FC and pvals
            expect_snapshot_file(
              ggsave(
                "thymus_within.png",
                reslist.1$tables,
                width = 10,
                height = 10
              ),
              "thymus_within.png"
            )
            
            res <- calcFC("thymus", reslist.1$results, "Within")
            expect_equal(res$lfc, -1.6451, tolerance = 1e-3)
            expect_equal(res$pval, 2.74e-07, tolerance = 1e-3)
            
            expected.elements <- c("results", "tables")
            expect_setequal(names(reslist.1), expected.elements)
            
            ###Testing Between groups:
            thymus.data <- getSubset("thymus", "Between")
            
            #Setting parameters for testing Between Groups:
            reslist.2 <- do.call(diffExpr, thymus.data)
            
            expect_snapshot_file(
              ggsave(
                "thymus_between.png",
                reslist.1$tables,
                width = 10,
                height = 10
              ),
              "thymus_between.png"
            )
            
            expected.elements <- c("results", "tables")
            expect_setequal(names(reslist.2), expected.elements)
            
            res <- calcFC("thymus", reslist.2$results, "Between")
            expect_equal(res$lfc, -1.868, tolerance = 1e-3)
            expect_equal(res$pval, 5.15e-06, tolerance = 1e-3)
          })

test_that("Run Diff Exp Analysis with default parameters - Colon data", {
          colon.data <- getSubset("colon", "Within")
          reslist.1 <-
            do.call(diffExpr, colon.data) #Runs with default parameters
          
          #Test saving images and calculated FC and pvals
          expect_snapshot_file(
            ggsave(
              "colon_within.png",
              reslist.1$tables,
              width = 10,
              height = 10
            ),
            "colon_within.png"
          )
          
          res <- calcFC("colon", reslist.1$results, "Within")
          expect_equal(res$lfc, -4.698, tolerance = 1e-3)
          expect_equal(res$pval, 0.05631, tolerance = 1e-3)
          
          expected.elements <- c("results", "tables")
          expect_setequal(names(reslist.1), expected.elements)
          
          ###Testing Between groups:
          colon.data <- getSubset("colon", "Between")
          
          #Setting parameters for testing Between Groups:
          reslist.2 <- do.call(diffExpr, colon.data)
          
          expect_snapshot_file(
            ggsave(
              "colon_between.png",
              reslist.1$tables,
              width = 10,
              height = 10
            ),
            "colon_between.png"
          )
          
          expected.elements <- c("results", "tables")
          expect_setequal(names(reslist.2), expected.elements)
          
          res <- calcFC("colon", reslist.2$results, "Between")
          expect_equal(res$lfc, -4.431, tolerance = 1e-3)
          expect_equal(res$pval, 6.95e-06, tolerance = 1e-3)
})

test_that("Run Diff Exp Analysis with default parameters - NSCLC data", {
          nsclc.data <- getSubset("nsclc", "Within")
          reslist.1 <-
            do.call(diffExpr, nsclc.data) #Runs with default parameters
          
          #Test saving images and calculated FC and pvals
          expect_snapshot_file(
            ggsave(
              "nsclc_within.png",
              reslist.1$tables,
              width = 40,
              height = 10
            ),
            "nsclc_within.png"
          )
          
          res <- calcFC("nsclc", reslist.1$results, "Within")
          expect_equal(res$lfc, -2.09, tolerance = 1e-3)
          expect_equal(res$pval, 8.51e-07, tolerance = 1e-3)
          
          expected.elements <- c("results", "tables")
          expect_setequal(names(reslist.1), expected.elements)
          
          ###Testing Between groups:
          nsclc.data <- getSubset("nsclc", "Between")
          
          #Setting parameters for testing Between Groups:
          reslist.2 <- do.call(diffExpr, nsclc.data)
          
          expect_snapshot_file(
            ggsave(
              "nsclc_between.png",
              reslist.1$tables,
              width = 40,
              height = 10
            ),
            "nsclc_between.png"
          )
          
          expected.elements <- c("results", "tables")
          expect_setequal(names(reslist.2), expected.elements)
          
          res <- calcFC("nsclc", reslist.2$results, "Between")
          expect_equal(res$lfc, 2.55, tolerance = 1e-3)
          expect_equal(res$pval, 9.77e-09, tolerance = 1e-3)
})