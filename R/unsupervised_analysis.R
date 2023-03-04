# This code is a modification from
# "Analyzing GeoMx-NGS RNA Expression Data with GeomxTools" vignette
# https://tinyurl.com/2wn2rtt9

#' dimReduct: Dimensional Reduction
#' @description Reduces data to two dimensions using PCA, tSNE, and UMAP. Adds
#' the sample embeddings of each dimensional reduction technique to the input
#' object (phenoData) and plots them on 2D scatter plots.
#' @details If both color.variable1 and color.variable2 are defined, points in
#'  the scatter plots are colored by a factor which combines the levels of
#'  these two variables.
#' @param object of class NanoStringGeoMxSet
#' @param color.variable1 categorical variable to be used for coloring points
#' @param assay.data  assayDataElement of the NanoStringGeoMxSet-class object to
#'  be used for dimensional reductions
#' @param  do.log boolean to apply log2 transformation to the data to be used
#' in the dimensional reduction algorithms (TRUE by default)
#' @param color.variable2 categorical variable to be used for coloring points
#' (optional)
#' @param shape.variable categorical variable to be used for the shape of points
#' (optional)
#' @param point.size point size
#' @param point.alpha point color transparency
#' @param symbol.size symbols size in legends
#' @param text.size base font size
#' @param print.plots boolean to display plots or set to FALSE otherwise; ggplot
#' objects are returned in either case
#' @importFrom Biobase assayDataElement pData
#' @importFrom ggplot2 ggplot aes geom_point guides element_text ggtitle labs
#' theme theme_bw
#' @importFrom patchwork plot_layout plot_annotation guide_area
#' @importFrom stats prcomp
#' @importFrom Rtsne Rtsne
#' @importFrom umap umap
#' @seealso [prcomp][stats::prcomp()] [Rtsne][Rtsne::Rtsne] [umap][umap::umap] 
#' @seealso \code{\link[stats]{prcomp}} \link[Rtsne]{Rtsne}
#' @seealso \code{\link{stats::prcomp}} \code{\link{Rtsne::Rtsne}}
#' \code{\link{umap::umap}}
#' @examples
#' \dontrun{
#' # Default plots
#' output <- dimReduct(object = object, color.variable1="region")
#' # Plot tSNE
#' output <- dimReduct(object = object, color.variable1="region",
#' print.plots = FALSE)
#' figure <- output$plot$tSNE
#' print(figure)
#' # Color by two variables
#' output <- dimReduct(object = object, color.variable1="region",
#' color.variable2="class")
#' }
#' @export
#' @return A named list containing the NanoStringGeoMxSet-class object with the
#' dimensional reduction coordinates added ("object") and a list of ggplot
#' objects ("plot")

