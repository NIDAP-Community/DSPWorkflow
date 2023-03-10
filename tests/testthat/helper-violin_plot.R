getViolinParam <- function(data) {
  
  if (data == "kidney"){
    
    object = select_normalized_RTD("kidney")
    expr.type = "q_norm"
    genes = c("B2M","SOX9","CD14","EPCAM","KRT19","CD8A","CD4","FOXP3")
    group = "class"
    
  } else if (data == "thymus"){
    
    object = select_normalized_RTD("thymus")
    expr.type = "q_norm"
    genes = c("B2m","Sox9","Cd14","Epcam","Krt19","Cd8a","Cd4","FoxP3")
    group = "class"
    
    
  } else if (data == "colon"){
    
    object = select_normalized_RTD("colon")
    expr.type = "q_norm"
    genes = c("B2M","SOX9","CD14","EPCAM","KRT19","CD8A","CD4","FOXP3")
    group = "class"
    
    
  } else if (data == "nsclc"){
    
    object = select_normalized_RTD("nsclc")
    expr.type = "q_norm"
    genes = c("B2M","SOX9","CD14","EPCAM","KRT19","CD8A","CD4","FOXP3")
    group = "class"
    
  }
  
  return(list("object" = object, 
              "expr.type" = expr.type, 
              "genes" = genes, 
              "group" = group))
  
}
