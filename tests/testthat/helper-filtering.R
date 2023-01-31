select_dataset_filtering <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object <- readRDS(test_path("fixtures/Human_Kidney", "qcHumanKidney.RDS"))
    pkcFile <- "/rstudio-files/ccr-dceg-data/data/Kidney_Dataset/pkcs/TAP_H_WTA_v1.0.pkc"
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object <- readRDS(test_path("fixtures/Mouse_Thymus", "qcMouseThymus.RDS"))
    pkcFile <- "/rstudio-files/ccr-dceg-data/data/Thymus_Dataset/pkcs/Mm_R_NGS_WTA_v1.0.pkc"
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object <- readRDS(test_path("fixtures/Human_Colon", "qcHumanColon.RDS"))
    pkcFile <- "/rstudio-files/ccr-dceg-data/data/Colon_Dataset/pkcs/Hs_R_NGS_WTA_v1.0.pkc"
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object <- readRDS(test_path("fixtures/Human_NSCLC", "qcHumanNSCLC.RDS"))
    pkcFile <- "/rstudio-files/ccr-dceg-data/data/NSCLC_Dataset/pkcs/Hs_R_NGS_WTA_v1.0.pkc"
    
  }
  
  return(list("object" = object, "pkcFile" = pkcFile))
  
}