dimReduct <-
  function(object,
           color.variable1,
           assay.data = "q_norm",
           do.log = TRUE,
           color.variable2 = NULL,
           shape.variable = NULL,
           point.size = 1,
           point.alpha = 1,
           symbol.size = 2,
           text.size = 16,
           print.plots = TRUE) {
    
    # Pre-run ####
    
    ## checks ####
    
    ## stop if assayDataElement not present
    if (!assay.data %in% assayDataElementNames(object)) {
      error.message <-
        sprintf("%s not found in assayData", assay.data)
      cat(stop(error.message))
    } else {
      info.message <-
        sprintf("using %s in the dimensional reductions", assay.data)
      cat(message(info.message))
    }
    ## warn when dimension reductions already present and will be replaced
    if (any(c("PC1", "PC2", "tSNE1", "UMAP1", "UMAP2") %in%
            colnames(pData(object)))) {
      reductions <-
        colnames(pData(object))[grepl("PC|tSNE|UMAP", colnames(pData(object)))]
      warn.message <-
        sprintf("%s found in the phenoData and will be replaced\n",
                reductions)
      cat(warning(warn.message))
    } else {
      info.message <-
        "adding in the phenoData PCA, tSNE, and UMAP coordinates\n"
      cat(message(info.message))
    }
    
    ## settings ####
    
    ## bind variables
    color.variable  <-
      PC1 <- PC2 <- tSNE1 <- tSNE2 <- UMAP1 <- UMAP2 <- NULL
    ## get assayData
    dat <- Biobase::assayDataElement(object, elt = assay.data)
    ## stop if missing values present in assayData
    if (any(is.na(dat))) {
      stop("Missing values in assayData are not allowed")
    }
    ## stop if do.log=TRUE and non-positive values present in assayData,
    ## otherwise apply log2 to assayData to be used in reductions
    if (do.log) {
      if (any(dat <= 0)) {
        stop("do.log=TRUE failed due to values <=0 present in assayData")
      } else {
        dat <- log2(dat)
      }
    }
    
    # Run Reductions ####
    
    ## PCA ####
    
    ## calculate PCA on user-defined assayData
    pca.stats <- prcomp(t(dat), scale. = TRUE)
    ##  add PCA coordinates to the object
    Biobase::pData(object)[, c("PC1", "PC2")] <- pca.stats$"x"[,c(1, 2)]
    
    ## tSNE ####
    
    ## set random seed
    set.seed(42)
    ### calculate tSNE on user-defined assayData
    tsne.stats <- Rtsne(t(dat), perplexity = ncol(object) * .15)
    ## add tSNE coordinates to the object
    Biobase::pData(object)[, c("tSNE1", "tSNE2")] <- tsne.stats$Y[,c(1, 2)]
    
    ## UMAP ####
    
    ## retrieve UMAP defaults
    custom.umap <- umap::umap.defaults
    ## set random seed
    custom.umap$random_state <- 42
    ## calculate UMAP on user-defined assayData
    umap.stats <- umap(t(dat), config = custom.umap)
    ## add UMAP coordinates to the object
    Biobase::pData(object)[,c("UMAP1", "UMAP2")] <- umap.stats$layout[, c(1, 2)]
    
    # Generate Plots ####
    
    ## plot input data ####
    
    ## extract phenoData from the object
    df <- Biobase::pData(object)
    ## set color variable and its legend title; if color.variable2 is not NULL
    ##  compute a factor which combines levels of the two variables separated
    ##  by '.' using interaction()
    if (is.null(color.variable2)) {
      df$color.variable <- factor(df[, color.variable1])
      color.label <- color.variable1
    } else {
      df$color.variable <-
        interaction(df[, color.variable1], df[, color.variable2], sep =
                      ".")
      color.label <-
        paste(color.variable1, color.variable2, sep = ".")
    }
    ## if shape.variable is not NULL compute its factor and legend title
    if (!is.null(shape.variable)) {
      df$shape.variable <- factor(df[, shape.variable])
      shape.label <- shape.variable
    }
    ## initiate geom_point and legend titles by shape.variable status
    if (is.null(shape.variable)) {
      add.points <- geom_point()
      legend.title <- labs(colour = color.label)
    } else {
      add.points <- geom_point(aes(shape = shape.variable))
      legend.title <-
        labs(shape = shape.label, colour = color.label)
    }
    
    ## PCA ggplot ####
    
    pca.ggplot <- ggplot(
      df,
      aes(x = PC1,
          y = PC2,
          color = color.variable),
      size = point.size,
      alpha = point.alpha
      ) +
      add.points +
      legend.title +
      ggtitle("PCA") +
      labs(x = "PC 1",
           y = "PC 2") +
      theme_linedraw(base_size = text.size) +
      theme(axis.title = element_text(size=text.size-2)) +
      guides(colour =
               guide_legend(override.aes = list(size = symbol.size))) +
      guides(shape =
               guide_legend(override.aes = list(size = symbol.size)))
    
    ## tSNE ggplot ####
    
    tsne.ggplot <- ggplot(
      df,
      aes(x = tSNE1,
          y = tSNE2,
          color = color.variable),
      size = point.size,
      alpha = point.alpha
    ) +
      add.points +
      legend.title +
      theme_linedraw(base_size = text.size) +
      ggtitle("tSNE") +
      labs(x = "tSNE 1",
           y = "tSNE 2") +
      theme(axis.title = element_text(size=text.size-2)) +
      guides(colour =
               guide_legend(override.aes = list(size = symbol.size))) +
      guides(shape =
               guide_legend(override.aes = list(size = symbol.size)))
    
    ## UMAP ggplot ####
    
    umap.ggplot <- ggplot(
      df,
      aes(x = UMAP1,
          y = UMAP2,
          color = color.variable),
      size = point.size,
      alpha = point.alpha
    ) +
      add.points +
      legend.title +
      theme_linedraw(base_size = text.size) +
      ggtitle("UMAP") +
      labs(x = "UMAP 1",
           y = "UMAP 2") +
      theme(axis.title = element_text(size=text.size-2)) +
      guides(colour =
               guide_legend(override.aes = list(size = symbol.size))) +
      guides(shape =
               guide_legend(override.aes = list(size = symbol.size)))
    
    # Print Plots ####
    
    if (print.plots) {
      print(
        pca.ggplot +
          tsne.ggplot +
          umap.ggplot +
          guide_area() +
          plot_layout(ncol = 2, guides = "collect")
      )
    }
    
    # List Plots ####
    plot.list <- list("PCA" = pca.ggplot,
                      "tSNE" = tsne.ggplot,
                      "UMAP" = umap.ggplot)
    
    # Return ####
    output <- list("object" = object, "plot" = plot.list)
    invisible(output)
  }
