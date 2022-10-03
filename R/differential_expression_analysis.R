####This code comes from
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#7_Differential_Expression
#https://rdrr.io/github/Nanostring-Biostats/GeomxTools/src/R/NanoStringGeoMxSet-de.R

#' Run a linear mixed model on GeoMxSet
#'
#' @param object name of the NanoStringGeoMxSet to perform DE analysis on
#' @param element assayDataElement of the geoMxSet object to run the DE on
#' @param analysisType Analysis type either "Between Groups" or "Within Groups"
#' @param regions vector of regions of interest  
#' @param groups vector of groups to compare
#' @param slideCol column for slide name
#' @param classCol column for class
#' @param fclim = 1.2, Fold Change limit for summarizing genes of interest
#' @param nCores = 1, number of cores to use, set to 1 if running in serial mode
#' @param multiCore = TRUE, set to TRUE to use multiCore, FALSE to run in cluster mode
#' @param pAdjust = "BY" method for p-value adjustment
#' @param pairwise boolean to calculate least-square means pairwise differences
#'
#' @import GeomxTools 
#' @import NanoStringNCTools
#' @import Biobase 
#' @importFrom tibble rownames_to_column 
#' @import tidyverse 
#' @import grid
#' @import gtable
#' @importFrom gridExtra tableGrob ttheme_default
#' @import dplyr 
#' @import tidyr
#' @export
#' 
#' @return a list containing mixed model output data frame, grid tables for samples and summary of genelists

