
get_de_params <- function(data){
  
  if(data == "kidney") {
    object <- select_normalized_RTD("kidney")
    analysisType = "Within Groups"
    groups = c("DKD", "normal") 
    groupCol = "class"
    regions = c("glomerulus", "tubule")
    regionCol = "region"
    slideCol = "slide name"
    nCores = 4
  } else if(data == "thymus") {
    object <- select_normalized_RTD("thymus")
    analysisType = "Within Groups"
    groups = c("Thymus") 
    groupCol = "class"
    regions = c("Cortical", "Medullar")
    regionCol = "region"
    slideCol = "slide name"
    nCores = 4
  } 
  
 
  return(list("object" = object,
              "analysisType" = analysisType,
              "groups" = groups,
              "groupCol" = groupCol,
              "regions" = regions,
              "regionCol" = regionCol,
              "slideCol" = slideCol,
              "nCores" = nCores)) 
  
}