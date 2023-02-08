test_that("Test Human Kidney dataset", {
  
  kidney.dat <- select_normalized_RTD("kidney")
  
  dsp.list <- HeatMap(
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

test_that("Test Colon Dataset", {
  
  colon.dat <- select_normalized_RTD("colon")
  
  dsp.list <- HeatMap(
    ## Basic Parameters
    colon.dat, 
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

test_that("Test Mouse Thymus Dataset", {
  
  thymus.dat <- select_normalized_RTD("thymus")
  
  dsp.list <- HeatMap(
    ## Basic Parameters
    thymus.dat, 
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

test_that("Test Human NSCLC Dataset", {
  
  nsclc.dat <- select_normalized_RTD("nsclc")
  
  dsp.list <- HeatMap(
    ## Basic Parameters
    nsclc.dat, 
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

test_that("making heatmap plot---Human Kidney, Mouse Thymus, Human Colon, NSCLC", {

#    target.data <- readRDS(test_path("fixtures", "target.Data.rds"))  
#    target.data <- readRDS("/rstudio-files/ccr-dceg-data/users/Difei/DSP/DSPWorkflow/tests/testthat/fixtures/Human_Kidney/normalizationHumanKidney.RDS")

for (dataset in c("kidney","thymus","colon","nsclc")) 
{

  message("Loading ", dataset)
  if (dataset == "kidney"){
     target.data <- readRDS(test_path("fixtures/Human_Kidney", "normalizationHumanKidney.RDS"))
  } else if (dataset == "thymus") {
     target.data <- readRDS(test_path("fixtures/Mouse_Thymus", "normalizationMouseThymus.RDS"))
  } else if (dataset == "colon") {
     target.data <- readRDS(test_path("fixtures/Human_Colon", "normalizationHumanColon.RDS"))
  } else if (dataset == "nsclc") {
     target.data <- readRDS(test_path("fixtures/Human_NSCLC", "normalizationHumanNSCLC.RDS"))
  }

#    ngenes <- 200
#    image.width <- 3600
#    image.height <- 1800
#    image.resolution <- 300
#    image.filename <- "heatmap.clust.highCVgenes.png"
    
#    scale.by.row.or.col <- "row"
#    show.rownames <- FALSE
#    show.colnames <- FALSE
    
#    clustering.method <- "average"
#    cluster.rows <- TRUE
#    cluster.cols <- TRUE
#    clustering.distance.rows <- "correlation"
#    clustering.distance.cols <- "correlation"
#    annotation.row <- NA
#    annotation.col <- pData(target.data)[, c("class", "segment", "region")]
#    breaks.by.values <- seq(-3, 3, 0.05) # ()6/0.05=120 colors
#    heatmap.color <- colorRampPalette(c("blue", "white", "red"))(120)
    
#    norm.method <- "quant"
    
#    dsp.list <- HeatMap(target.Data, 200, 3600, 1800, 300, "heatmap.clust.highCVgenes.png", color)
#    dsp.list <- HeatMap(target.data, ngenes, image.width, image.height, image.resolution, image.filename,
#                        scale.by.row.or.col, show.rownames, show.colnames, clustering.method, cluster.rows, cluster.cols,
#                        clustering.distance.rows, clustering.distance.cols, annotation.row, annotation.col, 
#                        breaks.by.values, heatmap.color, norm.method)
    dsp.list <- HeatMap(
    ## Basic Parameters
      target.data, 
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

} ## end for loop
  
})

