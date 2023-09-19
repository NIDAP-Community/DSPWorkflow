# This code is a modification from
# "Analyzing GeoMx-NGS RNA Expression Data with GeomxTools" vignette
# https://tinyurl.com/228bs2bp

#' studyDesign: Study Design
#' @description Combine Nanostring Digital Spatial Profile read count and
#' annotation files into a GeoMX object
#' @details `studyDesign` returns a Sankey Plot and a GeoMX object.
#' For the function to run properly the annotation excel file must have the
#' specific field names: slide name', class, segment, region
#' and the corresponding fields that can be renamed: Sample_ID, aoi, roi, panel
#'
#' @param dcc.files A character vector containing the paths to the DCC files.
#' @param pkc.files A character vector representing the path to the
#' corresponding PKC file
#' @param pheno.data.file An optional character string representing the path to
#' the corresponding phenotypic excel data file. It is recommended to use the
#' Lab Worksheet in the exact order samples are provided in.
#' @param pheno.data.sheet An optional character string representing the excel
#' sheet name containing the phenotypic data.
#' @param pheno.data.dcc.col.name Character string identifying unique sample
#' identifier column in phenoDataFile.
#' @param protocol.data.col.names  Character list of column names from
#' phenoDataFile containing data about the experimental protocol or
#' sequencing data.
#' @param experiment.data.col.names  Character list of column names from
#' phenoDataFile containing data about the experiment's meta-data.
#' @param slide.name.col The name of the field that contains the slide names
#' @param class.col The name of the field that contains the class annotation
#' @param region.col The name of the field that contains the class annotation
#' @param segment.col The name of the field that contains the class annotation
#' 
#'
#'
#' @importFrom GeomxTools readNanoStringGeoMxSet
#' @importFrom knitr kable
#' @importFrom dplyr count
#' @importFrom dplyr rename
#' @importFrom ggforce gather_set_data
#' @importFrom BiocGenerics annotation
#' @importFrom ggforce geom_parallel_sets
#' @importFrom ggforce geom_parallel_sets_axes
#' @importFrom ggforce geom_parallel_sets_labels
#' @importFrom ggplot2 theme_classic
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 scale_y_continuous
#' @importFrom ggplot2 expansion
#' @importFrom ggplot2 scale_x_discrete
#' @importFrom ggplot2 annotate
#' @import Biobase
#' @import NanoStringNCTools
#' @export
#' @return A list containing the NanoString Object and the Sankey plot.



