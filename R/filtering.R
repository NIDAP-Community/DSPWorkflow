##Start here:
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#44_Limit_of_Quantification

#' Normalize Nano String Digital Spatial Profile
#' @param Data A NanoStringGeoMxSet dataset
#' @importFrom scales percent
#' @importFrom Biobase pData
#' @importFrom Biobase fData
#' @importFrom ggplot2 ggplot
#'
#' @export
#' @return A list containing the ....

# Function I dropped
#importFrom Rmpfr pmax


# To call function, must have Data = raw target_demoData, dsp.obj = QC demoData, 
# LOQcutoff 2 is recommended, LOQmin 2 is recommend, 
# Cutsegment = remove segments with less than 10% of the genes detected; .05-.1 recommended,
# GOI = goi (genes of interest). Must be a vector of genes (i.e c("PDCD1", "CD274")),
filtering <- function(Data, dsp_obj, PKCS, LOQcutoff, LOQmin, CutSegment, GOI) {
  
  # run reductions ====
  color.variable <- NULL
  
  ### Start Function
  ##4.4Limit of Quantification
  # Define LOQ SD threshold and minimum value
  cutoff <- LOQcutoff
  minLOQ <- LOQmin
  # Define Modules
  pkcs <- PKCS
  modules <- gsub(".pkc", "", pkcs)

  # Calculate LOQ per module tested
  LOQ <- data.frame(row.names = colnames(Data))
  for(module in modules) {
    vars <- paste0(c("NegGeoMean_", "NegGeoSD_"),
                   module)
    if(all(vars[1:2] %in% colnames(pData(Data)))) {
      LOQ[, module] <-
        pmax(minLOQ,
             pData(Data)[, vars[1]] * 
               pData(Data)[, vars[2]] ^ cutoff)
    }
  }
  pData(Data)$LOQ <- LOQ
  
  ## 4.5.0 Filtering
  LOQ_Mat <- c()
  for(module in modules) {
    ind <- fData(Data)$Module == module
    Mat_i <- t(esApply(Data[ind, ], MARGIN = 1,
                       FUN = function(x) {
                         x > LOQ[, module]
                       }))
    LOQ_Mat <- rbind(LOQ_Mat, Mat_i)
  }
  # ensure ordering since this is stored outside of the geomxSet
  LOQ_Mat <- LOQ_Mat[fData(Data)$TargetName, ]

  ##4.5.1S egment Gene Detection
  # Save detection rate information to pheno data
  pData(Data)$GenesDetected <- 
    colSums(LOQ_Mat, na.rm = TRUE)
  pData(Data)$GeneDetectionRate <-
    pData(Data)$GenesDetected / nrow(Data)
  
  # Determine detection thresholds: 1%, 5%, 10%, 15%, >15%
  pData(Data)$DetectionThreshold <- 
    cut(pData(Data)$GeneDetectionRate,
        breaks = c(0, 0.01, 0.05, 0.1, 0.15, 1),
        labels = c("<1%", "1-5%", "5-10%", "10-15%", ">15%"))
  
  # stacked bar plot of different cut points (1%, 5%, 10%, 15%)
  StackedBarPlot<- ggplot(pData(Data),
                          aes(x = DetectionThreshold)) +
                   geom_bar(aes(fill = region)) +
                   geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
                   theme_bw() +
                   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
                   labs(x = "Gene Detection Rate",
                        y = "Segments, #",
                        fill = "Segment Type")
  
  
  # cut percent genes detected at 1, 5, 10, 15
  tab<- kable(table(pData(Data)$DetectionThreshold, pData(Data)$class))
  target_demoData <- Data[, pData(Data)$GeneDetectionRate >= CutSegment]
  
  # select the annotations we want to show, use `` to surround column names with
  # spaces or special symbols
  count_mat <- count(pData(dsp_obj), `slide name`, class, region, segment)
  # simplify the slide names
  count_mat$`slide name` <- gsub("disease", "d", gsub("normal", "n", count_mat$`slide name`))
  # gather the data and plot in order: class, slide name, region, segment
  test_gr <- gather_set_data(count_mat, 1:4)
  test_gr$x <-factor(test_gr$x, levels = c("class", "slide name", "region", "segment"))
  # plot Sankey
  Sankey_Plot<- ggplot(test_gr, aes(x, id = id, split = y, value = n)) +
                geom_parallel_sets(aes(fill = region), alpha = 0.5, axis.width = 0.1) +
                geom_parallel_sets_axes(axis.width = 0.2) +
                geom_parallel_sets_labels(color = "white", size = 5) +
                theme_classic(base_size = 17) + 
                theme(legend.position = "bottom",
                      axis.ticks.y = element_blank(),
                      axis.line = element_blank(),
                      axis.text.y = element_blank()) +
                scale_y_continuous(expand = expansion(0)) + 
                scale_x_discrete(expand = expansion(0)) +
                labs(x = "", y = "") +
                annotate(geom = "segment", x = 4.25, xend = 4.25, y = 20, 
                         yend = 120, lwd = 2) +
                annotate(geom = "text", x = 4.19, y = 70, angle = 90, size = 5,
                         hjust = 0.5, label = "100 segments")
  
  ##4.5.2 Gene Detection Rate
  # Calculate detection rate:
  LOQ_Mat <- LOQ_Mat[, colnames(target_demoData)]
  fData(target_demoData)$DetectedSegments <- rowSums(LOQ_Mat, na.rm = TRUE)
  fData(target_demoData)$DetectionRate <-
    fData(target_demoData)$DetectedSegments / nrow(pData(target_demoData))
  
  # Gene of interest detection table
  goi <- GOI
  goi_df <- data.frame(Gene = goi,
    Number = fData(target_demoData)[goi, "DetectedSegments"],
    DetectionRate = percent(fData(target_demoData)[goi, "DetectionRate"]))
  
  ## 4.5.3 Gene Filtering
  # Plot detection rate:
  plot_detect <- data.frame(Freq = c(1, 5, 10, 20, 30, 50))
  plot_detect$Number <-
    unlist(lapply(c(0.01, 0.05, 0.1, 0.2, 0.3, 0.5),
                  function(x) {sum(fData(target_demoData)$DetectionRate >= x)}))
  plot_detect$Rate <- plot_detect$Number / nrow(fData(target_demoData))
  rownames(plot_detect) <- plot_detect$Freq
  
  GenesDected<- ggplot(plot_detect, aes(x = as.factor(Freq), y = Rate, fill = Rate)) +
                geom_bar(stat = "identity") +
                geom_text(aes(label = formatC(Number, format = "d", big.mark = ",")),
                          vjust = 1.6, color = "black", size = 4) +
                scale_fill_gradient2(low = "orange2", mid = "lightblue",
                                     high = "dodgerblue3", midpoint = 0.65,
                                     limits = c(0,1),
                                     labels = scales::percent) +
                theme_bw() +
                scale_y_continuous(labels = scales::percent, limits = c(0,1),
                                   expand = expansion(mult = c(0, 0))) +
                labs(x = "% of Segments",
                     y = "Genes Detected, % of Panel > LOQ")
  
  # Subset to target genes detected in at least 10% of the samples.
  #   Also manually include the negative control probe, for downstream use
  negativeProbefData <- subset(fData(target_demoData), CodeClass == "Negative")
  neg_probes <- unique(negativeProbefData$TargetName)
  target_demoData <- target_demoData[fData(target_demoData)$DetectionRate >= 0.1 |
                      fData(target_demoData)$TargetName %in% neg_probes, ]
  
  # retain only detected genes of interest
  goi <- goi[goi %in% rownames(target_demoData)]

  return(list("Stacked Bar Plot" = StackedBarPlot, "Table of Cuts" = tab, "Sankey Plot" = Sankey_Plot, "Genes Deccted Plot" = GenesDected, "target_demoData Dataset" = target_demoData))
}