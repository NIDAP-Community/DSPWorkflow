select_dataset_violin <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object <- readRDS(test_path("fixtures/Human_Kidney", "normalizationHumanKidney.RDS"))
    test_expr_type = "q_norm"
    test_genes <- c("B2M","SOX9","CD14","EPCAM","KRT19","CD8A","CD4","FOXP3")
    test_group = "class"
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object <- readRDS(test_path("fixtures/Mouse_Thymus", "normalizationMouseThymus.RDS"))
    test_expr_type = "q_norm"
    test_genes <- c("B2m","Sox9","Cd14","Epcam","Krt19","Cd8a","Cd4","FoxP3")
    test_group = "class"
    
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object <- readRDS(test_path("fixtures/Human_Colon", "normalizationHumanColon.RDS"))
    test_expr_type = "q_norm"
    test_genes <- c("B2M","SOX9","CD14","EPCAM","KRT19","CD8A","CD4","FOXP3")
    test_group = "class"
    
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object <- readRDS(test_path("fixtures/Human_NSCLC", "normalizationHumanNSCLC.RDS"))
    test_expr_type = "q_norm"
    test_genes <- c("B2M","SOX9","CD14","EPCAM","KRT19","CD8A","CD4","FOXP3")
    test_group = "class"
    
  }
  
  return(list("object" = object, "test_expr_type" = test_expr_type, "test_genes" = test_genes, "test_group" = test_group))
  
}
