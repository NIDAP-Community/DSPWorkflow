#### This code comes from http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#6_Unsupervised_Analysis

#' Ingest Nano String Digital Spatial Profile study
#' @param Object NanoStringGeoMxSet object with normalized data
#' @param point.size point size in the plots
#' @param point.alpha point color transparency
#' 
#' @importFrom GeomxTools assayDataElement
#' @importFrom Biobase pData
#' @importFrom umap umap
#' @importFrom Rtsne Rtsne
#' @import ggplot2
#' @import patchwork
#' 
#'
#' @export
#' @invisible A list containing the NanoStringGeoMxSet Object with the dimensional reduction plots


GeomxDimensionReduction <- function(Object, point.size = 1, point.alpha = 1) {
  
  # run UMAP
  custom.umap <- umap::umap.defaults
  custom.umap$random_state <- 42
  umap.out <-
    umap(t(log2(assayDataElement(Object , elt = "q_norm"))),  
         config = custom.umap)
  pData(Object)[, c("UMAP1", "UMAP2")] <- umap.out$layout[, c(1,2)]
  umap.plot <- ggplot(pData(Object),
         aes(x = UMAP1, y = UMAP2, color = region, shape = class)) +
    geom_point(size = point.size, alpha = point.alpha) +
    theme_bw() + ggtitle("UMAP")
  
  # run tSNE
  set.seed(42) # set the seed for tSNE as well
  tsne.out <-
    Rtsne(t(log2(assayDataElement(Object , elt = "q_norm"))),
          perplexity = ncol(Object)*.15)
  pData(Object)[, c("tSNE1", "tSNE2")] <- tsne.out$Y[, c(1,2)]
  tsne.plot <- ggplot(pData(Object),
         aes(x = tSNE1, y = tSNE2, color = region, shape = class)) +
    geom_point(size = point.size, alpha = point.alpha) +
    theme_bw() + ggtitle("tSNE")
  
  # run PCA
  pca.out <-
    prcomp(t(log2(
      assayDataElement(Object , elt = "q_norm")
    )), scale. = TRUE)
  pData(Object)[, c("PC1", "PC2")] <- pca.out$"x"[, c(1,2)]
  
  pca.plot <- ggplot(pData(Object),
         aes(x = PC1, y = PC2, color = region, shape = class)) +
    geom_point(size = point.size, alpha = point.alpha) +
    theme_bw() + ggtitle("PCA")
  
  # plot
  plot.list = list(UMAP=umap.plot, tSNE=tsne.plot, PCA=pca.plot)
  
  print(pca.plot + tsne.plot + umap.plot + guide_area() + 
          plot_layout(ncol=2, guides="collect") + plot_annotation(tag_levels = "A"))
  
  # return
  invisible(list("dsp.object" = Object, "plot.list" = plot.list))
  
}




