# Data Testing
test_that("Violin Plot works for Human Kidney data", {
  
  kidney.data <- getViolinParam("kidney")
  
  violin.out <- class(do.call(violinPlot, kidney.data))
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin.out)), 0)
  
})

test_that("Violin Plot works for Mouse Thymus data", {
  
  thymus.data <- getViolinParam("thymus")
  
  violin.out <- class(do.call(violinPlot, thymus.data))
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin.out)), 0)
  
})

test_that("Violin Plot works for Human Colon data", {
  
  colon.data <- getViolinParam("colon")
  
  violin.out <- class(do.call(violinPlot, colon.data))
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin.out)), 0)
  
})

test_that("Violin Plot works for Human NSCLC data", {
  
  nsclc.data <- getViolinParam("nsclc")
  
  violin.out <- class(do.call(violinPlot, nsclc.data))

  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin.out)), 0)
  
})

test_that("Violin Plot works when using a facet parameter", {
  
  nsclc.data <- getViolinParam("nsclc")
  
  violin.out <- class(violinPlot(object = nsclc.data$object,
                                 expr.type = nsclc.data$expr.type,
                                 genes = nsclc.data$genes, 
                                 group = nsclc.data$group, 
                                 facet.by = "segment"))
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin.out)), 0)
  
})

# Error Testing
test_that("Violin Plot stops when incorrect gene expression set is selected", {
  
  kidney.data <- getViolinParam("kidney")
  
  expect_error(violinPlot(object = kidney.data$object,
                          expr.type = "wrong_expr_type",
                          genes = kidney.data$genes, 
                          group = kidney.data$group), 
               "expression data type was not found in DSP object")
  
})

test_that("Violin Plot stops when no genes are present", {
  
  kidney.data <- getViolinParam("kidney")
  
  incorrect.genes <- paste0("wrong_gene",1:10)
  
  expect_error(violinPlot(object = kidney.data$object, 
                          expr.type = kidney.data$expr.type,
                          genes = incorrect.genes, 
                          group = kidney.data$group), 
               "no genes were found in DSP object")
  
})

test_that("Violin Plot stops when incorrect grouping parameter is selected", {
  
  kidney.data <- getViolinParam("kidney")
  
  expect_error(violinPlot(object = kidney.data$object, 
                          expr.type = kidney.data$expr.type,
                          genes = kidney.data$genes, 
                          group = "wrong_group"), 
               "grouping parameter was not found in DSP object")
  
})

test_that("Violin Plot stops when incorrect faceting parameter is selected", {
  
  kidney.data <- getViolinParam("kidney")
  
  expect_error(violinPlot(object = kidney.data$object, 
                          expr.type = kidney.data$expr.type,
                          genes = kidney.data$genes, 
                          group = kidney.data$group, 
                          facet.by = "wrong_facet"),
               "facet parameter was not found in DSP object")
  
})
