select_dataset_spat_decon <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object <- readRDS(test_path("fixtures/Human_Kidney", "normalizationHumanKidney.RDS"))
    
    # Set parameters and reference datasets
    norm_expr_type <- "q_norm"
    ref_mtx <- read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), row.names=1, check.names=FALSE)
    # For reference matrix, fake rownames with 1500 random genes from object
    rownames(ref_mtx) <- sample(rownames(object), size = 1500, replace = FALSE)
    ref_annot <- read.csv(test_path("fixtures", "ref_annot.csv"))
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object <- readRDS(test_path("fixtures/Mouse_Thymus", "normalizationMouseThymus.RDS"))
    
    # Set parameters and reference datasets
    norm_expr_type <- "q_norm"
    ref_mtx <- read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), row.names=1, check.names=FALSE)
    # For reference matrix, fake rownames with 1500 random genes from object
    rownames(ref_mtx) <- sample(rownames(object), size = 1500, replace = FALSE)
    ref_annot <- read.csv(test_path("fixtures", "ref_annot.csv"))
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object <- readRDS(test_path("fixtures/Human_Colon", "normalizationHumanColon.RDS"))
    
    # Set parameters and reference datasets
    norm_expr_type <- "q_norm"
    ref_mtx <- read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), row.names=1, check.names=FALSE)
    # For reference matrix, fake rownames with 1500 random genes from object
    rownames(ref_mtx) <- sample(rownames(object), size = 1500, replace = FALSE)
    ref_annot <- read.csv(test_path("fixtures", "ref_annot.csv"))
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object <- readRDS(test_path("fixtures/Human_NSCLC", "normalizationHumanNSCLC.RDS"))
    
    # Set parameters and reference datasets
    norm_expr_type <- "q_norm"
    ref_mtx <- read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), row.names=1, check.names=FALSE)
    # For reference matrix, fake rownames with 1500 random genes from object
    rownames(ref_mtx) <- sample(rownames(object), size = 1500, replace = FALSE)
    ref_annot <- read.csv(test_path("fixtures", "ref_annot.csv"))

  }
  
  return(list("object" = object, "norm_expr_type" = norm_expr_type, "ref_mtx" = ref_mtx, "ref_annot" = ref_annot))
  
}
