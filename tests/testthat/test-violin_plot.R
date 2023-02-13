## Test to see that violin code works for different DSP datasets ##

test_that("Violin Plot works for Human Kidney data", {
  
  kidney_dat <- select_dataset_violin("kidney")
  
  violin_plot_test <- violinPlot(data = kidney_dat$object, genes = kidney_dat$test_genes, expr.type = kidney_dat$test_expr_type,
                                      group = kidney_dat$test_group)
  
  violin_output <- class(violin_plot_test)
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin_output)), 0)
  
})

test_that("Violin Plot works for Mouse Thymus data", {
  
  thymus_dat <- select_dataset_violin("thymus")
  
  violin_plot_test <- violinPlot(data = thymus_dat$object, genes = thymus_dat$test_genes, expr.type = thymus_dat$test_expr_type,
                                      group = thymus_dat$test_group)
  
  violin_output <- class(violin_plot_test)
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin_output)), 0)
  
})

test_that("Violin Plot works for Human Colon data", {
  
  colon_dat <- select_dataset_violin("colon")
  
  violin_plot_test <- violinPlot(data = colon_dat$object, genes = colon_dat$test_genes, expr.type = colon_dat$test_expr_type,
                                      group = colon_dat$test_group)
  
  violin_output <- class(violin_plot_test)
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin_output)), 0)
  
})

test_that("Violin Plot works for Human NSCLC data", {
  
  nsclc_dat <- select_dataset_violin("nsclc")
  
  violin_plot_test <- violinPlot(data = nsclc_dat$object, genes = nsclc_dat$test_genes, expr.type = nsclc_dat$test_expr_type,
                            group = nsclc_dat$test_group)

  violin_output <- class(violin_plot_test)
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin_output)), 0)
  
})

test_that("Violin Plot works when using a facet parameter", {
  
  nsclc_dat <- select_dataset_violin("nsclc")
  
  violin_plot_test <- violinPlot(data = nsclc_dat$object, genes = nsclc_dat$test_genes, expr.type = nsclc_dat$test_expr_type,
                                      group = nsclc_dat$test_group, facet.by = "segment")
  
  violin_output <- class(violin_plot_test)
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin_output)), 0)
  
})

## Error Testing ##

test_that("Violin Plot stops when incorrect gene expression set is selected", {
  
  kidney_dat <- select_dataset_violin("kidney")
  
  expect_error(violinPlot(data = kidney_dat$object, genes = kidney_dat$test_genes, expr.type = "jibberish",
                               group = kidney_dat$test_group), "expression data type was not found in DSP data")
  
})

test_that("Violin Plot stops when no genes are present", {
  
  kidney_dat <- select_dataset_violin("kidney")
  
  incorrect_genes <- paste0("jibberish",1:10)
  
  expect_error(violinPlot(data = kidney_dat$object, genes = incorrect_genes, expr.type = kidney_dat$test_expr_type,
                               group = kidney_dat$test_group), "no genes were found in DSP data")
  
})

test_that("Violin Plot stops when incorrect grouping parameter is selected", {
  
  kidney_dat <- select_dataset_violin("kidney")
  
  expect_error(violinPlot(data = kidney_dat$object, genes = kidney_dat$test_genes, expr.type = kidney_dat$test_expr_type,
                               group = "jibberish"), "grouping parameter was not found in DSP data")
  
})

test_that("Violin Plot stops when incorrect faceting parameter is selected", {
  
  kidney_dat <- select_dataset_violin("kidney")
  
  expect_error(violinPlot(data = kidney_dat$object, genes = kidney_dat$test_genes, expr.type = kidney_dat$test_expr_type,
                               group = kidney_dat$test_group, facet.by = "jibberish"), "facet parameter was not found in DSP data")
  
})
