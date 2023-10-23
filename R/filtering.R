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
#' @param object A NanoStringGeoMxSet dataset
#' @param loq.cutoff The number of standard deviations above the negative probe 
#' geometric mean to use as a cutoff for the limit of quantification
#' @param loq.min The minimum value for the limit of quantification
#' @param segment.gene.rate.cutoff A decimal for the minimum cutoff for the 
#' genes detected in a given segment over the total number of genes in the 
#' probe set
#' @param study.gene.rate.cutoff = A decimal for the minimum cutoff for the 
#' average amount a given gene is detected in all segments
#' @param sankey.exclude.slide A toggle for including the slide name in the 
#' Sankey Plot
#' @param goi A list of genes of interest to evaluate for their study-wide 
#' detection rate
#' 
#' @importFrom scales percent
#' @importFrom Biobase pData
#' @importFrom Biobase fData
#' @importFrom ggplot2 ggplot
#'
#' @export
#' @return A list containing the ....

filtering <- function(object, 
                      loq.cutoff = 2, 
                      loq.min = 2, 
                      segment.gene.rate.cutoff = 0.05,
                      study.gene.rate.cutoff = 0.05, 
                      sankey.exclude.slide = FALSE, 
                      goi) {
  
  if(class(object)[1] != "NanoStringGeoMxSet"){
    stop(paste0("Error: The input object must be a NanoStringGeoMxSet" ))
  }
  
  # run reductions ====
  color.variable <- NULL
  
  ### Start Function
  ##4.4Limit of Quantification
  # Define LOQ SD threshold and minimum value
  if(class(loq.cutoff)[1] != "numeric"){
    stop(paste0("Error: LOQ cutoff must be numeric" ))
  }
  if(class(loq.min)[1] != "numeric"){
    stop(paste0("Error: LOQ min must be numeric" ))
  }
  # Define Modules
  pkc.file <- annotation(object)
  if(class(pkc.file)[1] != "character"){
    stop(paste0("The pkc file name must be character" ))
  }
  modules <- gsub(".pkc", "", pkc.file)
  
  # Calculate LOQ per module tested
  loq <- data.frame(row.names = colnames(object))
  for(module in modules) {
    vars <- paste0(c("NegGeoMean_", "NegGeoSD_"),
                   module)
    if(all(vars[1:2] %in% colnames(pData(object)))) {
      loq[, module] <-
        pmax(loq.min,
             pData(object)[, vars[1]] * 
               pData(object)[, vars[2]] ^ loq.cutoff)
    }
  }
  pData(object)$loq <- loq
  
  ## 4.5.0 Filtering
  loq.mat <- c()
  for(module in modules) {
    ind <- fData(object)$Module == module
    mat.i <- t(esApply(object[ind, ], MARGIN = 1,
                       FUN = function(x) {
                         x > loq[, module]
                       }))
    loq.mat <- rbind(loq.mat, mat.i)
  }
  # ensure ordering since this is stored outside of the geomxSet
  loq.mat <- loq.mat[fData(object)$TargetName, ]
  
  # Evaluate and Filter Segment Gene Detection Rate
  # Save detection rate information to pheno data
  pData(object)$GenesDetected <- 
    colSums(loq.mat, na.rm = TRUE)
  pData(object)$GeneDetectionRate <-
    pData(object)$GenesDetected / nrow(object)
  
  # Determine detection thresholds: 1%, 5%, 10%, 15%, >15%
  pData(object)$DetectionThreshold <- 
    cut(pData(object)$GeneDetectionRate,
        breaks = c(0, 0.01, 0.05, 0.1, 0.15, 1),
        labels = c("<1%", "1-5%", "5-10%", "10-15%", ">15%"))
  
  # stacked bar plot of different cut points (1%, 5%, 10%, 15%)
  stacked.bar.plot<- ggplot(pData(object),
                            aes(x = DetectionThreshold)) +
    geom_bar(aes(fill = region)) +
    geom_text(stat = "count", aes(label = ..count..), vjust = -0.5) +
    theme_bw() +
    scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
    labs(x = "Gene Detection Rate",
         y = "Segments, #",
         fill = "Segment Type")
  
  # cut percent genes detected at 1, 5, 10, 15
  segment.table <- kable(table(pData(object)$DetectionThreshold, 
                               pData(object)$class))
  if(class(segment.gene.rate.cutoff)[1] != "numeric"){
    stop(paste0("Error: segment.gene.rate.cutoff must be numeric" ))
  }
  if(segment.gene.rate.cutoff > 1 | segment.gene.rate.cutoff < 0){
    stop(paste0("Error: segment.gene.rate.cutoff must be between 0-1" ))
  }
  
  # Filter the data using the cutoff for gene detection rate
  object <-
    object[, pData(object)$GeneDetectionRate >= segment.gene.rate.cutoff]
  
  # Create a post-filtering Sankey Plot
  
  # Create a count matrix with or without slide name
  if(sankey.exclude.slide == TRUE){
    count.mat <-
      count(pData(object), class, region, segment)
  } else {
    count.mat <-
      count(pData(object), slide_name, class, region, segment)
  }
  
  if(class(object)[1] != "NanoStringGeoMxSet"){
    stop(paste0("Error: You have the wrong data class, must be NanoStringGeoMxSet" ))
  }
  
  # gather_set_data creates x, id, y, and n fields within sankey.count.data
  # Establish the levels of the Sankey with or without the slide name
  if(sankey.exclude.slide == TRUE){
    # Create a dataframe used to make the Sankey plot
    sankey.count.data <- gather_set_data(count.mat, 1:3)
    
    # Define the annotations to use for the Sankey x axis labels
    sankey.count.data$x[sankey.count.data$x == 1] <- "class"
    sankey.count.data$x[sankey.count.data$x == 2] <- "region"
    sankey.count.data$x[sankey.count.data$x == 3] <- "segment"
    
    factor(
      sankey.count.data$x,
      levels = c("class", "region", "segment")
    )
    
    # For position of Sankey 100 segment scale
    adjust.scale.pos = 1
  } else {
    # Create a dataframe used to make the Sankey plot
    sankey.count.data <- gather_set_data(count.mat, 1:4)
    
    # Define the annotations to use for the Sankey x axis labels
    sankey.count.data$x[sankey.count.data$x == 1] <- "slide_name"
    sankey.count.data$x[sankey.count.data$x == 2] <- "class"
    sankey.count.data$x[sankey.count.data$x == 3] <- "region"
    sankey.count.data$x[sankey.count.data$x == 4] <- "segment"
    
    factor(
      sankey.count.data$x,
      levels = c("class", "slide_name", "region", "segment")
    )
    
    # For position of Sankey 100 segment scale
    adjust.scale.pos = 0
  }
  
  # plot Sankey
  sankey.plot <- ggplot(sankey.count.data, aes(x, id = id, split = y, value = n)) +
    geom_parallel_sets(aes(fill = class), alpha = 0.5, axis.width = 0.1) +
    geom_parallel_sets_axes(axis.width = 0.2) +
    geom_parallel_sets_labels(color = "gray", size = 5, angle = 0) +
    theme_classic(base_size = 17) + 
    theme(legend.position = "bottom",
          axis.ticks.y = element_blank(),
          axis.line = element_blank(),
          axis.text.y = element_blank()) +
    scale_y_continuous(expand = expansion(0)) + 
    scale_x_discrete(expand = expansion(0)) +
    labs(x = "", y = "") +
    annotate(geom = "segment", 
             x = (4.25 - adjust.scale.pos), 
             xend = (4.25 - adjust.scale.pos), 
             y = 20, 
             yend = 120, 
             lwd = 2) +
    annotate(geom = "text", 
             x = (4.19 - adjust.scale.pos), 
             y = 70, 
             angle = 90, 
             size = 5,
             hjust = 0.5, 
             label = "100 segments")
  
  
  
  # Evaluate and Filter Study-wide Gene Detection Rate 
  # Calculate detection rate:
  loq.mat <- loq.mat[, colnames(object)]
  fData(object)$DetectedSegments <- rowSums(loq.mat, na.rm = TRUE)
  fData(object)$DetectionRate <-
    fData(object)$DetectedSegments / nrow(pData(object))
  
  # Gene of interest detection table
  goi <- goi
  if(class(goi)[1] != "character"){
    stop(paste0("Error: You have the wrong data class, must be character vector" ))
  }
  goi.table <- data.frame(Gene = goi,
                       Number = fData(object)[goi, "DetectedSegments"],
                       DetectionRate = percent(fData(object)[goi, "DetectionRate"]))
  #goi.table <- capture.output(print(goi.df, row.name = FALSE))
  
  ## 4.5.3 Gene Filtering
  
  # Check that the study gene rate cutoff is correctly entered
  if(class(study.gene.rate.cutoff)[1] != "numeric"){
    stop(paste0("Error: study.gene.rate.cutoff must be numeric" ))
  }
  if(study.gene.rate.cutoff > 1 | study.gene.rate.cutoff < 0){
    stop(paste0("Error: study.gene.rate.cutoff must be between 0-1" ))
  }
  
  # Plot detection rate:
  plot.detect <- data.frame(Freq = c(1, 5, 10, 20, 30, 50))
  plot.detect$Number <-
    unlist(lapply(c(0.01, 0.05, 0.1, 0.2, 0.3, 0.5),
                  function(x) {sum(fData(object)$DetectionRate >= x)}))
  plot.detect$Rate <- plot.detect$Number / nrow(fData(object))
  rownames(plot.detect) <- plot.detect$Freq
  
  genes.detected.plot <- ggplot(plot.detect, aes(x = as.factor(Freq), y = Rate, fill = Rate)) +
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
  
  # Subset for genes above the study gene detection rate cutoff
  # Manually include the negative control probe, for downstream use
  negative.probe.fData <- subset(fData(object), CodeClass == "Negative")
  neg.probes <- unique(negative.probe.fData$TargetName)
  object <- object[fData(object)$DetectionRate >= study.gene.rate.cutoff |
                     fData(object)$TargetName %in% neg.probes, ]
  
  return(list("stacked.bar.plot" = stacked.bar.plot, "segment.table" = segment.table, "goi.table" = goi.table, "sankey.plot" = sankey.plot, "genes.detected.plot" = genes.detected.plot, "object" = object))
}
