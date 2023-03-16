selectDatasetNormalization <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object <- readRDS(test_path("fixtures/Human_Kidney", "filteringHumanKidney.RDS"))
    norm <- "quant"
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object <- readRDS(test_path("fixtures/Mouse_Thymus", "filteringMouseThymus.RDS"))
    norm <- "quant"
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object <- readRDS(test_path("fixtures/Human_Colon", "filteringHumanColon.RDS"))
    norm <- "quant"
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object <- readRDS(test_path("fixtures/Human_NSCLC", "filteringHumanNSCLC.RDS"))
    norm <- "quant"
    
  }
  
  return(list("object" = object, "norm" = norm))
  
}