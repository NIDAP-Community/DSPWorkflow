#### This code comes from http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#6_Unsupervised_Analysis

#' DimReduct: Dimensional Reduction
#'
#' Reduces data to 2-dimensions using PCA, tSNE, and UMAP. Adds the sample embeddings of each dimensional reduction technique to the input object (phenoData) and plots them on 2D scatter plots.
#' 
#' If both color.variable1 and color.variable2 are defined, points in the scatter plots are colored by a factor which combines the levels of these two variables.
#' @param object of class NanoStringGeoMxSet with q_norm slot present
#' @param point.size point size
#' @param point.alpha point color transparency
#' @param color.variable1 categorical variable to be used for coloring points (required)
#' @param color.variable2 categorical variable to be used for coloring points (optional)
#' @param shape.variable categorical variable to be used for the shape of points (optional)
#' 
#' @importFrom Biobase pData assayDataElement
#' @importFrom ggplot2 ggplot aes geom_point element_text ggtitle labs theme theme_bw
#' @importFrom patchwork plot_layout plot_annotation guide_area
#' @importFrom stats prcomp
#' @importFrom Rtsne Rtsne
#' @importFrom umap umap
#' 
#' @export
#' @seealso \link[stats]{prcomp} \link[Rtsne]{Rtsne}  \link[umap]{umap}
#' @return A named list containing the NanoStringGeoMxSet-class object with the dimensional reduction coordinates ("dsp.object") and ggplot2 plots ("plot.list")


DimReduct <-
  function(object,
           color.variable1,
           color.variable2 = NULL,
           shape.variable = NULL,
           point.size = 1,
           point.alpha = 1) {
    
    # run reductions ====
    
    color.variable <-
      PC1 <- PC2 <- tSNE1 <- tSNE2 <- UMAP1 <- UMAP2 <- NULL
    
    # add PCA
    pca.out <-
      prcomp(t(log2(
        Biobase::assayDataElement(object , elt = "q_norm")
      )), scale. = TRUE)
    Biobase::pData(object)[, c("PC1", "PC2")] <- pca.out$"x"[, c(1, 2)]
    
    # add tSNE
    set.seed(42) # set the seed for tSNE as well
    tsne.out <-
      Rtsne(t(log2(
        Biobase::assayDataElement(object , elt = "q_norm")
      )),
      perplexity = ncol(object) * .15)
    Biobase::pData(object)[, c("tSNE1", "tSNE2")] <- tsne.out$Y[, c(1, 2)]
    
    
    # add UMAP
    custom.umap <- umap::umap.defaults
    custom.umap$random_state <- 42
    umap.out <-
      umap(t(log2(
        Biobase::assayDataElement(object , elt = "q_norm")
      )),
      config = custom.umap)
    Biobase::pData(object)[, c("UMAP1", "UMAP2")] <-
      umap.out$layout[, c(1, 2)]
    
    
    df <- Biobase::pData(object)
    if (is.null(color.variable2)) {
      df$color.variable <- factor(df[, color.variable1])
      color.label <- color.variable1
    } else {
      df$color.variable <-
        interaction(df[, color.variable1], df[, color.variable2])
      color.label <-
        paste(color.variable1, color.variable2, sep = ".")
    }
    if (!is.null(shape.variable)) {
      df$shape.variable <- factor(df[, shape.variable])
      shape.label <- shape.variable
    }
    
    
    # prepare plots ====
    
    
    if (is.null(shape.variable)) {
      pca.plot <- ggplot(df,
                         aes(x = PC1,
                             y = PC2,
                             color = color.variable))
      
      umap.plot <- ggplot(df,
                          aes(x = UMAP1,
                              y = UMAP2,
                              color = color.variable))
      
      tsne.plot <- ggplot(df,
                          aes(x = tSNE1,
                              y = tSNE2,
                              color = color.variable))
      
    } else {
      pca.plot <- ggplot(df,
                         aes(
                           x = PC1,
                           y = PC2,
                           color = color.variable,
                           shape = shape.variable
                         )) +
        labs(shape = shape.label)
      
      umap.plot <- ggplot(df,
                          aes(
                            x = UMAP1,
                            y = UMAP2,
                            color = color.variable,
                            shape = shape.variable
                          )) +
        labs(shape = shape.label)
      
      tsne.plot <- ggplot(df,
                          aes(
                            x = tSNE1,
                            y = tSNE2,
                            color = color.variable,
                            shape = shape.variable
                          )) +
        labs(shape = shape.label)
      
      
    }
    
    pca.plot <-
      pca.plot + geom_point(size = point.size, alpha = point.alpha) +
      theme_bw() + ggtitle("PCA") +
      labs(x = "PC 1", y = "PC 2", colour = color.label)
    
    tsne.plot <-
      tsne.plot + geom_point(size = point.size, alpha = point.alpha) +
      theme_bw() +
      ggtitle("tSNE") +
      labs(x = "tSNE 1", y = "tSNE 2", colour = color.label)
    
    umap.plot <-
      umap.plot + geom_point(size = point.size, alpha = point.alpha) +
      theme_bw() +
      ggtitle("UMAP") +
      labs(x = "UMAP 1", y = "UMAP 2", colour = color.label)
    
    plot.list = list(PCA = pca.plot, tSNE = tsne.plot, UMAP = umap.plot)
    
    # print plots ====
    print(
      pca.plot + tsne.plot + umap.plot + guide_area() +
        plot_layout(ncol = 2, guides = "collect") + plot_annotation(
          title = "Unsupervised Analysis",
          subtitle = "Dimensional Reduction",
          tag_levels = "A",
          caption = "DSPWorkflow::DimReduct()",
          theme = theme(
            text = element_text(color = 'gray50'),
            plot.caption = element_text(face = 'italic')
          )
        )
    )
    
    # return ====
    invisible(list("dsp.object" = object, "plot.list" = plot.list))
    
  }
