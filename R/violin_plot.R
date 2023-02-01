#' View gene expression expressed across groups and optionally across (broader) class

#' @param genes which genes should be plotted on the y-axis of the violin plot
#' @param group which groups should be plotted on the x axis of the violin plot
#' @param facet_by broader category of group, if specified, the violin plots will be split further based on this category
#' @param expr_type name of normalized expression data slot

#' @import GeomxTools
#' @import ggplot2
#' @import gridExtra
#' @import Rmpfr

#' @export
#' 
#' @return Violin plot(s) of genes to view across groups and (optionally) faceted across classes

## Plotting Genes of Interest


violin_function <- function(data = target_demoData,
                            expr_type = "q_norm",
                            genes = c(),
                            group = "CellType",
                            facet_by = NULL
                            ){
  
  ## -------------------------------- ##
  ## Parameter Misspecifation Errors  ##
  ## -------------------------------- ##
  
  check_errors <- function(obj){
    if (!expr_type %in% names(obj@assayData)){
      stop("expression data type was not found in DSP data")
    } else if (all(!genes %in% rownames(obj@assayData[[expr_type]]))){
      stop("no genes were found in DSP data")}
    else if (!group %in% colnames(pData(obj))){
      stop("grouping parameter was not found in DSP data")
    } else if (!is.null(facet_by)){
       if (!facet_by %in% colnames(pData(obj))){
      stop("facet parameter was not found in DSP data")
        }
    } 
  }
  
  check_errors(obj = data)
  
  # Print genes not found in data
  print(paste0(genes[!genes %in% rownames(data@assayData[[expr_type]])], " not found and will not be displayed"))
  
  # Display violin plots for genes found in the data
  genes_present <- as.list(genes[genes %in% rownames(data@assayData[[expr_type]])])
  
  violin <- list()
  
  draw_violin <- function(gene){
    violin <- ggplot(pData(data),
                          aes(x = eval(parse(text=group)), fill = eval(parse(text=group)),
                              y = assayDataElement(data[gene, ],
                                                   elt = expr_type))) +
      geom_violin() +
      geom_jitter(width = .2) +
      labs(y = paste(gene,"Expression", sep = " ")) +
      scale_y_continuous(trans = "log2") +
      theme_bw() + theme(axis.text.x=element_text(angle=90,hjust=1),
                         legend.title=element_blank(), axis.title.x = element_blank())
    
    return(violin)
  }
  
  violin <- lapply(genes_present, function (x) draw_violin(x))

  final_plot <- arrangeGrob(grobs = violin)
  
  return(final_plot)
}

