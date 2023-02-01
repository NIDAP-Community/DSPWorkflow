select_dataset_filtering <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object <- readRDS(test_path("fixtures/Human_Kidney", "qcHumanKidney.RDS"))
    pkcFile <- test_path("fixtures/Human_Kidney", "TAP_H_WTA_v1.0.pkc")
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object <- readRDS(test_path("fixtures/Mouse_Thymus", "qcMouseThymus.RDS"))
    pkcFile <- test_path("fixtures/Mouse_Thymus", "Mm_R_NGS_WTA_v1.0.pkc")
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object <- readRDS(test_path("fixtures/Human_Colon", "qcHumanColon.RDS"))
    pkcFile <- test_path("fixtures/Human_Colon", "Hs_R_NGS_WTA_v1.0.pkc")
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object <- readRDS(test_path("fixtures/Human_NSCLC", "qcHumanNSCLC.RDS"))
    pkcFile <- test_path("fixtures/Human_NSCLC", "Hs_R_NGS_WTA_v1.0.pkc")
    
  }
  
  return(list("object" = object, "pkcFile" = pkcFile))
  
}