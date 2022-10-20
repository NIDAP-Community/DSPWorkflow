#' View gene expression expressed across groups and optionally across (broader) class

#' @param genes which genes should be plotted on the y-axis of the violin plot
#' @param group which groups should be plotted on the x axis of the violin plot
#' @param facet_by broader category of group, if specified, the violin plots will be split further based on this category
#' @param expr_type name of normalized expression data slot

#' @import GeomxTools
#' @import ggplot2
#' @import gridExtra

#' @export
#' 
#' @return Violin plot(s) of genes to view across groups and (optionally) faceted across classes

## Plotting Genes of Interest


violin_function <- function(data = target_demoData,
                            genes = c(),
                            group = "CellType",
                            facet_by = NULL,
                            expr_type = "q_norm"){
  
  library(gridExtra)
  
  violin <- list()
  
  for (gene in genes){
    
    if (!is.null(facet_by)){
    violin[[gene]] <- ggplot(pData(data),
                             aes(x = eval(parse(text=group)), fill = eval(parse(text=group)),
                                 y = assayDataElement(data[gene, ],
                                                      elt = expr_type))) + 
      geom_violin() +
      geom_jitter(width = .2) +
      labs(y = paste(gene,"Expression", sep = " ")) +
      scale_y_continuous(trans = "log2") +
      facet_wrap(~eval(parse(text=facet_by))) +
      theme_bw() + theme(axis.text.x=element_text(angle=90,hjust=1),
                         legend.title=element_blank(), axis.title.x = element_blank())
    } else {
      violin[[gene]] <- ggplot(pData(data),
                               aes(x = eval(parse(text=group)), fill = eval(parse(text=group)),
                                   y = assayDataElement(data[gene, ],
                                                        elt = expr_type))) + 
        geom_violin() +
        geom_jitter(width = .2) +
        labs(y = paste(gene,"Expression", sep = " ")) +
        scale_y_continuous(trans = "log2") +
        theme_bw() + theme(axis.text.x=element_text(angle=90,hjust=1),
                           legend.title=element_blank(), axis.title.x = element_blank())
  }}
  
  final_plot <- do.call(grid.arrange, violin)
  
  return(final_plot)
}

