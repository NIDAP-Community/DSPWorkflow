# Load an RTD object of normalized read data from the test fixtures 
selectNormalizedRtd <- function(dataset) {
  
  # Human kidney diabetes dataset from the vignette
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object <- readRDS(test_path("fixtures/Human_Kidney", 
                                "normalizationHumanKidney.RDS"))
  
  # Mouse thymus cancer dataset from PMID 36049655
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object <- readRDS(test_path("fixtures/Mouse_Thymus", 
                                "normalizationMouseThymus.RDS"))
  
  # Human colon cancer dataset from Nanostring Spatial Organ Atlas
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object <- readRDS(test_path("fixtures/Human_Colon", 
                                "normalizationHumanColon.RDS"))
  
  # Human non-small cell lung carcinoma dataset from PMID 36216799
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object <- readRDS(test_path("fixtures/Human_NSCLC", 
                                "normalizationHumanNSCLC.RDS"))
    
  }

  return(object)
  
}
