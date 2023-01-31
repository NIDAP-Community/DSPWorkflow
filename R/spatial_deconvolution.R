####This code comes from
#https://bioconductor.org/packages/release/bioc/vignettes/SpatialDecon/inst/doc/SpatialDecon_vignette_NSCLC.html


#' Estimate cell composition across spatial samples using information from a custom cell signature matrix

#' @param dsp_obj Nanostring object containing normalized gene expression data
#' @param norm_expr_type Name of the slot containing normalized gene expression data
#' @param ref_mtx expression matrix (Gene x Reference_Samples) 
#' @param ref_annot annotated data.frame with CellID and LabeledCellType, will be used along with ref_mtx to generate custom signature matrix
#' @param CellID column of annotated data.frame containing cell barcode or name
#' @param celltypeCol column of annotated data.frame containing cell identity information
#' @param normalize scale profile matrix gene expression according to gene count
#' @param minCellNum minimum number of cells (within a type) required to generate signature matrix
#' @param minGenes filters cells according to minimum number of genes expressed 
#' 
#' @import SpatialDecon
#' @import GeomxTools
#' @import stats
#' @import reshape2
#' @import pheatmap
#' @importFrom SpatialDecon spatialdecon
#' @importFrom stats heatmap
#' @importFrom SpatialDecon TIL_barplot

#' @export
#' 
#' @return A list res containing the results of spatial deconvolution, 
#' res$beta: matrix of estimated cell abundances
#' res$X: cell signature (gene x celltype) matrix used to generate deconvolution results
#' res$yhat, res$resids: fitted values and log2-scale residuals from deconvolution, can be used to measure observations' goodness of fit
#' res$prop_of_all: res$beta rescaled to proportion of celltype across each sample 
#' heatmap / barplot of estimated cell abundances in data

spatial_deconvolution <- function(dsp_obj,
                                  norm_expr_type = "",
                                  ref_mtx, 
                                  ref_annot,
                                  CellID = "CellID",
                                  cellTypeCol = "LabeledCellType",
                                  normalize = FALSE,
                                  minCellNum = 0,
                                  minGenes = 10
                                  ){
  
  ## -------------------------------- ##
  ## Parameter Misspecifation Errors  ##
  ## -------------------------------- ##
  
  if (!norm_expr_type %in% names(dsp_obj@assayData)){
    stop("Normalized data slot not found in the data")
  } else if (!all(c(CellID, cellTypeCol) %in% colnames(ref_annot))){
    stop ("Check that CellID and cellTypeCol are properly labeled and present in reference annotation table")
  }
  
  norm_data <- assayDataElement(dsp_obj, elt = norm_expr_type)
  
  # Calculate negative background
  neg_sub <- negativeControlSubset(dsp_obj)

  bg = derive_GeoMx_background(norm = norm_data,
                               probepool = fData(dsp_obj)$Module,
                               negnames = neg_sub@featureData@data$TargetName)
  
  # Load reference dataset (matrix and annotation table)
  mtx_for_deconv <- ref_mtx
  annot <- ref_annot
  
  # Create custom matrix for input to spatial deconvolution, returns matrix with gene and celltype information
  custom_mtx <- create_profile_matrix(
    mtx = mtx_for_deconv,
    cellAnnots = annot,
    cellTypeCol = cellTypeCol,  
    cellNameCol = CellID,           
    matrixName = "custom_DSP_mtx",  # name of final profile matrix
    outDir = NULL,                  # path to desired output directory, set to NULL if matrix should not be written
    normalize = normalize,                
    minCellNum = minCellNum,                  
    minGenes = minGenes,              
    scalingFactor = 1,              # what should all values be multiplied by for final matrix
    discardCellTypes = FALSE)
  
  # Run Spatial Deconvolution
  res <- spatialdecon(norm = norm_data,
                      bg = bg,
                      X = custom_mtx,
                      align_genes = TRUE)
  
  # Heatmap of estimated cell fraction ~ res$beta
  abund_heat <- pheatmap(t(res$beta), silent = TRUE)
  
  # Heatmap of cell profile matrix used ~ res$X
  cell_prof_heat <- pheatmap(res$X, silent = TRUE)
  
  # Abundance Barplot - draws legend in a new page 
  # Process data.frame for geom_barplot
  cell_abund_prop <- as.data.frame(res$prop_of_all)
  cell_abund_prop$celltype <- rownames(cell_abund_prop)
  cell_abund_prop <- melt(cell_abund_prop)
  
  # Creates and stores all ggplot figures in a list
  TIL_bar <- ggplot(data = cell_abund_prop, aes(x=variable, y=value, fill=celltype)) + geom_bar(stat="identity") +
    theme(axis.text.x=element_text(angle=90,hjust=1))
  
  plot_list = list(abundance_heatmap = abund_heat, cell_profile_heatmap = cell_prof_heat, Composition_barplot = TIL_bar)
  
  final_dsp_results <- list(dsp_data = res, figures = plot_list)
  
  return(final_dsp_results)
}


