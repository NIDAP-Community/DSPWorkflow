
get_de_params <- function(data,test){
  
  if(data == "kidney") {
    object <- select_normalized_RTD("kidney")
    groups = c("DKD", "normal") 
    groupCol = "class"
    regions = c("glomerulus", "tubule")
    regionCol = "region"
    slideCol = "slide name"
    nCores = 4
    if(test == "Within"){
      analysisType = "Within Groups"
    } else {
      analysisType = "Between Groups"
    }
  } else if (data == "thymus") {
      object <- select_normalized_RTD("thymus")
      slideCol = "slide name"
      nCores = 4
      if(test == "Within"){
        analysisType = "Within Groups"
        groups = c("Thymus") 
        groupCol = "class"
        regions = c("Cortical", "Medullar")
        regionCol = "region"
      } else {
        analysisType <- "Between Groups"
        groups <- c("Tumor", "Medullar")
        groupCol = "region"
        regions = c("PanCK")
        regionCol = "segment"
      }
  } else if(data == "colon"){
      object <- select_normalized_RTD("colon")
      slideCol = "slide name"
      nCores = 4
      if(test == "Within"){
          analysisType = "Within Groups" 
          regionCol = "segment" 
          regions = c("PanCK+", "PanCK-") 
          groups = "Lamina"
          groupCol = "region" 
      } else{
          analysisType = "Between Groups"
          regionCol = "class" 
          regions = "colon"
          groupCol = "region"
          groups = c("Lymphoid", "Lamina")
    }
  } else if(data == "nsclc"){
      object <- select_normalized_RTD("nsclc")
      slideCol = "slide name"
      nCores = 4
    if(test == "Within"){
        analysisType = "Within Groups" 
        regionCol = "segment"
        regions = c("tumor", "TME") 
        groupCol = "class"
        groups = "cancer" 
    } else {
        analysisType = "Between Groups" 
        regionCol = "region" 
        regions = "brain"
        groupCol = "segment" 
        groups = c("TME", "control") 
    }
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


getsubset <- function(data,test){
    if(data == "kidney"){
    
    dataset <- get_de_params("kidney",test)
    goi <- c("CD274", "CD8A", "CD68", "EPCAM",
             "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
    dataset$object <- dataset$object[goi,]
    
    } else if(data == "thymus"){
    
    dataset <- get_de_params("thymus",test)
    goi <- c("Plb1", "Ccr7", "Oas2", "Oas1a", "Oas1b", "Rhbdl2", "Dlst", 
             "Naa15", "Rab11a", "Desi1", "Tfdp1", "Foxn1")
    dataset$object <- dataset$object[goi,]
  
    } else if(data == "colon"){
    
    dataset <- get_de_params("colon",test) 
    goi <- c("IGHA1", "JCHAIN", "IGKC", "IGLL5", "PIGR", 
             "CCL8", "CD37", "CXCL13", "MS4A1", "CCL19", "CCL21")
    dataset$object <- dataset$object[goi,]
  
    } else if(data == "nsclc"){
    
    dataset <- get_de_params("nsclc",test) 
    goi <- c("ALDOC", "NCAM1", "SNAP25", "VIM", "COL3A1", "COL1A1", 
                "COL4A1", "FN1")
    dataset$object <- dataset$object[goi,]
  
    }
  return(dataset)
}

saveplots <- function(data,file,w){
    g1 <- data$sample_table
    g2 <- data$summary_table
    gg <- wrap_elements(g1) + wrap_elements(g2) + 
      plot_layout(ncol = 1, heights = c(0.1, 0.2))
    ggsave(file,gg, width = w, height = 10)
}

calcfc <- function(data, result, test){
  
  lfc_col <- colnames(result)[grepl("logFC",colnames(result))]
  pval_col <- colnames(result)[grepl("_pval",colnames(result))]
  
  if(data == "kidney"){
    
    if(test == "Within"){
      lfc <- result %>% dplyr::filter(Gene == "CALB1" & Subset == "normal") %>% pull(lfc_col) %>% as.numeric()
      pval <- result %>% dplyr::filter(Gene == "CALB1" & Subset == "normal") %>% pull(pval_col) %>% as.numeric()
    }else{
      lfc <- result %>% dplyr::filter(Gene == "CALB1" & Subset == "tubule") %>% pull(lfc_col) %>% as.numeric()
      pval <- result %>% dplyr::filter(Gene == "CALB1" & Subset == "tubule") %>% pull(pval_col) %>% as.numeric()
    }
  } else if(data == "thymus"){
    
    if(test == "Within"){
      lfc <- result %>% dplyr::filter(Gene == "Ccr7" & Subset == "Thymus") %>% pull(lfc_col) %>% as.numeric()
      pval <- result %>% dplyr::filter(Gene == "Ccr7" & Subset == "Thymus") %>% pull(pval_col) %>% as.numeric()
    } else{
      lfc <- result %>% dplyr::filter(Gene == "Ccr7" & Subset == "PanCK") %>% pull(lfc_col) %>% as.numeric()
      pval <- result %>% dplyr::filter(Gene == "Ccr7" & Subset == "PanCK") %>% pull(pval_col) %>% as.numeric()
    }
  } else if(data == "colon"){
    
    if(test == "Within"){
      lfc <- result %>% dplyr::filter(Gene == "JCHAIN" & Subset == "Lamina") %>% pull(lfc_col) %>% as.numeric()
      pval <- result %>% dplyr::filter(Gene == "JCHAIN" & Subset == "Lamina")  %>% pull(pval_col) %>% as.numeric()
    } else{
      lfc <- result %>% dplyr::filter(Gene == "JCHAIN" & Subset == "colon") %>% pull(lfc_col) %>% as.numeric()
      pval <- result %>% dplyr::filter(Gene == "JCHAIN" & Subset == "colon") %>% pull(pval_col) %>% as.numeric()
    }
  } else if(data == "nsclc"){
    
    if(test == "Within"){
      lfc <- result %>% dplyr::filter(Gene == "VIM" & Subset == "cancer") %>% pull(lfc_col) %>% as.numeric()
      pval <- result %>% dplyr::filter(Gene == "VIM" & Subset == "cancer")  %>% pull(pval_col) %>% as.numeric()
    } else{
      lfc <- result %>% dplyr::filter(Gene == "VIM" & Subset == "brain") %>% pull(lfc_col) %>% as.numeric()
      pval <- result %>% dplyr::filter(Gene == "VIM" & Subset == "brain") %>% pull(pval_col) %>% as.numeric()
    }
  }
  return(list("lfc" = lfc ,"pval" = pval))
}