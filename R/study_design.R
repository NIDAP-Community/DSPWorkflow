####This code comes from 
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#2_Getting_started

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# The following initializes most up to date version of Bioc
BiocManager::install(version="3.15")

BiocManager::install("NanoStringNCTools")
BiocManager::install("GeomxTools")
BiocManager::install("GeoMxWorkflows")

library(NanoStringNCTools)
library(GeomxTools)
library(GeoMxWorkflows)

if(packageVersion("GeomxTools") < "2.1" & 
   packageVersion("GeoMxWorkflows") >= "1.0.1"){
  stop("GeomxTools and Workflow versions do not match. Please use the same version. 
    This workflow is meant to be used with most current version of packages. 
    If you are using an older version of Bioconductor please reinstall GeoMxWorkflows and use vignette(GeoMxWorkflows) instead")
}

if(packageVersion("GeomxTools") > "2.1" & 
   packageVersion("GeoMxWorkflows") <= "1.0.1"){
  stop("GeomxTools and Workflow versions do not match. 
         Please use the same version, see install instructions above.")
  
  # to remove current package version
  # remove.packages("GeomxTools")
  # remove.packages("GeoMxWorkflows")
  # see install instructions above 
}

# Reference the main folder 'file.path' containing the sub-folders with each
# data file type:
datadir <- system.file("extdata", "WTA_NGS_Example",
                       package="GeoMxWorkflows")
# to locate a specific file path replace the above line with
# datadir <- file.path("~/Folder/SubFolder/DataLocation")
# replace the Folder, SubFolder, DataLocation as needed

# the DataLocation folder should contain a dccs, pkcs, and annotation folder
# with each set of files present as needed


# automatically list files in each directory for use
DCCFiles <- dir(file.path(datadir, "dccs"), pattern = ".dcc$",
                full.names = TRUE, recursive = TRUE)
PKCFiles <- unzip(zipfile = dir(file.path(datadir, "pkcs"), pattern = ".zip$",
                                full.names = TRUE, recursive = TRUE))
SampleAnnotationFile <-
  dir(file.path(datadir, "annotation"), pattern = ".xlsx$",
      full.names = TRUE, recursive = TRUE)

# load data
demoData <-
  readNanoStringGeoMxSet(dccFiles = DCCFiles,
                         pkcFiles = PKCFiles,
                         phenoDataFile = SampleAnnotationFile,
                         phenoDataSheet = "Template",
                         phenoDataDccColName = "Sample_ID",
                         protocolDataColNames = c("aoi", "roi"),
                         experimentDataColNames = c("panel"))


#3.1Modules Used

library(knitr)
pkcs <- annotation(demoData)
modules <- gsub(".pkc", "", pkcs)
kable(data.frame(PKCs = pkcs, modules = modules))

#3.2Sample Overview
study_design <- function(demoData,etc...) {

  library(dplyr)
library(ggforce)

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
ggplot(test_gr, aes(x, id = id, split = y, value = n)) +
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

}