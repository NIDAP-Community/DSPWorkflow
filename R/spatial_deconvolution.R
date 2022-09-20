####This code comes from
#https://bioconductor.org/packages/release/bioc/vignettes/SpatialDecon/inst/doc/SpatialDecon_vignette_NSCLC.html


#' Estimate cell composition across spatial samples using information from a reference matrix
#' @param dsp_qnorm normalized expression matrix (Gene x DSP_Samples).
#' @param dsp_negnorm matrix of expected background for all data points in the normalized data matrix
#' @param ref_mtx expression matrix (Gene x Reference_Samples) 
#' @param ref_annot annotated data.frame with CellID and LabeledCellType
#' @export
#' 
#' @return A list containing the results of spatial deconvolution, res$beta contains matrix of estimated cell abundances, heatmap of estimated cell abundances

spatial_deconvolution <- function(dsp_qnorm, dsp_negnorm, ref_mtx, ref_annot){
  library(SpatialDecon)
  library(GeomxTools)
  
  norm <- dsp_qnorm
  
  # Load negative background
  per.observation.mean.neg = dsp_negnorm
  bg = sweep(norm * 0, 2, per.observation.mean.neg, "+")
  
  # Load reference dataset 
  mtx_for_deconv <- ref_mtx
  annot <- ref_annot
  
  # Create custom matrix for input to spatial deconvolution, returns matrix with gene and celltype information
  custom_mtx <- create_profile_matrix(
    mtx = mtx_for_deconv,
    cellAnnots = annot,
    cellTypeCol = "LabeledCellType",  # column containing cell type
    cellNameCol = "CellID",           # column containing cell ID/name
    matrixName = "custom_DSP_mtx", # name of final profile matrix
    outDir = NULL,                    # path to desired output directory, set to NULL if matrix should not be written
    normalize = FALSE,                # Should data be normalized? 
    minCellNum = 0,                   # minimum number of cells of one type needed to create profile, exclusive
    minGenes = 10,                    # minimum number of genes expressed in a cell, exclusive
    scalingFactor = 5,                # what should all values be multiplied by for final matrix
    discardCellTypes = FALSE)
  
  # Run Spatial Deconvolution
  res <- spatialdecon(norm = norm,
                      bg = bg,
                      X = custom_mtx,
                      align_genes = TRUE)
  
  # Plot heatmap of estimated cell fraction
  print(heatmap(t(res$beta), cexCol = 0.5, cexRow = 0.7, margins = c(10,7)))
  return(res)
}




