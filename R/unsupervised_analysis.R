#### This code is a modification of  http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#6_Unsupervised_Analysis


#' dimReduct: Dimensional Reduction
#'
#' @description Reduces data to 2-dimensions using PCA, tSNE, and UMAP. Adds the sample embeddings of each dimensional reduction technique to the input object (phenoData) and plots them on 2D scatter plots.
#'
#' @details If both color.variable1 and color.variable2 are defined, points in the scatter plots are colored by a factor which combines the levels of these two variables.
#'
#' @param object of class NanoStringGeoMxSet with q_norm slot present
#' @slot assayDataElement of the NanoStringGeoMxSet-class object to be used for dimensional reductions
#' @param color.variable1 categorical variable to be used for coloring points (required)
#' @param color.variable2 categorical variable to be used for coloring points (optional)
#' @param shape.variable categorical variable to be used for the shape of points (optional)
#' @param point.size point size
#' @param point.alpha point color transparency
#' @param symbol.size symbols size in legends
#' @param text.size base font size
#' @param print.plots boolean to display plots or set to FALSE otherwise; ggplot objects are returned in either case
#'
#' @importFrom Biobase assayDataElement pData
#' @importFrom ggplot2 ggplot aes geom_point element_text ggtitle labs theme theme_bw
#' @importFrom patchwork plot_layout plot_annotation guide_area
#' @importFrom stats prcomp
#' @importFrom Rtsne Rtsne
#' @importFrom umap umap
#'
#' @seealso \link[stats]{prcomp} \link[Rtsne]{Rtsne}  \link[umap]{umap}
#'
#' @examples
#' \dontrun{
#' 
#' # Default plots
#' output <- dimReduct(object = object, color.variable1="region")
#'
#' # Plot tSNE
#' output <- dimReduct(object = object, color.variable1="region", print.plots = FALSE)
#' figure <- output$plot$tSNE
#' print(figure)
#'
#' ## Color by two variables
#' output <- dimReduct(object = object, color.variable1="region", color.variable2="class")
#' }
#' @export
#' @return A named list containing the NanoStringGeoMxSet-class object with the dimensional reduction coordinates ("object") and ggplot2 plots ("plot.list")


