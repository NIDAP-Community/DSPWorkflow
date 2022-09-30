####This code comes from
#https://bioconductor.org/packages/release/bioc/vignettes/SpatialDecon/inst/doc/SpatialDecon_vignette_NSCLC.html


#' Estimate cell composition across spatial samples using information from a custom cell signature matrix

#' @param dsp_qnorm normalized expression matrix (Gene x DSP_Samples).
#' @param dsp_negnorm matrix of expected background for all data points in the normalized data matrix
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

spatial_deconvolution <- function(dsp_qnorm, dsp_negnorm, ref_mtx, ref_annot,
                                  CellID = "CellID",
                                  cellTypeCol = "LabeledCellType",
                                  normalize = FALSE,
                                  minCellNum = 0,
                                  minGenes = 10
                                  ){
  
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
    cellTypeCol = cellTypeCol,  
    cellNameCol = CellID,           
    matrixName = "custom_DSP_mtx", # name of final profile matrix
    outDir = NULL,                  # path to desired output directory, set to NULL if matrix should not be written
    normalize = normalize,                
    minCellNum = minCellNum,                  
    minGenes = minGenes,              
    scalingFactor = 1,              # what should all values be multiplied by for final matrix
    discardCellTypes = FALSE)
  
  # Run Spatial Deconvolution
  res <- spatialdecon(norm = norm,
                      bg = bg,
                      X = custom_mtx,
                      align_genes = TRUE)
  
  # Heatmap of estimated cell fraction ~ res$beta
  print(heatmap(t(res$beta), cexCol = 0.5, cexRow = 0.7, margins = c(10,7)))
  
  # Heatmap of cell profile matrix used ~ res$X
  print(heatmap(sweep(res$X, 1, apply(res$X, 1, max), "/"), labRow = NA, margins = c(10, 5)))
  
  # Abundance Barplot - draws legend in a new page 
  print(TIL_barplot(res$prop_of_all, draw_legend = TRUE, cex.names = 0.3))
  
  return(res)
}




