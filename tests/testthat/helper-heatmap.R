getDataset <- function(data) {
  if (data == "kidney") {
    object <- selectNormalizedRtd("kidney")
  }
  if (data == "thymus") {
    object <- selectNormalizedRtd("thymus")
  }
  if (data == "colon") {
    object <- selectNormalizedRtd("colon")
  }
  if (data == "nsclc") {
    object <- selectNormalizedRtd("nsclc")
  }
  
  norm.method = "quant"
  annotation.col = c("class", "segment", "region")
  ngenes = 1000
  scale.by.row.or.col = "row"
  show.rownames = FALSE
  show.colnames = FALSE
  clustering.method = "average"
  cluster.rows = TRUE
  cluster.cols = TRUE
  clustering.distance.rows = "correlation"
  clustering.distance.cols = "correlation"
  annotation.row = NA
  image.width = 3600
  image.height = 1800
  image.resolution = 300
  image.filename = "heatmap.clust.highCVgenes.png"
  breaks.by.values = seq(-3, 3, 0.05) # 6/0.05=120 colors
  heatmap.color = colorRampPalette(c("blue", "white", "red"))(120)  

  return(
    list(
      "object" = object,
      "norm.method" = norm.method,
      "annotation.col" = annotation.col,
      "ngenes" = ngenes,
      "scale.by.row.or.col" = scale.by.row.or.col,
      "show.rownames" = show.rownames,
      "show.colnames" = show.colnames,
      "clustering.method" = clustering.method,
      "cluster.rows" = cluster.rows,
      "cluster.cols" = cluster.cols,
      "clustering.distance.rows" = clustering.distance.rows,
      "clustering.distance.cols" = clustering.distance.cols,
      "annotation.row" = annotation.row,
      "image.width" = image.width,
      "image.height" = image.height,
      "image.resolution" = image.resolution,
      "image.filename" = image.filename,
      "breaks.by.values" = breaks.by.values,
      "heatmap.color" = heatmap.color 
    )
  )
}