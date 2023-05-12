#' @title Violin plot of spatially profiled genes
#'
#' @description Returns violin plot of user-input gene(s) expression across 
#'              groups, can optionally subdivide groups into a more specific 
#'              category
#'
#' @details ggplot function that takes in gene expression data from 
#'          NanostringGeoMxSet, outputs the distribution of gene expression 
#'          values across groups. Requires normalized expression data and valid 
#'          group category to be present in object
#'
#' @param object Name of NanostringGeoMxSet to perform analysis on
#' @param expr.type Name of normalized expression data slot
#' @param genes Transcript(s) to be plotted on the y-axis of the violin plot
#' @param group Metadata group to be plotted on the x axis of the violin plot
#' @param facet.by Further subdivide group by this category (Default: NULL)
#' 
#' @import ggplot2
#' @importFrom gridExtra arrangeGrob
#'
#' @export
#' @example Do not run: violinPlot(object = NanostringGeomx, 
#'                                 expr.type = "q_norm", 
#'                                 genes = c("FOXP3","CD4"), 
#'                                 group = "CellType", 
#'                                 facet.by = "segment")
#'
#' @return an arranged grob of violin plots

violinPlot <- function(object,
                       expr.type,
                       genes,
                       group,
                       facet.by = NULL) {
  
  # Check for Parameter Misspecification Error(s)
    if (!expr.type %in% names(object@assayData)) {
      stop("expression data type was not found in DSP object")
    } else if (all(!genes %in% rownames(object@assayData[[expr.type]]))) {
      stop("no genes were found in DSP object")
    } else if (!group %in% colnames(pData(object))) {
      stop("grouping parameter was not found in DSP object")
    } else if (!is.null(facet.by)) {
      if (!facet.by %in% colnames(pData(object))) {
        stop("facet parameter was not found in DSP object")
      }
    }
  
  # Print genes not found in object
  print(paste0(genes[!genes %in% rownames(object@assayData[[expr.type]])], 
               " not found and will not be displayed"))
  
  # Display violin plots for genes found in the object
  genes.present <-
    as.list(genes[genes %in% rownames(object@assayData[[expr.type]])])
  
  violin <- list()
  
  # Segment violin plot by group membership and incorporate jitter
  .drawViolin <- function(gene) {
    
    if(!is.null(facet.by)){
      violin <-
        ggplot(pData(object),
               aes(
                 x = eval(parse(text = group)),
                 fill = eval(parse(text = group)),
                 y = assayDataElement(object[gene,],
                                      elt = expr.type)
               )) +
        geom_violin() +
        geom_point(position = position_jitter(seed = 42)) +
        facet_wrap(~eval(parse(text=facet.by))) +
        labs(y = paste(gene, "Expression", sep = " ")) +
        scale_y_continuous(trans = "log2") +
        theme_bw() +
        theme(
          axis.text.x = element_text(angle = 90, hjust = 1),
          legend.title = element_blank(),
          axis.title.x = element_blank()
      )} else {
        violin <-
          ggplot(pData(object),
                 aes(
                   x = eval(parse(text = group)),
                   fill = eval(parse(text = group)),
                   y = assayDataElement(object[gene,],
                                        elt = expr.type)
                 )) +
          geom_violin() +
          geom_point(position = position_jitter(seed = 42)) +
          labs(y = paste(gene, "Expression", sep = " ")) +
          scale_y_continuous(trans = "log2") +
          theme_bw() +
          theme(
            axis.text.x = element_text(angle = 90, hjust = 1),
            legend.title = element_blank(),
            axis.title.x = element_blank())
      }
    
    return(violin)
  }
  
  # Compile all individual violin plots into one main figure
  violin <- lapply(genes.present, function (x)
    .drawViolin(x))
  
  final.plot <- arrangeGrob(grobs = violin)
  
  
  return(final.plot)
}
