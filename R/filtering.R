##Start here:
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#44_Limit_of_Quantification

#' Normalize Nano String Digital Spatial Profile
#' 
#' @title Filtering NanoStringGeoMxSet dataset
#'
#' @description Function for filtering NanoStringGeoMxSet dataset
#'
#' @details This function will run various filtering parameters for NanoStringGeoMxSet datasets
#' 
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
# To call function, must have data = raw object, dsp.obj = QC demoData, 
# loq.cutoff 2 is recommended, loq.min 2 is recommend, 
# cut.segment = remove segments with less than 10% of the genes detected; .05-.1 recommended,
# goi = goi (genes of interest). Must be a vector of genes (i.e c("PDCD1", "CD274")),
filtering <- function(data, pkcs, loq.cutoff, loq.min, cut.segment, goi) {
  
  if(class(data)[1] != "NanoStringGeoMxSet"){
    stop(paste0("Error: You have the wrong data class, must be NanoStringGeoMxSet" ))
  }
  
  # run reductions ====
  color.variable <- NULL
  
  ### Start Function
  ##4.4Limit of Quantification
  # Define LOQ SD threshold and minimum value
  if(class(loq.cutoff)[1] != "numeric"){
    stop(paste0("Error: You have the wrong data class, must be numeric" ))
  }
  if(class(loq.min)[1] != "numeric"){
    stop(paste0("Error: You have the wrong data class, must be numeric" ))
  }
  # Define Modules
  pkcs <- pkcs
  if(class(pkcs)[1] != "character"){
    stop(paste0("Error: You have the wrong data class, must be character" ))
  }
  modules <- gsub(".pkc", "", pkcs)
  
  # Collapse probes to gene targets
  #target_Data <- aggregateCounts(data)
  
  # Calculate LOQ per module tested
  loq <- data.frame(row.names = colnames(data))
  for(module in modules) {
    vars <- paste0(c("NegGeoMean_", "NegGeoSD_"),
                   module)
    if(all(vars[1:2] %in% colnames(pData(data)))) {
      loq[, module] <-
        pmax(loq.min,
             pData(data)[, vars[1]] * 
               pData(data)[, vars[2]] ^ loq.cutoff)
    }
  }
  pData(data)$loq <- loq
  
  ## 4.5.0 Filtering
  loq_mat <- c()
  for(module in modules) {
    ind <- fData(data)$Module == module
    mat_i <- t(esApply(data[ind, ], MARGIN = 1,
                       FUN = function(x) {
                         x > loq[, module]
                       }))
    loq_mat <- rbind(loq_mat, mat_i)
  }
  # ensure ordering since this is stored outside of the geomxSet
  loq_mat <- loq_mat[fData(data)$TargetName, ]
  
  ##4.5.1S egment Gene Detection
  # Save detection rate information to pheno data
  pData(data)$GenesDetected <- 
    colSums(loq_mat, na.rm = TRUE)
  pData(data)$GeneDetectionRate <-
    pData(data)$GenesDetected / nrow(data)
  
  # Determine detection thresholds: 1%, 5%, 10%, 15%, >15%
  pData(data)$DetectionThreshold <- 
    cut(pData(data)$GeneDetectionRate,
        breaks = c(0, 0.01, 0.05, 0.1, 0.15, 1),
        labels = c("<1%", "1-5%", "5-10%", "10-15%", ">15%"))
  
  # stacked bar plot of different cut points (1%, 5%, 10%, 15%)
  stacked.bar.plot<- ggplot(pData(data),
                            aes(x = DetectionThreshold)) +
    geom_bar(aes(fill = region)) +
    geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
    theme_bw() +
    scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
    labs(x = "Gene Detection Rate",
         y = "Segments, #",
         fill = "Segment Type")
  
  
  # cut percent genes detected at 1, 5, 10, 15
  tab<- kable(table(pData(data)$DetectionThreshold, pData(data)$class))
  if(class(cut.segment)[1] != "numeric"){
    stop(paste0("Error: You have the wrong data class, must be numeric" ))
  }
  object <- data[, pData(data)$GeneDetectionRate >= cut.segment]
  if(cut.segment > 1 | cut.segment < 0){
    stop(paste0("Error: You need perecentage in decimals between 0-1" ))
  }
  
  # select the annotations we want to show, use `` to surround column names with
  # spaces or special symbols
  count_mat <- count(pData(data), `slide name`, class, region, segment)
  if(class(data)[1] != "NanoStringGeoMxSet"){
    stop(paste0("Error: You have the wrong data class, must be NanoStringGeoMxSet" ))
  }
  # simplify the slide names
  count_mat$`slide name` <- gsub("disease", "d", gsub("normal", "n", count_mat$`slide name`))
  # gather the data and plot in order: class, slide name, region, segment
  test_gr <- gather_set_data(count_mat, 1:4)
  test_gr$x <-factor(test_gr$x, levels = c("class", "slide name", "region", "segment"))
  # plot Sankey
  sankey.plot<- ggplot(test_gr, aes(x, id = id, split = y, value = n)) +
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
  loq_mat <- loq_mat[, colnames(object)]
  fData(object)$DetectedSegments <- rowSums(loq_mat, na.rm = TRUE)
  fData(object)$DetectionRate <-
    fData(object)$DetectedSegments / nrow(pData(object))
  
  # Gene of interest detection table
  goi <- goi
  if(class(goi)[1] != "character"){
    stop(paste0("Error: You have the wrong data class, must be character vector" ))
  }
  goi_df <- data.frame(Gene = goi,
                       Number = fData(object)[goi, "DetectedSegments"],
                       DetectionRate = percent(fData(object)[goi, "DetectionRate"]))
  
  ## 4.5.3 Gene Filtering
  # Plot detection rate:
  plot_detect <- data.frame(Freq = c(1, 5, 10, 20, 30, 50))
  plot_detect$Number <-
    unlist(lapply(c(0.01, 0.05, 0.1, 0.2, 0.3, 0.5),
                  function(x) {sum(fData(object)$DetectionRate >= x)}))
  plot_detect$Rate <- plot_detect$Number / nrow(fData(object))
  rownames(plot_detect) <- plot_detect$Freq
  
  genes.detected<- ggplot(plot_detect, aes(x = as.factor(Freq), y = Rate, fill = Rate)) +
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
         y = "Genes Detected, % of Panel > loq")
  
  # Subset to target genes detected in at least 10% of the samples.
  #   Also manually include the negative control probe, for downstream use
  negativeProbefData <- subset(fData(object), CodeClass == "Negative")
  neg_probes <- unique(negativeProbefData$TargetName)
  object <- object[fData(object)$DetectionRate >= 0.1 |
                     fData(object)$TargetName %in% neg_probes, ]
  
  # retain only detected genes of interest
  goi <- goi[goi %in% rownames(object)]
  
  return(list("Stacked Bar Plot" = stacked.bar.plot, "Table of Cuts" = tab, "Sankey Plot" = sankey.plot, "Genes Detected Plot" = genes.detected, "object Dataset" = object))
}