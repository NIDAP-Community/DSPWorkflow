####This code comes from
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows
#/inst/doc/GeomxTools_RNA-NGS_Analysis.html#62_Clustering_high_CV_Genes
#'
#' Clustering high CV Genes and making a heatmap
#'
#' 1. Exploring the normalized data by calculating the coefficient of variation 
#'    (CV) for each gene (g) using the formula CVg=SDg/meang.
#' 2. We then identify genes with high CVs that should have large differences 
#'    across the various profiled segments.
#' 3. This unbiased approach can reveal highly variable genes across the study.
#' 4. We plot the results using unsupervised hierarchical clustering, displayed 
#'    as a heatmap.
#'    
#' @title Clustering high CV Genes and making a heatmap
#'
#' @description heatmap returns a heatmap plot and a list of genes in the plot
#'
#' @details This function will run pheatmap from the GeoMxTools package.

#' @param object object Normalized NanoStringGeoMxSet object to use for heatmap.
#'               It is a S4 object.
#' @param norm.method normalization method quant: Upper quartile (Q3) 
#'        normalization and neg: background normalization (Default: quant)
#' @param annotation.col the annotations shown on right side of the heatmap
#'                      (Default: c("class", "segment", "region"))
#' @param ngenes Number of high CV genes to cluster and plot (Default: 200)
#' @param scale.by.row.or.col Scale.by perform z-scaling. Choices are "row", 
#'                            "column" and "none" (Default: "row")
#' @param show.rownames Boolean specifying if row names are be shown.
#'                      (Default: FALSE)
#' @param show.colnames Boolean specifying if column names are be shown.
#'                      (Default: FALSE)
#' @param clustering.method Clustering method used. Accepts the same values as 
#'.       hclust. e.g "ward.D", "ward.D2", "single", "complete", "average"
#'.       (Default: "average")
#' @param cluster.rows Boolean values determining if rows should be clustered 
#'        or hclust object (Default: TRUE)
#' @param cluster.cols Boolean values determining if cols should be clustered 
#'        or hclust object (Default: TRUE)
#' @param clustering.distance.rows Distance for clustering by rows 
#'        (correlation, or euclidean) (Default: "correlation")
#' @param clustering.distance.cols Distance for clustering by cols 
#'        (correlation, or euclidean) (Default: "correlation")
#' @param annotation.row A data frame that specifies the annotations shown 
#'                       on left side of the heatmap (Default: NA)
#' @param breaks.by.values A sequence of numbers that covers the range of 
#'        values in mat (Deafult: seq(-3, 3, 0.05), provides 120 colors)
#' @param heatmap.color Colors of heatmap to match breaks above 
#'                      (Default: colorRampPalette(
#'                       c("blue", "white", "red"))(120))
#'
#' @importFrom NanoStringNCTools assayDataApply
#' @importFrom Biobase assayDataElement
#' @importFrom ComplexHeatmap pheatmap
#'
#' @export
#'
#' @return A list containing the plot genes data matrix, and the heatmap plot
##
heatMap <- function(
  object,
  norm.method = "quant",
  annotation.col = c("class", "segment", "region"),
  ngenes = 200,
  scale.by.row.or.col = "row",
  show.rownames = FALSE,
  show.colnames = FALSE,
  clustering.method = "average",
  cluster.rows = TRUE,
  cluster.cols = TRUE,
  clustering.distance.rows = "correlation",
  clustering.distance.cols = "correlation",
  annotation.row = NA,
  breaks.by.values = seq(-3, 3, 0.05),
  heatmap.color = colorRampPalette(c("blue", "white", "red"))(120)) {

  # norm.method must be either quant or neg
  if((norm.method != "quant") && (norm.method != "neg")){
    stop(paste0("Error: Normalization method should be either quant or neg"))
  }
  
  if (norm.method == "quant") {
    elt.value <- "q_norm"  # Upper quartile (Q3) normalization
  }
  if (norm.method == "neg") {
    elt.value <- "neg_norm"  # background normalization
  }
  
  #log2 transformation
  Biobase::assayDataElement(object = object, elt = "log_q") <-
    assayDataApply(object,
                   2,
                   FUN = log,
                   base = 2,
                   elt = elt.value)
  
  # create CV function
  .calcCv <- function(x) {
    sd(x) / mean(x)
  }
  cv.dat <- assayDataApply(object,
                           elt = "log_q", MARGIN = 1, .calcCv)
  # show the highest CD genes and their CV values
  sort(cv.dat, decreasing = TRUE)[1:5]
  
  # Identify genes in the top 3rd of the CV values
  goi <- names(cv.dat)[cv.dat > quantile(cv.dat, 0.8)]
  
  
  # make gene list for plot
  plot.genes <-
    Biobase::assayDataElement(object[goi,], elt = "log_q")
  
  # image color
  col.palette <-
    heatmap.color  
  anno.col <- 
    pData(object)[, annotation.col]
  
  # make plot
  p <- pheatmap(
    plot.genes[1:ngenes, ],
    main = "Clustering high CV genes",
    scale = scale.by.row.or.col,
    show_rownames = show.rownames,
    show_colnames = show.colnames,
    border_color = NA,
    clustering_method = clustering.method,
    cluster_rows = cluster.rows,
    cluster_cols = cluster.cols,
    clustering_distance_rows = clustering.distance.rows,
    clustering_distance_cols = clustering.distance.cols,
    breaks = breaks.by.values,
    color = col.palette,
    annotation_col = anno.col
  )
  
  ## gene.df converts to data frame
  gene.df <- as.data.frame(plot.genes)
  
  ## add genename column to the output matrix
  plot.genes <- gene.df %>% rownames_to_column("gene")
  
  ## stores ggplot figure and plot.genes in a list
  dsp.results <- list("plot.genes" = plot.genes, "plot" = p)
  
  return(dsp.results)
}

