#This code comes from:
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#5_Normalization

#' Normalize Nano String Digital Spatial Profile
#' @param Data A NanoStringGeoMxSet dataset
#' @param Norm A vector with options of c(quant or neg)
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
#' @importFrom graphics boxplot
#' @importFrom stats quantile
#' @importFrom utils head
#' @importFrom GeomxTools normalize
#'
#'
#' @export
#' @return A list containing the ggplot grid, a boxplot, an normalized dataframe.


# target_deoData will need to be changed at some point
# To call function, must have Data = data; Norm = c(quant or neg)
GeoMxNorm <- function(Data, Norm) {
  
  if(class(Data)[1] != "NanoStringGeoMxSet"){
    stop(paste0("Error: You have the wrong data class, must be NanoStringGeoMxSet" ))
  }
  
  # run reductions ====
  color.variable <-
    Value <- Statistic <- NegProbe <- Q3 <- Annotation <- NULL
  
  # Start Function
  neg_probes<- "NegProbe-WTX"
  ann_of_interest <- "region"
  
  Stat_data <- base::data.frame(row.names = colnames(exprs(Data)),
                           Segment = colnames(exprs(Data)),
                           Annotation = Biobase::pData(Data)[, ann_of_interest],
                           Q3 = unlist(apply(exprs(Data), 2,
                                             quantile, 0.75, na.rm = TRUE)),
                           NegProbe = exprs(Data)[neg_probes, ])
  
  Stat_data_m <- melt(Stat_data, measures.vars = c("Q3", "NegProbe"),
                       variable.name = "Statistic", value.name = "Value")
  
  plt1 <- ggplot(Stat_data_m,
                 aes(x = Value, fill = Statistic)) +
    geom_histogram(bins = 40) + theme_bw() +
    scale_x_continuous(trans = "log2") +
    facet_wrap(~Annotation, nrow = 1) + 
    scale_fill_brewer(palette = 3, type = "qual") +
    labs(x = "Counts", y = "Segments, #")
  
  plt2 <- ggplot(Stat_data,
                 aes(x = NegProbe, y = Q3, color = Annotation)) +
    geom_abline(intercept = 0, slope = 1, lty = "dashed", color = "darkgray") +
    geom_point() + guides(color = "none") + theme_bw() +
    scale_x_continuous(trans = "log2") + 
    scale_y_continuous(trans = "log2") +
    theme(aspect.ratio = 1) +
    labs(x = "Negative Probe GeoMean, Counts", y = "Q3 Value, Counts")
  
  plt3 <- ggplot(Stat_data,
                 aes(x = NegProbe, y = Q3 / NegProbe, color = Annotation)) +
    geom_hline(yintercept = 1, lty = "dashed", color = "darkgray") +
    geom_point() + theme_bw() +
    scale_x_continuous(trans = "log2") + 
    scale_y_continuous(trans = "log2") +
    theme(aspect.ratio = 1) +
    labs(x = "Negative Probe GeoMean, Counts", y = "Q3/NegProbe Value, Counts")
  
  btm_row <- plot_grid(plt2, plt3, nrow = 1, labels = c("B", ""),
                       rel_widths = c(0.43,0.57))
  p <- plot_grid(plt1, btm_row, ncol = 1, labels = c("A", ""))
  
  if(Norm == "quant"){
    # Q3 norm (75th percentile) for WTA/CTA  with or without custom spike-ins
    target_demoData <- normalize(Data,
                                  norm_method = "quant", 
                                  desiredQuantile = .75,
                                  toElt = "q_norm")
    # take old boxplot assayDataElement(target_demoData[,1:10], elt = "q_norm")
    transform1<- assayDataElement(target_demoData[,1:10], elt = "q_norm")
    transform2<- as.data.frame(transform1)
    transform3<- melt(transform2)
    b<- ggplot(transform3, aes(variable, value)) +
         stat_boxplot(geom = "errorbar") +
         geom_boxplot(fill="#2CA02C") +
         scale_y_log10() +
         xlab("Segment") + 
         ylab("Counts, Quant. Normailzed") +
         ggtitle("Quant Norm Counts") +
         scale_x_discrete(labels=c(1:10))
  }
  if(Norm == "Quant"){
    stop(paste0("Error: Quant needs to be quant" ))
  }
  if(Norm == "quantile"){
    stop(paste0("Error: quantile needs to be quant" ))
  }
  if(Norm == "Quantile"){
    stop(paste0("Error: Quantile needs to be quant" ))
  }
  
  if(Norm == "neg"){
    # Background normalization for WTA/CTA without custom spike-in
    target_demoData <- normalize(Data,
                                  norm_method = "neg", 
                                  fromElt = "exprs",
                                  toElt = "neg_norm")
    # take old boxplot assayDataElement(target_demoData[,1:10], elt = "q_norm")
    transform1<- assayDataElement(target_demoData[,1:10], elt = "neg_norm")
    transform2<- as.data.frame(transform1)
    transform3<- melt(transform2)
    b<- ggplot(transform3, aes(variable, value)) +
         stat_boxplot(geom = "errorbar") +
         geom_boxplot(fill="#FF7F0E") +
         scale_y_log10() +
         xlab("Segment") + 
         ylab("Counts, Neg. Normailzed") +
         ggtitle("Neg Norm Counts") +
         scale_x_discrete(labels=c(1:10))
  }
  if(Norm == "Neg"){
    stop(paste0("Error: Neg needs to be neg" ))
  }
  if(Norm == "negative"){
    stop(paste0("Error: negative needs to be neg" ))
  }
  if(Norm == "Negative"){
    stop(paste0("Error: Negative needs to be neg" ))
  }
  
  return(list("plot" = p, "Boxplot" = b, "Normalized Dataframe" = target_demoData))
}
