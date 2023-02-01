select_dataset_sd <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    dccFiles <- dir(file.path("/rstudio-files/ccr-dceg-data/data/WTA_NGS_Example/", "dccs"), pattern = ".dcc$", full.names = TRUE, recursive = TRUE)
    pkcFiles <- "/rstudio-files/ccr-dceg-data/data/Kidney_Dataset/pkcs/TAP_H_WTA_v1.0.pkc"
    phenoDataFile <- "/rstudio-files/ccr-dceg-data/data/WTA_NGS_Example/annotation/kidney_AOI_Annotations_all_vignette.xlsx"
    phenoDataSheet = "Template"
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    dccFiles <- dir(file.path("/rstudio-files/ccr-dceg-data/data/Thymus_Dataset/", "dccs"), pattern = ".dcc$", full.names = TRUE, recursive = TRUE)
    pkcFiles <- "/rstudio-files/ccr-dceg-data/data/Thymus_Dataset/pkcs/Mm_R_NGS_WTA_v1.0.pkc"
    phenoDataFile <- "/rstudio-files/ccr-dceg-data/data/Thymus_Dataset/annotations/Thymus_Annotation_updated_3.xlsx"
    phenoDataSheet = "Annotation"
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    dccFiles <- dir(file.path("/rstudio-files/ccr-dceg-data/data/Colon_Dataset/", "dccs"), pattern = ".dcc$", full.names = TRUE, recursive = TRUE)
    pkcFiles <- "/rstudio-files/ccr-dceg-data/data/Colon_Dataset/pkcs/Hs_R_NGS_WTA_v1.0.pkc"
    phenoDataFile <- dir(file.path("/rstudio-files/ccr-dceg-data/data/Colon_Dataset/", "annotation"), pattern = ".xlsx$",
                                full.names = TRUE, recursive = TRUE)
    phenoDataSheet = "SegmentProperties"  
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    dccFiles <- dir(file.path("/rstudio-files/ccr-dceg-data/data/NSCLC_Dataset/", "dccs"), pattern = ".dcc$", full.names = TRUE, recursive = TRUE)
    pkcFiles <- "/rstudio-files/ccr-dceg-data/data/NSCLC_Dataset/pkcs/Hs_R_NGS_WTA_v1.0.pkc"
    phenoDataFile <- dir(file.path("/rstudio-files/ccr-dceg-data/data/NSCLC_Dataset/", "annotation"), pattern = ".xlsx$",
                                full.names = TRUE, recursive = TRUE)
    phenoDataSheet = "Template" 
    
  }
  
  phenoDataDccColName <- "Sample_ID"
  protocolDataColNames <- c("aoi", "roi")
  experimentDataColNames = c("panel")
  
  return(list("pkcFiles" = pkcFiles, "phenoDataFile" = phenoDataFile, "phenoDataSheet" = phenoDataSheet, "dccFiles" = dccFiles, "phenoDataDccColName" = phenoDataDccColName, "protocolDataColNames" = protocolDataColNames, "experimentDataColNames" = experimentDataColNames))
  
}