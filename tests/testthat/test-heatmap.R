test_that("making heatmap plot", {

    target.Data <- readRDS(test_path("fixtures", "target.Data.rds"))  
    
    dsp.list <- HeatMap(target.Data)
    
    print(dsp.list$plot)
    expected.elements = c("plot.genes", "plot")
    expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})