studyDesign <- function(dcc.files,
                        pkc.files,
                        pheno.data.file,
                        pheno.data.sheet = "Template",
                        pheno.data.dcc.col.name = "Sample_ID",
                        protocol.data.col.names = c("aoi", "roi"),
                        experiment.data.col.names = c("panel"),
                        slide.name.col = "slide name", 
                        class.col = "class", 
                        region.col = "region", 
                        segment.col = "segment",
                        area.col = "area",
                        nuclei.col = "nuclei", 
                        sankey.exclude.slide = FALSE, 
                        segment.id.length = 4) {
  
  # load all input data into a GeoMX object
  object <-
    readNanoStringGeoMxSet(
      dccFiles = dcc.files,
      pkcFiles = pkc.files,
      phenoDataFile = pheno.data.file,
      phenoDataSheet = pheno.data.sheet,
      phenoDataDccColName = pheno.data.dcc.col.name,
      protocolDataColNames = protocol.data.col.names,
      experimentDataColNames = experiment.data.col.names
    )
  #
  
  # Check the column names for required fields exist in the annotation

  required.field.names = c(slide.name.col, class.col, region.col, segment.col)
  given.field.names = colnames(sData(object))
  for (field in required.field.names) {
    if (!(field %in% given.field.names)) {
      stop(
        paste0(
          field,
          " is not found in the annotation sheet field names.\n"
        )
      )
    }
  }
  
  # Check each of the required fields for correct naming
  optional.field.names = c("area", "nuclei")
  for (field in optional.field.names) {
    if (!(field %in% given.field.names)) {
      warning(
        paste0(
          field,
          " is not found in the annotation and will not be considered \n"
        )
      )
    }
  }
  
  # Rename all of the required columns based on user parameters in data
  colnames(object@phenoData@data)[colnames(object@phenoData@data) == slide.name.col] = "slide_name"
  colnames(object@phenoData@data)[colnames(object@phenoData@data) == class.col] = "class"
  colnames(object@phenoData@data)[colnames(object@phenoData@data) == region.col] = "region"
  colnames(object@phenoData@data)[colnames(object@phenoData@data) == segment.col] = "segment"
  
  # Rename all of the required columns based on user parameters in metadata
  rownames(object@phenoData@varMetadata)[rownames(object@phenoData@varMetadata) == slide.name.col] = "slide_name"
  rownames(object@phenoData@varMetadata)[rownames(object@phenoData@varMetadata) == class.col] = "class"
  rownames(object@phenoData@varMetadata)[rownames(object@phenoData@varMetadata) == region.col] = "region"
  rownames(object@phenoData@varMetadata)[rownames(object@phenoData@varMetadata) == segment.col] = "segment"
  
  # Rename optional columns if they are present
  colnames(object@phenoData@data)[colnames(object@phenoData@data) == area.col] = "area"
  colnames(object@phenoData@data)[colnames(object@phenoData@data) == nuclei.col] = "nuclei"
  rownames(object@phenoData@varMetadata)[rownames(object@phenoData@varMetadata) == area.col] = "area"
  rownames(object@phenoData@varMetadata)[rownames(object@phenoData@varMetadata) == nuclei.col] = "nuclei" 
  
  # Reformat to remove spaces and dashes in the main annotation columns
  annotation.columns <- c("class", "region", "segment")
  
  for(column in annotation.columns){
    pData(object)[[column]] <- gsub("\\s+", "", pData(object)[[column]])
    pData(object)[[column]] <- gsub("-", "", pData(object)[[column]])
  }
  
  # Establish the segment specific IDs
  pData(object)$segmentID <- paste0(substr(pData(object)$class, 1, segment.id.length),
                                    "|",
                                    substr(pData(object)$region, 1, segment.id.length),
                                    "|",
                                    substr(pData(object)$segment, 1, segment.id.length),
                                    "|",
                                    sData(object)$roi)
  
  # Establish variables for the Sankey plot
  slide_name <- region <- segment <- x <- id <- y <- n <- NULL
  
  # Review the PKC mapping files linked in the GeoMX object
  pkcs <- annotation(object)
  modules <- gsub(".pkc", "", pkcs)
  kable(data.frame(PKCs = pkcs, modules = modules))
  
  # select the annotations we want to show, use `` to surround column
  # names with spaces or special symbols
  
  # Create a count matrix with or without slide name
  if(sankey.exclude.slide == TRUE){
    count.mat <-
      count(pData(object), class, region, segment)
  } else {
    count.mat <-
      count(pData(object), slide_name, class, region, segment)
  }
  

  
  # Remove any rows with NA values
  na.per.column <- colSums(is.na(count.mat))
  na.total.count <- sum(na.per.column)
                                               
  if(na.total.count > 0){
    count.mat <- count.mat[!rowSums(is.na(count.mat)),]
    rownames(count.mat) <- 1:nrow(count.mat)
  }
   
  
  # Gather the data and plot in order: class, slide name, region, segment
  # gather_set_data creates x, id, y, and n fields within sankey.count.data
  # Establish the levels of the Sankey with or without the slide name
  if(sankey.exclude.slide == TRUE){
    sankey.count.data <- gather_set_data(count.mat, 1:3)
    sankey.count.data$x <-
      factor(
        sankey.count.data$x,
        levels = c("class", "region", "segment")
      )
    # For position of Sankey 100 segment scale
    adjust.scale.pos = 1
  } else {
    sankey.count.data <- gather_set_data(count.mat, 1:4)
    sankey.count.data$x <-
      factor(
        sankey.count.data$x,
        levels = c("class", "slide_name", "region", "segment")
      )
    # For position of Sankey 100 segment scale
    adjust.scale.pos = 0
  }
  
  # plot Sankey diagram
  sankey.plot <-
    ggplot(sankey.count.data,
           aes(
             x,
             id = id,
             split = y,
             value = n
           )) +
    geom_parallel_sets(aes(fill = region), alpha = 0.5, axis.width = 0.1) +
    geom_parallel_sets_axes(axis.width = 0.2) +
    geom_parallel_sets_labels(color = "gray",
                              size = 5,
                              angle = 0) +
    theme_classic(base_size = 14) +
    theme(
      legend.position = "bottom",
      axis.ticks.y = element_blank(),
      axis.line = element_blank(),
      axis.text.y = element_blank()
    ) +
    scale_y_continuous(expand = expansion(0)) +
    scale_x_discrete(expand = expansion(0)) +
    labs(x = "", y = "") +
    annotate(
      geom = "segment",
      x = (4.25 - adjust.scale.pos),
      xend = (4.25 - adjust.scale.pos),
      y = 20,
      yend = 120,
      lwd = 2
    ) +
    annotate(
      geom = "text",
      x = (4.19 - adjust.scale.pos),
      y = 70,
      angle = 90,
      size = 5,
      hjust = 0.5,
      label = "100 segments"
    )
  
  return(list("object" = object, "sankey.plot" = sankey.plot))
}
