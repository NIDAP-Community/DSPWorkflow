test_that("violin plot function works", {
  
  test_data <- eval(parse(text = load(test_path("fixtures", "target_demoData.RData"))))
  
  test_genes <- head(rownames(target_demoData@assayData$q_norm),5)
  
  violin_plot_test <- violin_function(data = test_data, genes = test_genes)
  
  violin_output <- class(violin_plot_test)
  
  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(length(setdiff(expected.elements, violin_output)), 0)
  
})
