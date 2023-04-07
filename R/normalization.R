#This code comes from:
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#5_Normalization

#' @title Normalization function
#'
#' @description Returns a dataset that are normalized with various normalized options
#'              showing data after normalization.
#'
#' @details normalization function that takes in gene expression data from 
#'          NanostringGeoMxSet, outputs a normalized NanostringGeoMxSet
#'          
#' @param object A NanoStringGeoMxSet dataset
#' @param norm A vector with options of c(quant or neg)
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 geom_histogram
#' @importFrom ggplot2 scale_x_continuous
#' @importFrom ggplot2 facet_wrap
#' @importFrom ggplot2 scale_fill_brewer
#' @importFrom ggplot2 geom_abline
#' @importFrom ggplot2 geom_hline
#' @importFrom ggplot2 guides
#' @importFrom reshape2 melt
#' @importFrom cowplot plot_grid
#' @importFrom Biobase exprs
#' @importFrom Biobase pData
#' @importFrom stats quantile
#' @importFrom utils head
#' @importFrom GeomxTools normalize
#'
#'
#' @export
#' @return A list containing the ggplot grid, a boxplot, an normalized dataframe.


# To call function, must have object = object; norm = c(quant or neg)
geomxnorm <- function(object, norm) {
  
  if(class(object)[1] != "NanoStringGeoMxSet"){
    stop(paste0("Error: You have the wrong data class, must be NanoStringGeoMxSet" ))
  }
  
  # run reductions ====
  color.variable <-
    Value <- Statistic <- NegProbe <- Q3 <- Annotation <- NULL
  
  # Start Function
  neg.probes<- "NegProbe-WTX"
  ann.of.interest <- "region"
  
  Stat.data <- base::data.frame(row.names = colnames(exprs(object)),
                                Segment = colnames(exprs(object)),
                                Annotation = Biobase::pData(object)[, ann.of.interest],
                                Q3 = unlist(apply(exprs(object), 2,
                                                  quantile, 0.75, na.rm = TRUE)),
                                NegProbe = exprs(object)[neg.probes, ])
  
  Stat.data.m <- melt(Stat.data, measures.vars = c("Q3", "NegProbe"),
                      variable.name = "Statistic", value.name = "Value")
  
  
  plt1 <- ggplot(Stat.data.m,
                 aes(x = Value, fill = Statistic)) +
    geom_histogram(bins = 40) + theme_bw() +
    scale_x_continuous(trans = "log2") +
    facet_wrap(~Annotation, nrow = 1) + 
    scale_fill_brewer(palette = 3, type = "qual") +
    labs(x = "Counts", y = "Segments, #")
  
  plt2 <- ggplot(Stat.data,
                 aes(x = NegProbe, y = Q3, color = Annotation)) +
    geom_abline(intercept = 0, slope = 1, lty = "dashed", color = "darkgray") +
    geom_point() + guides(color = "none") + theme_bw() +
    scale_x_continuous(trans = "log2") + 
    scale_y_continuous(trans = "log2") +
    theme(aspect.ratio = 1) +
    labs(x = "Negative Probe GeoMean, Counts", y = "Q3 Value, Counts")
  
  plt3 <- ggplot(Stat.data,
                 aes(x = NegProbe, y = Q3 / NegProbe, color = Annotation)) +
    geom_hline(yintercept = 1, lty = "dashed", color = "darkgray") +
    geom_point() + theme_bw() +
    scale_x_continuous(trans = "log2") + 
    scale_y_continuous(trans = "log2") +
    theme(aspect.ratio = 1) +
    labs(x = "Negative Probe GeoMean, Counts", y = "Q3/NegProbe Value, Counts")
  
  btm.row <- plot_grid(plt2, plt3, nrow = 1, labels = c("B", ""),
                       rel_widths = c(0.43,0.57))
  multi.plot <- plot_grid(plt1, btm.row, ncol = 1, labels = c("A", ""))
  
  if(norm == "quant"){
    # Q3 norm (75th percentile) for WTA/CTA  with or without custom spike-ins
    object <- normalize(object,
                        norm_method = "quant", 
                        desiredQuantile = .75,
                        toElt = "q_norm")
    
    transform1<- assayDataElement(object[,1:10], elt = "q_norm")
    transform2<- as.data.frame(transform1)
    transform3<- melt(transform2)
    ggboxplot <- ggplot(transform3, aes(variable, value)) +
      stat_boxplot(geom = "errorbar") +
      geom_boxplot(fill="#2CA02C") +
      scale_y_log10() +
      xlab("Segment") + 
      ylab("Counts, Quant. Normailzed") +
      ggtitle("Quant Norm Counts") +
      scale_x_discrete(labels=c(1:10))
  }
  if(norm == "Quant"){
    stop(paste0("Error: Quant needs to be quant" ))
  }
  if(norm == "quantile"){
    stop(paste0("Error: quantile needs to be quant" ))
  }
  if(norm == "Quantile"){
    stop(paste0("Error: Quantile needs to be quant" ))
  }
  
  if(norm == "neg"){
    # Background normalization for WTA/CTA without custom spike-in
    object <- normalize(object,
                        norm_method = "neg", 
                        fromElt = "exprs",
                        toElt = "neg_norm")
    
    transform1<- assayDataElement(object[,1:10], elt = "neg_norm")
    transform2<- as.data.frame(transform1)
    transform3<- melt(transform2)
    ggboxplot <- ggplot(transform3, aes(variable, value)) +
      stat_boxplot(geom = "errorbar") +
      geom_boxplot(fill="#FF7F0E") +
      scale_y_log10() +
      xlab("Segment") + 
      ylab("Counts, Neg. Normailzed") +
      ggtitle("Neg Norm Counts") +
      scale_x_discrete(labels=c(1:10))
  }
  if(norm == "Neg"){
    stop(paste0("Error: Neg needs to be neg" ))
  }
  if(norm == "negative"){
    stop(paste0("Error: negative needs to be neg" ))
  }
  if(norm == "Negative"){
    stop(paste0("Error: Negative needs to be neg" ))
  }
  
  return(list("multi.plot" = multi.plot, "boxplot" = ggboxplot, "object" = object))
}
