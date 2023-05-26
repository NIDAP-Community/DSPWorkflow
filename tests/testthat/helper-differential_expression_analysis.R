getDeParams <- function(data, test) {
  if (data == "kidney") {
    object <- selectNormalizedRtd("kidney")
    groups = c("DKD", "normal")
    group.col = "class"
    regions = c("glomerulus", "tubule")
    region.col = "region"
    slide.col = "slide_name"
    n.cores = 16
    if (test == "Within") {
      analysis.type = "Within Groups"
    } else {
      analysis.type = "Between Groups"
    }
  } else if (data == "thymus") {
    object <- selectNormalizedRtd("thymus")
    slide.col = "slide_name"
    n.cores = 4
    if (test == "Within") {
      analysis.type = "Within Groups"
      groups = c("Thymus")
      group.col = "class"
      regions = c("Cortical", "Medullar")
      region.col = "region"
    } else {
      analysis.type <- "Between Groups"
      groups <- c("Tumor", "Medullar")
      group.col = "region"
      regions = c("PanCK")
      region.col = "segment"
    }
  } else if (data == "colon") {
    object <- selectNormalizedRtd("colon")
    slide.col = "slide_name"
    n.cores = 4
    if (test == "Within") {
      analysis.type = "Within Groups"
      region.col = "segment"
      regions = c("PanCK+", "PanCK-")
      groups = "Lamina"
      group.col = "region"
    } else{
      analysis.type = "Between Groups"
      region.col = "class"
      regions = "colon"
      group.col = "region"
      groups = c("Lymphoid", "Lamina")
    }
  } else if (data == "nsclc") {
    object <- selectNormalizedRtd("nsclc")
    slide.col = "slide_name"
    n.cores = 4
    if (test == "Within") {
      analysis.type = "Within Groups"
      region.col = "segment"
      regions = c("tumor", "TME")
      group.col = "class"
      groups = "cancer"
    } else {
      analysis.type = "Between Groups"
      region.col = "region"
      regions = "brain"
      group.col = "segment"
      groups = c("TME", "control")
    }
  }
  return(
    list(
      "object" = object,
      "analysis.type" = analysis.type,
      "groups" = groups,
      "group.col" = group.col,
      "regions" = regions,
      "region.col" = region.col,
      "slide.col" = slide.col,
      "n.cores" = n.cores
    )
  )
}


getSubset <- function(data, test) {
  if (data == "kidney") {
    dataset <- getDeParams("kidney", test)
    goi <- c("CD274",
             "CD8A",
             "CD68",
             "EPCAM",
             "KRT18",
             "NPHS1",
             "NPHS2",
             "CALB1",
             "CLDN8")
    dataset$object <- dataset$object[goi, ]
    
  } else if (data == "thymus") {
    dataset <- getDeParams("thymus", test)
    goi <-
      c(
        "Plb1",
        "Ccr7",
        "Oas2",
        "Oas1a",
        "Oas1b",
        "Rhbdl2",
        "Dlst",
        "Naa15",
        "Rab11a",
        "Desi1",
        "Tfdp1",
        "Foxn1"
      )
    dataset$object <- dataset$object[goi, ]
    
  } else if (data == "colon") {
    dataset <- getDeParams("colon", test)
    goi <- c(
      "IGHA1",
      "JCHAIN",
      "IGKC",
      "IGLL5",
      "PIGR",
      "CCL8",
      "CD37",
      "CXCL13",
      "MS4A1",
      "CCL19",
      "CCL21"
    )
    dataset$object <- dataset$object[goi, ]
    
  } else if (data == "nsclc") {
    dataset <- getDeParams("nsclc", test)
    goi <-
      c("ALDOC",
        "NCAM1",
        "SNAP25",
        "VIM",
        "COL3A1",
        "COL1A1",
        "COL4A1",
        "FN1")
    dataset$object <- dataset$object[goi, ]
    
  }
  return(dataset)
}


calcFC <- function(data, result, test) {
  lfc.col <- colnames(result)[grepl("logFC", colnames(result))]
  pval.col <- colnames(result)[grepl("_pval", colnames(result))]
  
  if (data == "kidney") {
    if (test == "Within") {
      lfc <- result %>%
        dplyr::filter(Gene == "CALB1" &
                        Subset == "normal") %>%
        pull(lfc.col) %>%
        as.numeric()
      pval <- result %>%
        dplyr::filter(Gene == "CALB1" &
                        Subset == "normal") %>%
        pull(pval.col) %>%
        as.numeric()
    } else{
      lfc <- result %>%
        dplyr::filter(Gene == "CALB1" &
                        Subset == "tubule") %>%
        pull(lfc.col) %>%
        as.numeric()
      pval <- result %>%
        dplyr::filter(Gene == "CALB1" &
                        Subset == "tubule") %>%
        pull(pval.col) %>%
        as.numeric()
    }
  } else if (data == "thymus") {
    if (test == "Within") {
      lfc <- result %>%
        dplyr::filter(Gene == "Ccr7" &
                        Subset == "Thymus") %>%
        pull(lfc.col) %>%
        as.numeric()
      pval <- result %>%
        dplyr::filter(Gene == "Ccr7" &
                        Subset == "Thymus") %>%
        pull(pval.col) %>%
        as.numeric()
    } else{
      lfc <- result %>%
        dplyr::filter(Gene == "Ccr7" &
                        Subset == "PanCK") %>%
        pull(lfc.col) %>% as.numeric()
      pval <- result %>%
        dplyr::filter(Gene == "Ccr7" &
                        Subset == "PanCK") %>%
        pull(pval.col) %>% as.numeric()
    }
  } else if (data == "colon") {
    if (test == "Within") {
      lfc <- result %>%
        dplyr::filter(Gene == "JCHAIN" &
                        Subset == "Lamina") %>%
        pull(lfc.col) %>%
        as.numeric()
      pval <- result %>%
        dplyr::filter(Gene == "JCHAIN" &
                        Subset == "Lamina")  %>%
        pull(pval.col) %>%
        as.numeric()
    } else{
      lfc <- result %>%
        dplyr::filter(Gene == "JCHAIN" &
                        Subset == "colon") %>%
        pull(lfc.col) %>%
        as.numeric()
      pval <- result %>%
        dplyr::filter(Gene == "JCHAIN" &
                        Subset == "colon") %>%
        pull(pval.col) %>%
        as.numeric()
    }
  } else if (data == "nsclc") {
    if (test == "Within") {
      lfc <- result %>%
        dplyr::filter(Gene == "VIM" &
                        Subset == "cancer") %>%
        pull(lfc.col) %>%
        as.numeric()
      pval <- result %>%
        dplyr::filter(Gene == "VIM" &
                        Subset == "cancer")  %>%
        pull(pval.col) %>%
        as.numeric()
    } else{
      lfc <- result %>%
        dplyr::filter(Gene == "VIM" &
                        Subset == "brain") %>%
        pull(lfc.col) %>%
        as.numeric()
      pval <- result %>%
        dplyr::filter(Gene == "VIM" &
                        Subset == "brain") %>%
        pull(pval.col) %>%
        as.numeric()
    }
  }
  return(list("lfc" = lfc , "pval" = pval))
}

.drawpng <- function(x, width = 8, height = 6){
  path <- tempfile(fileext = ".png")
  png(path,
      width=width,
      height=height,
      units = "in",
      res = 400
  )
  on.exit(dev.off())
  print(x)
  path
}
