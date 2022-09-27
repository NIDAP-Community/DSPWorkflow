#### This code comes from http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#6_Unsupervised_Analysis

#' Ingest Nano String Digital Spatial Profile study
#' @param Object NanoStringGeoMxSet object with normalized data
#' @param point.size point size
#' @param point.alpha point color transparency
#' @param color.variable categorical variable to be used for coloring points
#'
#' @importFrom Biobase assayDataElement pData
#' @importFrom umap umap
#' @importFrom Rtsne Rtsne
#' @importFrom ggplot2 ggplot geom_point theme theme_bw ggtitle labs
#' @importFrom patchwork plot_layout plot_annotation
#'
#' @export
#' @return A list containing the NanoStringGeoMxSet Object with the dimensional reduction plots


DimReduct <-
  function(Object,
           point.size = 1,
           point.alpha = 1,
           color.variable) {
    # run UMAP
    custom.umap <- umap::umap.defaults
    custom.umap$random_state <- 42
    umap.out <-
      umap(t(log2(
        assayDataElement(Object , elt = "q_norm")
      )),
      config = custom.umap)
    pData(Object)[, c("UMAP1", "UMAP2")] <- umap.out$layout[, c(1, 2)]
    umap.plot <- ggplot(pData(Object),
                        aes(
                          x = UMAP1,
                          y = UMAP2,
                          color = get(color.variable)
                        )) +
      geom_point(size = point.size, alpha = point.alpha) +
      theme_bw() +
      ggtitle("UMAP") +
      labs(x = "UMAP 1", y = "UMAP 2", colour = color.variable)
    
    # run tSNE
    set.seed(42) # set the seed for tSNE as well
    tsne.out <-
      Rtsne(t(log2(
        assayDataElement(Object , elt = "q_norm")
      )),
      perplexity = ncol(Object) * .15)
    pData(Object)[, c("tSNE1", "tSNE2")] <- tsne.out$Y[, c(1, 2)]
    tsne.plot <- ggplot(pData(Object),
                        aes(
                          x = tSNE1,
                          y = tSNE2,
                          color = get(color.variable)
                        )) +
      geom_point(size = point.size, alpha = point.alpha) +
      theme_bw() +
      ggtitle("tSNE") +
      labs(x = "tSNE 1", y = "tSNE 2", colour = color.variable)
    
    # run PCA
    pca.out <-
      prcomp(t(log2(
        assayDataElement(Object , elt = "q_norm")
      )), scale. = TRUE)
    pData(Object)[, c("PC1", "PC2")] <- pca.out$"x"[, c(1, 2)]
    
    pca.plot <- ggplot(pData(Object),
                       aes(
                         x = PC1,
                         y = PC2,
                         color = get(color.variable)
                       )) +
      geom_point(size = point.size, alpha = point.alpha) +
      theme_bw() + ggtitle("PCA") +
      labs(x = "PCA 1", y = "PCA 2", colour = color.variable)
    
    # plot
    plot.list = list(PCA = pca.plot, tSNE = tsne.plot, UMAP = umap.plot )
    
    print(
      pca.plot + tsne.plot + umap.plot + guide_area() +
        plot_layout(ncol = 2, guides = "collect") + plot_annotation(
          title = "Unsupervised Analysis",
          subtitle = "Dimension Reduction",
          tag_levels = "A",
          caption = "DSPWorkflow::DimReduct()",
          theme = theme(
            text = element_text(color = 'gray50'),
            plot.caption = element_text(face = 'italic')
          )
        )
    )
    
    # return
    invisible(list("dsp.object" = Object, "plot.list" = plot.list))
    
  }

