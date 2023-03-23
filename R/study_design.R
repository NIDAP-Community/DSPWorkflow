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
#'
#' @importFrom GeomxTools readNanoStringGeoMxSet
#' @importFrom knitr kable
#' @importFrom dplyr count
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
#' @export
#' @return A list containing the NanoString Object and the Sankey plot.



studyDesign <- function(dcc.files,
                        pkc.files,
                        pheno.data.file,
                        pheno.data.sheet = "Template",
                        pheno.data.dcc.col.name = "Sample_ID",
                        protocol.data.col.names = c("aoi", "roi"),
                        experiment.data.col.names = c("panel")) {
  region <- segment <- x <- id <- y <- n <- NULL
  `slide name` <- NULL
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
  
  
  # Review the PKC mapping files linked in the GeoMX object
  pkcs <- annotation(object)
  modules <- gsub(".pkc", "", pkcs)
  kable(data.frame(PKCs = pkcs, modules = modules))
  
  # Check each of the required fields for correct naming
  required.field.names = c("slide name", "class", "segment", "region")
  given.field.names = colnames(sData(object))
  for (field in required.field.names) {
    if (!(field %in% given.field.names)) {
      stop(
        paste0(
          field,
          " is required and NOT found in the annotation.
                  Please correct annotation sheet fields.\n"
        )
      )
    }
  }
  
  
  
  # select the annotations we want to show, use `` to surround column
  # names with spaces or special symbols
  count.mat <-
    count(pData(object), `slide name`, class, region, segment)
  
  # gather the data and plot in order: class, slide name, region, segment
  # gather_set_data creates x, id, y, and n fields within sankey.count.data
  sankey.count.data <- gather_set_data(count.mat, 1:4)
  sankey.count.data$x <-
    factor(
      sankey.count.data$x,
      levels = c("class", "slide name", "region", "segment")
    )
  
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
    theme_classic(base_size = 17) +
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
      x = 4.25,
      xend = 4.25,
      y = 20,
      yend = 120,
      lwd = 2
    ) +
    annotate(
      geom = "text",
      x = 4.19,
      y = 70,
      angle = 90,
      size = 5,
      hjust = 0.5,
      label = "100 segments"
    )
  
  return(list("object" = object, "sankey.plot" = sankey.plot))
}