dimReduct <-
  function(object,
           color.variable1,
           assay.data = "q_norm",
           color.variable2 = NULL,
           shape.variable = NULL,
           point.size = 1,
           point.alpha = 1,
           symbol.size = 2,
           text.size = 16,
           print.plots = TRUE)
  {
    
    
    # Pre-run ####
  
    ## checks ####
      
    # stop if assayDataElement not present
    if (!assay.data %in% assayDataElementNames(object)){
      error.message <- sprintf("%s not found in the input object", assay.data)
      cat(stop(error.message))
    } else {
      info.message <- sprintf("using %s in the dimensional reductions", assay.data)
      cat(message(info.message))
    }
    
    # warn when dimension reductions already present and will be replaced
    if (any(c("PC1", "PC2", "tSNE1", "UMAP1", "UMAP2") %in% colnames(pData(object)))) {
      reductions <- colnames(pData(object))[grepl("PC|tSNE|UMAP", colnames(pData(object)))]
      warn.message <- sprintf("%s found in the input object and will be replaced by this calculation\n", reductions)
      cat(warning(warn.message))
    } else {
      cat("adding PCA, tSNE, and UMAP coordinates to the input object\n")
    }
    
    ## settings ####
    
    # bind variables
    color.variable  <- PC1 <- PC2 <- tSNE1 <- tSNE2 <- UMAP1 <- UMAP2 <- NULL
    
    
    # Run Reductions ####

    ## PCA ####

    ### calculate PCA on user-defined assayData
    pca.stats <-
      prcomp(t(log2(
        Biobase::assayDataElement(object , elt = assay.data)
      )), scale. = TRUE)
    #### add PCA coordinates to the object
    Biobase::pData(object)[, c("PC1", "PC2")] <-  pca.stats$"x"[, c(1, 2)]
    
    ## tSNE ####
    
    ### set random seed
    set.seed(42) 
    ### calculate tSNE on user-defined assayData 
    tsne.stats <-
      Rtsne(t(log2(
        Biobase::assayDataElement(object , elt = assay.data)
      )),
      perplexity = ncol(object) * .15)
    ### add tSNE coordinates to the object
    Biobase::pData(object)[, c("tSNE1", "tSNE2")] <- tsne.stats$Y[, c(1, 2)]
    
    ## UMAP ####
    
    ### retrieve UMAP defaults
    custom.umap <- umap::umap.defaults
    ### set random seed
    custom.umap$random_state <- 42
    ### calculate UMAP on user-defined assayData
    umap.stats <-
      umap(t(log2(
        Biobase::assayDataElement(object , elt = assay.data)
      )),
      config = custom.umap)
    ### add UMAP coordinates to the object
    Biobase::pData(object)[, c("UMAP1", "UMAP2")] <-  umap.stats$layout[, c(1, 2)]
    
    
    # Generate Plots ####
    
    
    ## plot input data ####

    ### extract phenoData from the object
    df <- Biobase::pData(object)
    ### set color variable and its legend title; if color.variable2 is not NULL compute a factor which combines levels of the two variables separated by '.' using interaction()
    if (is.null(color.variable2)) {
      df$color.variable <- factor(df[, color.variable1])
      color.label <- color.variable1
    } else {
      df$color.variable <-
        interaction(df[, color.variable1], df[, color.variable2], sep=".")
      color.label <-
        paste(color.variable1, color.variable2, sep = ".")
    }
    ### if shape.variable is not NULL compute its factor and legend title
    if (!is.null(shape.variable)) {
      df$shape.variable <- factor(df[, shape.variable])
      shape.label <- shape.variable
    }
    
    
    ## PCA ggplot ####

    pca.ggplot <- ggplot(
      df,
      aes(
        x = PC1,
        y = PC2,
        color = color.variable,
        shape = shape.variable
      ),
      size = point.size,
      alpha = point.alpha
    ) +
      geom_point() +
      theme_bw() +
      ggtitle("PCA") +
      labs(x = "PC 1",
           y = "PC 2",
           colour = color.label)
    
    ## tSNE ggplot ####
    
    tsne.ggplot <- ggplot(
      df,
      aes(
        x = tSNE1,
        y = tSNE2,
        color = color.variable,
        shape = shape.variable
      ),
      size = point.size,
      alpha = point.alpha
    ) +
      geom_point() +
      theme_bw() +
      ggtitle("tSNE") +
      labs(x = "tSNE 1",
           y = "tSNE 2",
           colour = color.label)
    
    ## UMAP ggplot ####
    
    umap.ggplot <- ggplot(
      df,
      aes(
        x = UMAP1,
        y = UMAP2,
        color = color.variable,
        shape = shape.variable
      ),
      size = point.size,
      alpha = point.alpha
    ) +
      geom_point() +
      theme_bw() +
      ggtitle("UMAP") +
      labs(x = "UMAP 1",
           y = "UMAP 2",
           colour = color.label)
    
    # Print Plots ####
    
    
    if (print.plots) {
      print(
        pca.ggplot +
        tsne.ggplot +
        umap.ggplot +
        guide_area() +
        plot_layout(ncol = 2, guides = "collect")  &
        theme_bw(base_size = text.size) &
        guides(colour = guide_legend(override.aes = list(size = symbol.size))) &
        guides(shape = guide_legend(override.aes = list(size = symbol.size)))
      )
    }
    
    # List Plots ####
    plot.list = list("PCA" = pca.ggplot,
                     "tSNE" = tsne.ggplot,
                     "UMAP" = umap.ggplot)
    
    # Return ####
    output = list("object" = object, "plot" = plot.list)
    return(output)
    
  }
