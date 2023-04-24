#' @title Spatial Deconvolution
#'
#' Helper functions comes from
#' https://bioconductor.org/packages/release/bioc/vignettes/SpatialDecon/inst/doc/SpatialDecon_vignette_NSCLC.html
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
#' @param ref.mtx Reference expression matrix (Gene x Reference_Samples)
#' @param ref.annot Reference data.frame with cell.id and celltype information
#' @param cell.id.col Column of data.frame containing cell.id.col info
#' @param celltype.col Column of data.frame containing celltype info
#' @param matrix.name Name given to deconvolution signature matrix
#' @param normalize Scale profile matrix gene expression according to gene count
#' @param group.by Organize heatmap / barplot columns by metadata group
#' @param out.directory Path to desired output directory, set to NULL if matrix
#'                      should not be written
#' @param min.cell.num Prevent deconvolution of celltype(s) if number of
#'                     corresponding cells is below this threshold
#' @param min.genes Filter cells based on minimum number of genes expressed
#' @param discard.celltype Remove any celltype(s) that is not of interest
#'
#' @importFrom NanoStringNCTools negativeControlSubset
#' @importFrom SpatialDecon derive_GeoMx_background
#' @importFrom SpatialDecon spatialdecon
#' @importFrom SpatialDecon create_profile_matrix
#' @importFrom ComplexHeatmap pheatmap
#' @importFrom reshape2 melt
#'
#' @export
#' @example Do not run: spatialDeconvolution(object = NanostringGeomx,
#'                                           expr.type = "q_norm",
#'                                           ref.mtx = reference_matrix,
#'                                           ref.annot = reference_annotation,
#'                                           cell.id.col = "CellID",
#'                                           celltype.col = "LabeledCellType")
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
                                 expr.type,
                                 ref.mtx,
                                 ref.annot,
                                 cell.id.col,
                                 celltype.col,
                                 group.by = NULL,
                                 out.directory = NULL,
                                 matrix.name = "customDSPmtx",
                                 normalize = FALSE,
                                 min.cell.num = 0,
                                 min.genes = 10,
                                 discard.celltype = FALSE) {
  
  # Check for Parameter Misspecification Error(s)
  if (!expr.type %in% names(object@assayData)) {
    stop("Normalized data slot not found in the data")
  } else if (!all(c(cell.id.col, celltype.col) %in% colnames(ref.annot))) {
    stop (
      "Check cell.id.col and celltype.col labels are correct"
    )
  } else if (!is.null(group.by)) {
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
  
  # Create custom matrix for input to spatial deconvolution
  custom.mtx <- create_profile_matrix(
    mtx = ref.mtx,
    cellAnnots = ref.annot,
    cellNameCol = cell.id.col,
    cellTypeCol = celltype.col,
    matrixName = matrix.name,
    outDir = NULL,
    normalize = normalize,
    minCellNum = min.cell.num,
    minGenes = min.genes,
    scalingFactor = 1,
    discardCellTypes = discard.celltype
  )
  
  # Run Spatial Deconvolution
  res <- spatialdecon(
    norm = norm.data,
    bg = bg,
    X = custom.mtx,
    align_genes = TRUE
  )
  
  # Prepare data for Abundance Barplot
  cell.comp <- as.data.frame(res$prop_of_all)
  cell.comp$celltype <- rownames(cell.comp)
  cell.comp <- melt(cell.comp)
  
  # Heatmap and composition barplot optionally sorted by group
  if (!is.null(group.by)) {
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
    abund.heat <-
      pheatmap(
        t(arr.heat.mtx),
        silent = TRUE,
        cluster_rows = FALSE,
        annotation_row = pheat.df
      )
    
    comp.bar <- ggplot(data = cell.comp,
                       aes(x = variable, y = value, fill = celltype)) +
      geom_bar(stat = "identity") +
      theme(axis.text.x = element_text(angle = 90, hjust =
                                         1)) +
      facet_wrap(~ eval(parse(text = group.by)), scales =
                   "free")
    
  } else {
    abund.heat <- pheatmap(t(res$beta), silent = TRUE)
    
    comp.bar <- ggplot(data = cell.comp,
                       aes(x = variable, y = value, fill = celltype)) +
      geom_bar(stat = "identity") +
      theme(axis.text.x = element_text(angle = 90, hjust =
                                         1))
  }
  
  # Heatmap of cell profile matrix used ~ res$X
  cell.prof.heat <- pheatmap(res$X, silent = TRUE)
  
  # Creates and stores all ggplot figures in a list
  plot.list = list(
    abundance.heatmap = abund.heat,
    cell.profile.heatmap = cell.prof.heat,
    composition.barplot = comp.bar
  )
  
  final.dsp.results <- list(dsp.data = res, figures = plot.list)
  
  return(final.dsp.results)
}
