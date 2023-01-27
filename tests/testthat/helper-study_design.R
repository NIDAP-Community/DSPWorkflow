select_dataset_sd <- function(dataset) {
  
  #AnnotationSheetName <- SampleAnnotationFile <- PKCFiles <- datadir <- NULL
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    datadir <- "/rstudio-files/ccr-dceg-data/data/WTA_NGS_Example"
    DCCFiles <- dir(file.path(datadir, "dccs"), pattern = ".dcc$", full.names = TRUE, recursive = TRUE)
    PKCFiles <- "/rstudio-files/ccr-dceg-data/data/Kidney_Dataset/pkcs/TAP_H_WTA_v1.0.pkc"
    SampleAnnotationFile <- "/rstudio-files/ccr-dceg-data/data/WTA_NGS_Example/annotation/kidney_AOI_Annotations_all_vignette.xlsx"
    AnnotationSheetName = "Template"
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    datadir <- "/rstudio-files/ccr-dceg-data/data/Thymus_Dataset"
    DCCFiles <- dir(file.path(datadir, "dccs"), pattern = ".dcc$", full.names = TRUE, recursive = TRUE)
    PKCFiles <- "/rstudio-files/ccr-dceg-data/data/Thymus_Dataset/pkcs/Mm_R_NGS_WTA_v1.0.pkc"
    SampleAnnotationFile <- "/rstudio-files/ccr-dceg-data/data/Thymus_Dataset/annotations/Thymus_Annotation_updated_3.xlsx"
    AnnotationSheetName = "Annotation"
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    datadir <- "/rstudio-files/ccr-dceg-data/data/Colon_Dataset"
    DCCFiles <- dir(file.path(datadir, "dccs"), pattern = ".dcc$", full.names = TRUE, recursive = TRUE)
    PKCFiles <- "/rstudio-files/ccr-dceg-data/data/Colon_Dataset/pkcs/Hs_R_NGS_WTA_v1.0.pkc"
    SampleAnnotationFile <- dir(file.path(datadir, "annotation"), pattern = ".xlsx$",
                                full.names = TRUE, recursive = TRUE)
    AnnotationSheetName = "SegmentProperties"  
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    datadir <- "/rstudio-files/ccr-dceg-data/data/NSCLC_Dataset"
    DCCFiles <- dir(file.path(datadir, "dccs"), pattern = ".dcc$", full.names = TRUE, recursive = TRUE)
    PKCFiles <- "/rstudio-files/ccr-dceg-data/data/NSCLC_Dataset/pkcs/Hs_R_NGS_WTA_v1.0.pkc"
    SampleAnnotationFile <- dir(file.path(datadir, "annotation"), pattern = ".xlsx$",
                                full.names = TRUE, recursive = TRUE)
    AnnotationSheetName = "Template" 
    
  }
  
  DccColName <- "Sample_ID"
  ProtocolColNames <- c("aoi", "roi")
  ExperimentColNames = c("panel")
  
  return(list("PKCFiles" = PKCFiles, "SampleAnnotationFile" = SampleAnnotationFile, "AnnotationSheetName" = AnnotationSheetName, "DCCFiles" = DCCFiles, "DccColName" = DccColName, "ProtocolColNames" = ProtocolColNames, "ExperimentColNames" = ExperimentColNames))
  
}