select_dataset_qc <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object <- readRDS(test_path("fixtures/Human_Kidney", "studyDesignHumanKidney.RDS"))
    minSegmentReads = 1000 
    percentTrimmed = 80  
    percentStitched = 80   
    percentAligned = 75    
    percentSaturation = 50 
    minNegativeCount = 1  
    maxNTCCount = 9000    
    minNuclei = 20      
    minArea = 1000
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object <- readRDS(test_path("fixtures/Mouse_Thymus", "studyDesignMouseThymus.RDS"))
    minSegmentReads = 1000 
    percentTrimmed = 65  
    percentStitched = 65   
    percentAligned = 65    
    percentSaturation = 50 
    minNegativeCount = 10  
    maxNTCCount = 9000    
    minNuclei = 200      
    minArea = 16000
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object <- readRDS(test_path("fixtures/Human_Colon", "studyDesignHumanColon.RDS"))
    minSegmentReads = 1000 
    percentTrimmed = 80  
    percentStitched = 80   
    percentAligned = 80    
    percentSaturation = 50 
    minNegativeCount = 10  
    maxNTCCount = 1000    
    minNuclei = NULL     
    minArea = 16000  
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object <- readRDS(test_path("fixtures/Human_NSCLC", "studyDesignHumanNSCLC.RDS"))
    minSegmentReads = 1000 
    percentTrimmed = 80  
    percentStitched = 80   
    percentAligned = 80    
    percentSaturation = 50 
    minNegativeCount = 10  
    maxNTCCount = NULL    
    minNuclei = NULL      
    minArea = NULL 
    
  }
  
  return(list("object" = object, "minSegmentReads" = minSegmentReads, "percentTrimmed" = percentTrimmed, "percentStitched" = percentStitched, "percentAligned" = percentAligned, "percentSaturation" = percentSaturation, "minNegativeCount" = minNegativeCount, "maxNTCCount" = maxNTCCount, "minNuclei" = minNuclei, "minArea" = minArea))
  
}