getViolinParam <- function(data) {
  
  if (data == "kidney"){
    
    object = selectNormalizedRtd("kidney")
    expr.type = "q_norm"
    genes = c("B2M","SOX9","CD14","EPCAM","KRT19","CD8A","CD4","FOXP3")
    group = "class"
    
  } else if (data == "thymus"){
    
    object = selectNormalizedRtd("thymus")
    expr.type = "q_norm"
    genes = c("B2m","Sox9","Cd14","Epcam","Krt19","Cd8a","Cd4","Foxp3")
    group = "class"
    
  } else if (data == "colon"){
    
    object = selectNormalizedRtd("colon")
    expr.type = "q_norm"
    genes = c("B2M","SOX9","CD14","EPCAM","KRT19","CD8A","CD4","FOXP3")
    group = "class"
    
  } else if (data == "nsclc"){
    
    object = selectNormalizedRtd("nsclc")
    expr.type = "q_norm"
    genes = c("B2M","SOX9","CD14","EPCAM","KRT19","CD8A","CD4","FOXP3")
    group = "class"
    
  }
  
  return(list("object" = object, 
              "expr.type" = expr.type, 
              "genes" = genes, 
              "group" = group))
  
}

.drawViolinFig <- function(x, width = 10, height = 10){
  path <- tempfile(fileext = ".png")
  ggsave(path, x, width = 10, height = 10)
  print(path)
}
