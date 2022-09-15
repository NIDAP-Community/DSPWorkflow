####This code comes from
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#2_Getting_started


#' Ingest Nano String Digital Spatial Profile study
#' @param dsp_data processed nanostring object containing quantile and negative normalized expression.
#' @param ref_data AnnData object with signature matrix for celltype
#' @export
#' 
#' @return A list containing the results of spatial deconvolution

# # devtools is used for package development
# # Attach devtools to .Rproifile startup file
# if (interactive()) {
#   suppressMessages(require(devtools))
# }

## Not necessary since project has already been cloned from github
#create_package("/rstudio-files/ccr-dceg-data/users/Jing/SpatialDeconv")

spatial_deconvolution <- function(dsp_qnorm, dsp_negnorm, ref_mtx, ref_annot){
  library(SpatialDecon)
  library(Seurat)
  library(anndata)
  
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
  
  return(res)
}




