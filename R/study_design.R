####This code comes from 
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#2_Getting_started


library(NanoStringNCTools)
library(GeomxTools)
library(dplyr)
library(ggforce)
library(knitr)


#' Ingest Nano String Digital Spatial Profile study
#'
#' @param dccfiles A character vector containing the paths to the DCC files.
#' @param pkcFiles A character vector representing the path to the corresponding PKC file
#' @param phenoDataFile An optional character string representing the path to the corresponding phenotypic excel data file. It is recommended to use the Lab Worksheet in the exact order samples are provided in.
#' @param phenoDataSheet An optional character string representing the excel sheet name containing the phenotypic data.
#' @param phenoDataDccColName Character string identifying unique sample identifier column in phenoDataFile.
#' @param phenoDataColPrefix  An optional prefix to add to the phenoData column names to distinguish them from the names of assayData matrices, featureData columns, and protocolData columns.
#' @param protocolDataColNames  Character list of column names from phenoDataFile containing data about the experimental protocol or sequencing data.
#' @param experimentDataColNames  Character list of column names from phenoDataFile containing data about the experiment's meta-data.
#' 
#' 
#' @return A NanoString Object.

study_design <- function(dccFiles, pkcFiles, phenoDataFile, phenoDataSheet = "Template", 
                         phenoDataDccColName = "Sample_ID", 
                         protocolDataColNames = c("aoi", "roi"), 
                         experimentDataColNames = c("panel")) {

  # load data
  demoData <-
    readNanoStringGeoMxSet(dccFiles = dccFiles,
                           pkcFiles = pkcFiles,
                           phenoDataFile = phenoDataFile,
                           phenoDataSheet = phenoDataSheet,
                           phenoDataDccColName = phenoDataDccColName,
                           protocolDataColNames = protocolDataColNames,
                           experimentDataColNames = experimentDataColNames)


  pkcs <- annotation(demoData)
  modules <- gsub(".pkc", "", pkcs)
  kable(data.frame(PKCs = pkcs, modules = modules))




  # select the annotations we want to show, use `` to surround column names with
  # spaces or special symbols
  count_mat <- count(pData(demoData), `slide name`, class, region, segment)
  # simplify the slide names
  count_mat$`slide name` <- gsub("disease", "d",
                                 gsub("normal", "n", count_mat$`slide name`))
  # gather the data and plot in order: class, slide name, region, segment
  test_gr <- gather_set_data(count_mat, 1:4)
  test_gr$x <- factor(test_gr$x,
                      levels = c("class", "slide name", "region", "segment"))
  # plot Sankey
  p <- ggplot(test_gr, aes(x, id = id, split = y, value = n)) +
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
    annotate(geom = "segment", x = 4.25, xend = 4.25,
             y = 20, yend = 120, lwd = 2) +
    annotate(geom = "text", x = 4.19, y = 70, angle = 90, size = 5,
             hjust = 0.5, label = "100 segments")
  
  return(list("dsp_obj" = demoData, "plot" = p))
}