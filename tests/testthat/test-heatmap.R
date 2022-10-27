test_that("making heatmap plot", {

    target.data <- readRDS(test_path("fixtures", "target.Data.rds"))  
    
    ngenes <- 200
    image.width <- 3600
    image.height <- 1800
    image.resolution <- 300
    image.filename <- "heatmap.clust.highCVgenes.png"
    
    scale.by.row.or.col <- "row"
    show.rownames <- FALSE
    show.colnames <- FALSE
    
    clustering.method <- "average"
    cluster.rows <- TRUE
    cluster.cols <- TRUE
    clustering.distance.rows <- "correlation"
    clustering.distance.cols <- "correlation"
    annotation.row <- NA
    annotation.col <- pData(target.data)[, c("class", "segment", "region")]
    breaks.by.values <- seq(-3, 3, 0.05) # 6/0.05=120 colors
    heatmap.color <- colorRampPalette(c("blue", "white", "red"))(120)
    
    norm.method <- "quant"
    
#    dsp.list <- HeatMap(target.Data, 200, 3600, 1800, 300, "heatmap.clust.highCVgenes.png", color)
    dsp.list <- HeatMap(target.data, ngenes, image.width, image.height, image.resolution, image.filename,
                        scale.by.row.or.col, show.rownames, show.colnames, clustering.method, cluster.rows, cluster.cols,
                        clustering.distance.rows, clustering.distance.cols, annotation.row, annotation.col, 
                        breaks.by.values, heatmap.color, norm.method)
    print(dsp.list$plot)
    expected.elements = c("plot.genes", "plot")
    expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})
