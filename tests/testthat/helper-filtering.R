selectDatasetFiltering <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object <- readRDS(test_path("fixtures/Human_Kidney", "qcHumanKidney.RDS"))
    #pkc.file <- "TAP_H_WTA_v1.0.pkc"
    goi <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
    loq.cutoff <- 2
    loq.min <- 2
    cut.segment <- .1
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object <- readRDS(test_path("fixtures/Mouse_Thymus", "qcMouseThymus.RDS"))
    #pkc.file <- "Mm_R_NGS_WTA_v1.0.pkc"
    goi <- c("Plb1", "Ccr7", "Oas2", "Oas1a", "Oas1b", "Rhbdl2", "Dlst", "Naa15", "Rab11a", "Desi1", "Tfdp1", "Foxn1")
    loq.cutoff <- 2
    loq.min <- 2
    cut.segment <- .05
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object <- readRDS(test_path("fixtures/Human_Colon", "qcHumanColon.RDS"))
    #pkc.file <- "Hs_R_NGS_WTA_v1.0.pkc"
    goi <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
    loq.cutoff <- 2
    loq.min <- 2
    cut.segment <- .1
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object <- readRDS(test_path("fixtures/Human_NSCLC", "qcHumanNSCLC.RDS"))
    pkc.file <- "DevCom_H_WTA_v1.0.pkc"
    goi <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
    loq.cutoff <- 2
    loq.min <- 2
    cut.segment <- .1
    
  }
  
  return(list("object" = object, "goi" = goi, "loq.cutoff" = loq.cutoff, "loq.min" = loq.min, "cut.segment" = cut.segment)) #"pkc.file" = pkc.file
  
}
