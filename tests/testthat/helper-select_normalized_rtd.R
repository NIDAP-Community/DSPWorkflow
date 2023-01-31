select_normalized_RTD <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    inputObject <- readRDS(test_path("fixtures/Human_Kidney", "normalizationHumanKidney.RDS"))
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    inputObject <- readRDS(test_path("fixtures/Mouse_Thymus", "normalizationMouseThymus.RDS"))
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    inputObject <- readRDS(test_path("fixtures/Human_Colon", "normalizationHumanColon.RDS"))
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    inputObject <- readRDS(test_path("fixtures/Human_NSCLC", "normalizationHumanNSCLC.RDS"))
    
  }

  return(inputObject)
  
}