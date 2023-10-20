#' Helper functions comes from
#' https://bioconductor.org/packages/release/bioc/vignettes/SpatialDecon/inst/doc/SpatialDecon_vignette_NSCLC.html
#' 
#' @title Spatial Deconvolution
#' 
#' @description spatialDeconvolution estimate cell composition across DSP
#'              samples from reference expression matrix
#'
#' @details Uses Nanostring developed functions to compute estimated cell
#'          fractions in DSP samples. Allows for users to group samples based
#'          on metadata information
#'
#' @param object Nanostring object containing normalized gene expression data
#' @param expr.type Name of slot containing normalized gene expression data
#' @param prof.mtx Use stored profile matrix
#' @param clust.rows Cluster rows in heatmap (Default: TRUE)
#' @param clust.cols Cluster columns in heatmap (Default: TRUE)
#' @param group.by Organize heatmap / barplot columns by metadata group 
#'                 (Default: "none")
#' @param plot.fontsize Set size of labels on all figures (Default: 5)
#' @param use.custom.matrix Generate custom profile matrix (Default: FALSE)
#' @param discard.celltype Remove any celltype(s) that is not of interest 
#'                         (Default: FALSE)
#' @param normalize Scale profile matrix gene expression according to gene count 
#'                  (Default: FALSE)
#' @param min.cell.num Prevent deconvolution of celltype(s) if number of
#'                     corresponding cells is below this threshold (Default: 0)
#' @param min.genes Filter cells based on minimum number of genes expressed 
#'                  (Default: 10)
#' @param ref.mtx Custom reference expression matrix (Gene x Reference_Samples)
#' @param ref.annot Custom reference data.frame with cell.id and celltype 
#'                  information
#' @param cell.id.col Column of data.frame containing cell.id.col info
#' @param celltype.col Column of data.frame containing celltype info
#'
#' @importFrom NanoStringNCTools negativeControlSubset
#' @importFrom SpatialDecon derive_GeoMx_background
#' @importFrom SpatialDecon spatialdecon
#' @importFrom SpatialDecon create_profile_matrix
#' @importFrom reshape2 melt
#' @importFrom ComplexHeatmap pheatmap
#'
#' @export
#'
#' @return A list dsp.data containing the results of spatial deconvolution,
#' res$beta: matrix of estimated cell abundances
#' res$X: cell signature (gene x celltype) matrix used to generate
#'        deconvolution results
#' res$yhat, res$resids: fitted values and log2-scale residuals from
#'                       deconvolution, can be used to measure goodness of fit
#' res$prop_of_all: res$beta scaled to proportion of celltype across sample
#' figures: heatmap and barplot of cell profile matrix and estimated
#'          cell abundances in data


spatialDeconvolution <- function(object,
                                 expr.type = "q_norm",
                                 prof.mtx,
                                 clust.rows = TRUE,
                                 clust.cols = TRUE,
                                 group.by = "none",
                                 plot.fontsize = 5,
                                 use.custom.prof.mtx = FALSE,
                                 discard.celltype = FALSE,
                                 normalize = FALSE,
                                 min.cell.num = 0,
                                 min.genes = 10,
                                 ref.mtx,
                                 ref.annot,
                                 cell.id.col = "CellID",
                                 celltype.col = "LabeledCellType") {
  
  # Check for Parameter Misspecification Error(s)
  if (!expr.type %in% names(object@assayData)) {
    stop("Normalized data slot not found in the data")
  } else if (!group.by == "none") {
    if (!group.by %in% colnames(pData(object))) {
      stop ("Check that group.by category is present in metadata")
    }
  }
  
  norm.data <- assayDataElement(object, elt = expr.type)
  
  # Calculate negative background
  neg.sub <- negativeControlSubset(object)
  
  bg = derive_GeoMx_background(
    norm = norm.data,
    probepool = fData(object)$Module,
    negnames = neg.sub@featureData@data$TargetName
  )
  
  if(use.custom.prof.mtx){
    # Create custom matrix for input to spatial deconvolution
    prof.mtx.deconv <- create_profile_matrix(
      mtx = ref.mtx,
      cellAnnots = ref.annot,
      cellNameCol = cell.id.col,
      cellTypeCol = celltype.col,
      matrixName = "customDSPmtx",
      outDir = NULL,
      normalize = normalize,
      minCellNum = min.cell.num,
      minGenes = min.genes,
      scalingFactor = 1,
      discardCellTypes = discard.celltype
  )} else {
      prof.mtx.deconv <- prof.mtx
  }
  
  # Run Spatial Deconvolution
  res <- spatialdecon(
    norm = norm.data,
    bg = bg,
    X = prof.mtx.deconv,
    align_genes = TRUE
  )
  
  # Prepare data for Abundance Barplot
  cell.comp <- as.data.frame(res$prop_of_all)
  cell.comp$celltype <- rownames(cell.comp)
  
  cell.comp <- melt(cell.comp)
  
  # For checking that composition plots are consistent across runs
  cell.comp$celltype <- factor(cell.comp$celltype, 
                               levels = unique(cell.comp$celltype))
  
  # Heatmap and composition barplot optionally sorted by group
  if (!group.by == "none") {
    # Prepare group sorted annotation tables for heatmap and barplot
    annot <- pData(object)
    arr.annot <- annot[order(annot[group.by]),]
    
    pheat.df <- data.frame(group = arr.annot[group.by])
    arr.heat.mtx <-
      res$beta[, match(rownames(pheat.df), colnames(res$beta))]
    
    cell.comp[group.by] <-
      annot[group.by][match(cell.comp$variable,
                            rownames(annot)),]
    
    # Create plots
    set.seed(123)
    abund.heat <-
      ComplexHeatmap::pheatmap(
        t(arr.heat.mtx), 
        cluster_rows = clust.rows,
        cluster_cols = clust.cols,
        annotation_row = pheat.df,
        legend = FALSE,
        fontsize = plot.fontsize
      )
    
    set.seed(4)
    comp.bar <- ggplot(data = cell.comp, aes(x = variable, y = value, 
                                             fill = celltype)) +
      geom_bar(stat = "identity") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, 
                                       size = plot.fontsize), 
            legend.title=element_blank()) +
      facet_wrap(~ eval(parse(text = group.by)), scales =
                   "free")
    
  } else {
    set.seed(123)
    abund.heat <- ComplexHeatmap::pheatmap(t(res$beta), 
                                           cluster_rows = clust.rows, 
                                           cluster_cols = clust.cols, 
                                           legend = FALSE,
                                           fontsize = plot.fontsize)
    
    set.seed(4)
    comp.bar <- ggplot(data = cell.comp, aes(x = variable, y = value, 
                                             fill = celltype)) + 
      geom_bar(stat = "identity") +
      theme(axis.text.x = element_text(angle = 90, hjust =
                                         1, size = plot.fontsize), 
            legend.title=element_blank())
  }
  
  set.seed(6)
  # Heatmap of cell profile matrix used ~ res$X
  cell.prof.heat <- ComplexHeatmap::pheatmap(res$X, 
                                             cluster_rows = clust.rows,
                                             cluster_cols = clust.cols, 
                                             legend = FALSE,
                                             fontsize = plot.fontsize)
  
  # Creates and stores all ggplot figures in a list
  plot.list = list(
    abundance.heatmap = abund.heat,
    cell.profile.heatmap = cell.prof.heat,
    composition.barplot = comp.bar
  )
  
  final.dsp.results <- list(dsp.data = res, figures = plot.list)
  
  return(final.dsp.results)
}
