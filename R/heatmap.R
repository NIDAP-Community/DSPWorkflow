####This code comes from
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#62_Clustering_high_CV_Genes

#' NanoString Digital Spatial Profile study
#' 
#' 1. Exploring the normalized data by calculating the coefficient of variation (CV) for each gene (g) using the formula CVg=SDg/meang.
#' 2. We then identify genes with high CVs that should have large differences across the various profiled segments. 
#' 3. This unbiased approach can reveal highly variable genes across the study.
#' 4. We plot the results using unsupervised hierarchical clustering, displayed as a heatmap.

#' @param target.data Normalized targetData S4 object input file.
#' @param ngenes Number of high CV genes to cluster and plot
#' @param image.width image width
#' @param image.height image height
#' @param image.resolution image resolution
#' @param image.filename image filename
#' @param scale.by.row.or.col scale by row or by col ("row", "column" and "none")
#' @param show.rownames boolean specifying if row names are be shown.
#' @param show.colnames boolean specifying if column names are be shown.
#' @param clustering.method clustering method used. Accepts the same values as hclust. e.g "ward.D", "ward.D2", "single", "complete", "average"
#' @param cluster.rows boolean values determining if rows should be clustered or hclust object,
#' @param cluster.cols boolean values determining if cols should be clustered or hclust object,
#' @param clustering.distance.rows distance for clustering by rows (correlation, or euclidean)
#' @param clustering.distance.cols distance for clustering by cols (correlation, or euclidean)
#' @param annotation.row the annotations shown on left side of the heatmap
#' @param annotation.col the annotations shown on right side of the heatmap
#' @param breaks.by.values a sequence of numbers that covers the range of values in mat e.g seq(-3, 3, 0.05), 6/0.05=120 colors. 
#' @param heatmap.color colors of heatmap colorRampPalette(c("blue", "white", "red"))(120), here 120 is consistent with 120 above.
#' @param norm.method normalization method quant: Upper quartile (Q3) normalization and neg: background normalization
#' 
#' @importFrom NanoStringNCTools assayDataApply
#' @importFrom Biobase assayDataElement
#' @import pheatmap
#' 
#' @export
#' 
#' @return A list containing the plot genes data matrix, and the heatmap plot.
##
## target.data is the output S4 obj from normalization step
##
########################################################################################################################################
########## pheatmap arguments ##########################################################################################################
########################################################################################################################################
# mat                           numeric matrix of the values to be plotted.
# color                         vector of colors used in heatmap.
# kmeans_k                      the number of kmeans clusters to make, if we want to aggregate the rows before
#                               drawing heatmap. If NA then the rows are not aggregated.
# breaks                        a sequence of numbers that covers the range of values in mat and is one element
#                               longer than color vector. Used for mapping values to colors. Useful, if needed
#                               to map certain values to certain colors, to certain values. If value is NA then
#                               the breaks are calculated automatically. When breaks do not cover the range of
#                               values, then any value larger than max(breaks) will have the largest color and
#                               any value lower than min(breaks) will get the lowest color.
# border_color                  color of cell borders on heatmap, use NA if no border should be drawn.
# cellwidth                     individual cell width in points. If left as NA, then the values depend on the size of plotting window
# cellheight                    individual cell height in points. If left as NA, then the values depend on the size of plotting window.
# scale                         character indicating if the values should be centered and scaled in either the row
#                               direction or the column direction, or none. Corresponding values are "row","column" and "none"
# cluster_rows                  boolean values determining if rows should be clustered or hclust object,
# cluster_cols                  boolean values determining if columns should be clustered or hclust object.
# clustering_distance_rows      distance measure used in clustering rows. Possible values are "correlation"
#                               for Pearson correlation and all the distances supported by dist, such as "euclidean",
#                               etc. If the value is none of the above it is assumed that a distance matrix is provided.
# clustering_distance_cols      distance measure used in clustering columns. Possible values the same as for clustering_distance_rows.
# clustering_method             clustering method used. Accepts the same values as hclust.
# clustering_callback           callback function to modify the clustering. Is called with two parameters: original hclust object and 
#                               the matrix used for clustering. Must return a hclust object.
# cutree_cols                   similar to cutree_rows, but for columns
# treeheight_row                the height of a tree for rows, if these are clustered. Default value 50 points.
# treeheight_col                the height of a tree for columns, if these are clustered. Default value 50 points.
# legend                        logical to determine if legend should be drawn or not.
# legend_breaks                 vector of breakpoints for the legend.
# legend_labels                 vector of labels for the legend_breaks.
# annotation_row                data frame that specifies the annotations shown on left side of the heatmap.
#                               Each row defines the features for a specific row. The rows in the data and in
#                               the annotation are matched using corresponding row names. Note that color
#                               schemes takes into account if variable is continuous or discrete.
# annotation_col                similar to annotation_row, but for columns.
# annotation                    deprecated parameter that currently sets the annotation_col if it is missing
# annotation_colors             list for specifying annotation_row and annotation_col track colors manually. It
#                               is possible to define the colors for only some of the features. Check examples
#                               for details.
# annotation_legend             boolean value showing if the legend for annotation tracks should be drawn.
# annotation_names_row          boolean value showing if the names for row annotation tracks should be drawn.
# annotation_names_col          boolean value showing if the names for column annotation tracks should be drawn.
# drop_levels                   logical to determine if unused levels are also shown in the legend
# show_rownames                 boolean specifying if row names are be shown.
# show_colnames                 boolean specifying if column names are be shown.
# main                          the title of the plot
# fontsize                      base fontsize for the plot
# fontsize_row                  fontsize for rownames (Default: fontsize)
# fontsize_col                  fontsize for colnames (Default: fontsize)
# angle_col                     angle of the column labels, right now one can choose only from few predefined options (0, 45, 90, 270 and 315)
# display_numbers               logical determining if the numeric values are also printed to the cells. If this is a matrix (with same 
#                               dimensions as original matrix), the contents of the matrix are shown instead of original values.
# number_format                 format strings (C printf style) of the numbers shown in cells. For example "%.2f" shows 2 decimal places
#                               and "%.1e" shows exponential notation (see more in sprintf).
# number_color                  color of the text
# fontsize_number               fontsize of the numbers displayed in cells
# gaps_row                      vector of row indices that show where to put gaps into heatmap. Used only if the rows are not clustered.
#                               See cutree_row to see how to introduce gaps to clustered rows.
# gaps_col                      similar to gaps_row, but for columns.
# labels_row                    custom labels for rows that are used instead of rownames.
# labels_col                    similar to labels_row, but for columns.
# filename                      file path where to save the picture. Filetype is decided by the extension in the path. Currently following 
#                               formats are supported: png, pdf, tiff, bmp, jpeg. Even if the plot does not fit into the plotting window,
#                               the file size is calculated so that the plot would fit there, unless specified otherwise.
# width                         manual option for determining the output file width in inches.
# height                        manual option for determining the output file height in inches.
# silent                        do not draw the plot (useful when using the gtable output)
# na_col                        specify the color of the NA cell in the matrix.
# ...                           graphical parameters for the text used in plot. Parameters passed to grid.text,see gpar.

