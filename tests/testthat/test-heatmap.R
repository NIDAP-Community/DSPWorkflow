test_that("making heatmap plot---Test Human Kidney dataset", {
  
  # kidney.dat <- readRDS("/rstudio-files/ccr-dceg-data/users/Difei/DSP/DSPWorkflow/tests/testthat/fixtures/Human_Kidney/normalizationHumanKidney.RDS")
  # kidney.dat <- readRDS(test_path("fixtures/Human_Kidney","normalizationHumanKidney.RDS"))
  
  
  kidney.dat <- select_normalized_RTD("kidney")
  
  dsp.list <- heatMap(
    ## Basic Parameters
    kidney.dat, 
    norm.method = "quant",
    annotation.col = c("class", "segment", "region"),
    ngenes = 500,

    ## Visualization
    scale.by.row.or.col = "row",
    show.rownames = FALSE,
    show.colnames = FALSE,
    
    ## Clustering
    clustering.method = "average",
    cluster.rows = TRUE,
    cluster.cols = TRUE,
    clustering.distance.rows = "correlation",
    clustering.distance.cols = "correlation",
    annotation.row = NA,
    #annotation.col = pData(target.data)[, c("class", "segment", "region")],
    
    ## Image
    image.width = 3600,
    image.height = 1800,
    image.resolution = 300,
    image.filename = "heatmap.clust.highCVgenes.png",
    breaks.by.values = seq(-3, 3, 0.05), # 6/0.05=120 colors
    heatmap.color = colorRampPalette(c("blue", "white", "red"))(120))  
  
  print(dsp.list$plot)
  expected.elements = c("plot.genes", "plot")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})

test_that("making heatmap plot---Test Colon Dataset", {
  
  colon.dat <- select_normalized_RTD("colon")
  
  dsp.list <- heatMap(
    ## Basic Parameters
    colon.dat, 
    norm.method = "quant",
    annotation.col = c("class", "segment", "region"),
    ngenes = 800,
    
    ## Visualization
    scale.by.row.or.col = "row",
    show.rownames = FALSE,
    show.colnames = FALSE,
    
    ## Clustering
    clustering.method = "average",
    cluster.rows = TRUE,
    cluster.cols = TRUE,
    clustering.distance.rows = "correlation",
    clustering.distance.cols = "correlation",
    annotation.row = NA,
    #annotation.col = pData(target.data)[, c("class", "segment", "region")],
    
    ## Image
    image.width = 3600,
    image.height = 1800,
    image.resolution = 300,
    image.filename = "heatmap.clust.highCVgenes.png",
    breaks.by.values = seq(-3, 3, 0.05), # 6/0.05=120 colors
    heatmap.color = colorRampPalette(c("blue", "white", "red"))(120))  
  
  print(dsp.list$plot)
  expected.elements = c("plot.genes", "plot")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})

test_that("making heatmap plot---Test Mouse Thymus Dataset", {
  
  thymus.dat <- select_normalized_RTD("thymus")
  
  dsp.list <- heatMap(
    ## Basic Parameters
    thymus.dat, 
    norm.method = "quant",
    annotation.col = c("class", "segment", "region"),
    ngenes = 1000,
    
    ## Visualization
    scale.by.row.or.col = "row",
    show.rownames = FALSE,
    show.colnames = FALSE,
    
    ## Clustering
    clustering.method = "average",
    cluster.rows = TRUE,
    cluster.cols = TRUE,
    clustering.distance.rows = "correlation",
    clustering.distance.cols = "correlation",
    annotation.row = NA,
    #annotation.col = pData(target.data)[, c("class", "segment", "region")],
    
    ## Image
    image.width = 3600,
    image.height = 1800,
    image.resolution = 300,
    image.filename = "heatmap.clust.highCVgenes.png",
    breaks.by.values = seq(-3, 3, 0.05), # 6/0.05=120 colors
    heatmap.color = colorRampPalette(c("blue", "white", "red"))(120))  
  
  print(dsp.list$plot)
  expected.elements = c("plot.genes", "plot")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})

test_that("making heatmap plot---Test Human NSCLC Dataset", {
  
  nsclc.dat <- select_normalized_RTD("nsclc")
  
  dsp.list <- heatMap(
    ## Basic Parameters
    nsclc.dat, 
    norm.method = "quant",
    annotation.col = c("class", "segment", "region"),
    ngenes = 2000,
    
    ## Visualization
    scale.by.row.or.col = "row",
    show.rownames = FALSE,
    show.colnames = FALSE,
    
    ## Clustering
    clustering.method = "average",
    cluster.rows = TRUE,
    cluster.cols = TRUE,
    clustering.distance.rows = "correlation",
    clustering.distance.cols = "correlation",
    annotation.row = NA,
    #annotation.col = pData(target.data)[, c("class", "segment", "region")],
    
    ## Image
    image.width = 3600,
    image.height = 1800,
    image.resolution = 300,
    image.filename = "heatmap.clust.highCVgenes.png",
    breaks.by.values = seq(-3, 3, 0.05), # 6/0.05=120 colors
    heatmap.color = colorRampPalette(c("blue", "white", "red"))(120))  
  
  print(dsp.list$plot)
  expected.elements = c("plot.genes", "plot")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)
  
})


#test_that("making heatmap plot---Test Human NSCLC Dataset", {
  
#  nsclc.dat <- select_normalized_RTD("nsclc")
  
#  expect_error(heatMap(nsclc.dat, norm.method="Quantile",...), "Error: Quantile needs to be quant")
#})