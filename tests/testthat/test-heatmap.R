test_that("making heatmap plot", {

    target.Data <- readRDS(test_path("fixtures", "target.Data.rds"))  
    
    # HeatMap <- function(target.data, ngenes, image.width, image.height, image.filename, image.resolution, heatmap.color)
    color <- colorRampPalette(c("blue", "white", "red"))(120)
    dsp.list <- HeatMap(target.Data, 200, 3600, 1800, 300, "heatmap.clust.highCVgenes.png", color)
    
    print(dsp.list$plot)
    expected.elements = c("plot.genes", "plot")
    expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})