HeatMap <- function(target.data, ngenes, image.width, image.height, image.resolution, image.filename,
                    scale.by.row.or.col, show.rownames, show.colnames, clustering.method, cluster.rows, cluster.cols,
                    clustering.distance.rows, clustering.distance.cols, annotation.row, annotation.col, 
                    breaks.by.values, heatmap.color, norm.method) {

## log2 transformation
#log2.data <- assayDataElement(object = target.data, elt = "log_q") <- 
#  assayDataApply(target.data, 2, FUN = log, base = 2, elt = "q_norm")

if(norm.method == "quant") elt.value <- "q_norm"  # Upper quartile (Q3) normalization
if(norm.method == "neg") elt.value <- "neg_norm"  # background normalization

assayDataElement(object = target.data, elt = "log_q") <- 
     assayDataApply(target.data, 2, FUN = log, base = 2, elt = elt.value)
  
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

## image params
# width <- image.width
# height <- image.height
# resolution <- image.resolution
# filename <- image.filename

## heatmap color
col.palette <- heatmap.color  # color = colorRampPalette(c("blue", "white", "red"))(120)

p <- pheatmap(plot.genes[1:ngenes,],
         main ="Clustering high CV genes",
         scale = scale.by.row.or.col, # "row",
         show_rownames = show.rownames, # FALSE, 
         show_colnames = show.colnames, # FALSE,
         border_color = NA,
         clustering_method = clustering.method, # "average"
         cluster_rows = cluster.rows, ## T
         cluster_cols = cluster.cols, ## T
         clustering_distance_rows = clustering.distance.rows, ## "correlation",
         clustering_distance_cols = clustering.distance.cols, ## "correlation",
         breaks = breaks.by.values, # seq(-3, 3, 0.05),
         color = col.palette,
         annotation_col = pData(target.data)[, c("class", "segment", "region")])

png(filename=image.filename, width=image.width, height=image.height, units="px", pointsize=4, bg="white", res=image.resolution, type="cairo")
 print(p)
dev.off()

#return(list("log2.data" = log2.data, "plot.genes"=plot.genes, plot" = p))
return(list("plot.genes" = plot.genes, "plot" = p))
}