DiffExpr <- function(object, element, analysisType, regions, 
                     groups, slideCol, classCol, fclim,
                     multiCore , nCores, pAdjust, pairwise) {
  
  testClass <- testRegion <- slide <- p.adjust <- Gene <- Subset <- Gene <- NULL
  
  # convert test variables to factors
  pData(object)$testRegion <- factor(pData(object)$region, regions)
  pData(object)$slide <- factor(pData(object)[[slideCol]])
  pData(object)$testClass <- factor(pData(object)[[classCol]])
  assayDataElement(object = object, elt = element) <-
    assayDataApply(object, 2, FUN = log, base = 2, elt = "q_norm")
  
  #Print Metadata Pivot Table
  metadata <- pData(object) %>% rownames_to_column("sample")
  metadata %>% select(testClass,testRegion,sample,slide) -> met.tab
  met.tab %>% group_by(testClass,testRegion,slide) %>% count() -> met.sum
  met.sum %>% pivot_wider(names_from= slide,values_from = n) -> met.pivot

  grid.newpage()
  gt <- tableGrob(met.pivot)
  
  #Run DEG Analysis
  options(digits = 9)
  
  if(analysisType == "Within Groups") {
    cat("Running Within Group Analysis between Regions")
    title1 <- "DEG lists from within slide contrast:"
    results <- c()
    for(status in groups) {
      ind <- pData(object)$class == status
      mixedOutmc <- mixedModelDE(object[,ind],
                                 elt = element,
                                 modelFormula = ~ testRegion + (1 + testRegion | slide),
                                 groupVar = "testRegion",
                                 nCores = nCores,
                                 multiCore = multiCore)
      
      # format results as data.frame
      r_test <- do.call(rbind, mixedOutmc["lsmeans", ])
      tests <- rownames(r_test)
      r_test <- as.data.frame(r_test)
      r_test$Contrast <- tests
      r_test$Gene <- 
        unlist(lapply(colnames(mixedOutmc),
                      rep, nrow(mixedOutmc["lsmeans", ][[1]])))
      r_test$Subset <- status
      r_test$FDR <- p.adjust(r_test$`Pr(>|t|)`, method = "fdr")
      r_test <- r_test[, c("Gene", "Subset", "Contrast", "Estimate", 
                           "Pr(>|t|)", "FDR")]
      results <- rbind(results, r_test)
    }
  } else {
    cat("Running Between Group Analysis for Regions")
    title1 <- "DEG lists from Between Slides contrast:"
    # convert test variables to factors
    pData(object)$testClass <- factor(pData(object)$class, groups)
    results <- c()
    for(region in regions) {
      ind <- pData(object)$region == region
      mixedOutmc <-
        mixedModelDE(object[,ind],
                     elt = element,
                     modelFormula = ~ testClass + (1 | slide),
                     groupVar = "testClass",
                     nCores = nCores,
                     multiCore = multiCore)
      
      # format results as data.frame
      r_test <- do.call(rbind, mixedOutmc["lsmeans", ])
      tests <- rownames(r_test)
      r_test <- as.data.frame(r_test)
      r_test$Contrast <- tests
      
      # use lapply in case you have multiple levels of your test factor to
      # correctly associate gene name with it's row in the results table
      r_test$Gene <- 
        unlist(lapply(colnames(mixedOutmc),
                      rep, nrow(mixedOutmc["lsmeans", ][[1]])))
      r_test$Subset <- region
      r_test$FDR <- p.adjust(r_test$`Pr(>|t|)`, method = "fdr")
      r_test <- r_test[, c("Gene", "Subset", "Contrast", "Estimate", 
                           "Pr(>|t|)", "FDR")]
      results <- rbind(results, r_test)
    }
  }

  
  #Change the names of columns for table:
  conname <- gsub(" ","",unique(results$Contrast))
  logFC.colname <- paste0(conname,"_logFC")
  FC.colname <- paste0(conname,"_FC")
  pval.colname <- paste0(conname,"_pval")
  fdr.colname <- paste0(conname,"_adjpval")
  colnames(results) <- sub("Pr\\(>\\|t\\|\\)",pval.colname,colnames(results))
  colnames(results) <- sub("Estimate",logFC.colname,colnames(results))
  colnames(results) <- sub("FDR",fdr.colname,colnames(results))
  FC <- 2^(results[[logFC.colname]])
  FC = ifelse(FC<1,-1/FC,FC)
  results[[FC.colname]] <- FC
  results %>% select(Gene,Subset,.data[[FC.colname]],.data[[logFC.colname]],
                     .data[[pval.colname]],.data[[fdr.colname]]) -> results
  results %>% arrange(.data[[pval.colname]]) -> results
  results[[FC.colname]] <- as.numeric(format(results[[FC.colname]], digits = 3))
  results[[logFC.colname]] <- as.numeric(format(results[[logFC.colname]], digits = 3))
  results[[pval.colname]] <- as.numeric(format(results[[pval.colname]], digits = 3))
  results[[fdr.colname]] <- as.numeric(format(results[[fdr.colname]], digits = 3))
  
  #Run Summary Lists:
  getgenelists <- function(groups,FClimit,pvallimit,pval){
    upreggenes <- list()
    downreggenes <- list()  
    for(i in 1:length(groups)){
      if(pval == "pval"){
        results %>% dplyr::filter(Subset == groups[i] & .data[[FC.colname]] > FClimit & .data[[pval.colname]] < pvallimit) %>% pull(Gene) %>% length() -> upreggenes[[i]] 
        results %>% dplyr::filter(Subset == groups[i] & .data[[FC.colname]] < -FClimit & .data[[pval.colname]] < pvallimit) %>% pull(Gene) %>% length() -> downreggenes[[i]]        
      } else {
        results %>% dplyr::filter(Subset == groups[i] & .data[[FC.colname]] > FClimit & .data[[fdr.colname]] < pvallimit) %>% pull(Gene) %>% length() -> upreggenes[[i]] 
        results %>% dplyr::filter(Subset == groups[i] & .data[[FC.colname]] < -FClimit & .data[[fdr.colname]] < pvallimit) %>% pull(Gene) %>% length() -> downreggenes[[i]] 
      }
    }
    names(upreggenes) <- groups
    names(downreggenes) <- groups
    allreggenes <- rbind(unlist(upreggenes),unlist(downreggenes))
    rownames(allreggenes) <- c(paste0("upreg>",FClimit, ", ",pval,"<",pvallimit),paste0("downreg<-",FClimit, ", ",pval,"<",pvallimit))
    return(allreggenes)
  }

  wraplines <- function(y){
      j = unlist(strsplit(y,"-"))
      k = strwrap(j, width = 10)
      l = paste(k,collapse="\n-")
      return(l)
    }
  
  #Return genelists using different fold change and pvalue thresholds:
  runSummary <- function(selectGroups){
    FCpval1 <- getgenelists(selectGroups,FClimit = fclim, pvallimit = 0.05,"pval")
    FCpval2 <- getgenelists(selectGroups,FClimit = fclim, pvallimit = 0.01,"pval")
    FCadjpval1 <- getgenelists(selectGroups,FClimit = fclim, pvallimit = 0.05,"adjpval")
    FCadjpval2 <- getgenelists(selectGroups,FClimit = fclim, pvallimit = 0.01,"adjpval")
    pvaltab <- rbind(FCpval1,FCpval2,FCadjpval1,FCadjpval2)
    colnames(pvaltab) <- sapply(colnames(pvaltab), function(x) wraplines(x))
    table <- tableGrob(pvaltab, theme=ttheme_default(base_size = 10))
    title2 <- unique(results$Contrast)
    t1 <- textGrob(title1, gp = gpar(fontsize = 15))
    t2 <- textGrob(title2, gp = gpar(fontsize = 15))
    
    padding <- unit(1,"line")
    table <- gtable_add_rows(
      table, heights = grobHeight(t1) + padding, pos = 0.5)
    table <- gtable_add_rows(
      table, heights = grobHeight(t2) + padding, pos = 0.5)
    table <- gtable_add_grob(table, list(t1,t2),
                             t = c(1,2), l = 1, r = ncol(table))
    table$layout$clip <- "off"
    return(table)
  }
  
  if(analysisType == "Within Groups"){
    summary.table <- runSummary(selectGroups = groups)
  } else {
    summary.table <- runSummary(selectGroups = regions)
  }
  
  res.list <- list("results" = results,"sample_table" = gt, "summary_table" = summary.table)
  return(res.list)
}
