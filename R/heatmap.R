####This code comes from
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#62_Clustering_high_CV_Genes

#' NanoString Digital Spatial Profile study
#' 
#' 1. Exploring the normalized data by calculating the coefficient of variation (CV) for each gene (g) using the formula CVg=SDg/meang.
#' 2. We then identify genes with high CVs that should have large differences across the various profiled segments. 
#' 3. This unbiased approach can reveal highly variable genes across the study.
#' 4. We plot the results using unsupervised hierarchical clustering, displayed as a heatmap.

#' @param target.data Normalized targetData S4 object input file.
####### filename file path where to save the heatmap plot as "heatmap.pdf" by default. 
#'
#' @importFrom NanoStringNCTools assayDataApply
#' @importFrom Biobase assayDataElement
#' @import pheatmap
#' 
#' @export
#' 
#' @return A list containing the plot genes data matrix, and the heatmap plot.

## target_demoData is the output S4 obj from normalization step
##
HeatMap <- function(target.data) {

## log2 transformation
#log2.data <- assayDataElement(object = target.data, elt = "log_q") <- 
#  assayDataApply(target.data, 2, FUN = log, base = 2, elt = "q_norm")

assayDataElement(object = target.data, elt = "log_q") <- 
     assayDataApply(target.data, 2, FUN = log, base = 2, elt = "q_norm")
  
# create CV function
calc.cv <- function(x) {sd(x) / mean(x)}
cv.dat <- assayDataApply(target.data,
                         elt = "log_q", MARGIN = 1, calc.cv)
# show the highest CD genes and their CV values
sort(cv.dat, decreasing = TRUE)[1:5]
#>   CAMK2N1    AKR1C1      AQP2     GDF15       REN 
#> 0.5886006 0.5114973 0.4607206 0.4196469 0.4193216

# Identify genes in the top 3rd of the CV values
goi <- names(cv.dat)[cv.dat > quantile(cv.dat, 0.8)]

# output heatmap inot pdf file
#pdf(file=filename)
plot.genes <- assayDataElement(target.data[goi, ], elt = "log_q")

p <- pheatmap(plot.genes,
         scale = "row",
         show_rownames = FALSE, show_colnames = FALSE,
         border_color = NA,
         clustering_method = "average",
         clustering_distance_rows = "correlation",
         clustering_distance_cols = "correlation",
         breaks = seq(-3, 3, 0.05),
         color = colorRampPalette(c("purple3", "black", "yellow2"))(120),
         annotation_col = pData(target.data)[, c("class", "segment", "region")])

#return(list("log2.data" = log2.data, "plot.genes"=plot.genes, plot" = p))
return(list("plot.genes" = plot.genes, "plot" = p))
}