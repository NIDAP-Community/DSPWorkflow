####This code derives from
#http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#7_Differential_Expression
#https://rdrr.io/github/Nanostring-Biostats/GeomxTools/src/R/NanoStringGeoMxSet-de.R

#' Run a linear mixed model on GeoMxSet
#'
#' @param object Name of the NanoStringGeoMxSet to perform DE analysis on
#' @param analysis.type Analysis type either "Between Groups" or "Within Groups"
#' @param groups One or more groups of interest (needs to be variables within group.col)
#' @param group.col Column for group (groups are usually found in different slides)
#' @param regions One or more regions of interest (needs to be variables within region.col)
#' @param region.col Column for region (regions are usually found within a slide)
#' @param slide.col Column for slide name
#' @param element assayDataElement of the geoMxSet object to run the DE on
#' @param fc.lim Fold Change limit for summarizing genes of interest (default is 1.2)
#' @param n.cores Number of cores to use, set to 1 if running in serial mode (default is 1)
#' @param multi.core Set to TRUE to use multicore, FALSE to run in cluster mode (default is TRUE)
#' @param p.adjust Method to use for pvalue adjustment. Choices are "holm","hochberg","hommel","bonferroni","BH","BY","fdr","none". Default is "BH"
#' @param pairwise Boolean to calculate least-square means pairwise differences (default is NULL)
#'
#' @importFrom GeomxTools mixedModelDE
#' @importFrom stringr str_wrap
#' @importFrom patchwork wrap_elements
#' @importFrom stats p.adjust
#' @importFrom dplyr group_by select filter arrange pull
#' @importFrom tidyr pivot_wider
#' @importFrom grid grid.newpage textGrob gpar grobHeight grid.draw
#' @importFrom gtable gtable_add_rows gtable_add_grob
#' @importFrom tibble rownames_to_column
#' @importFrom gridExtra tableGrob
#' @importFrom BiocGenerics rownames colnames rbind
#' @import NanoStringNCTools
#' @import Biobase
#' @export
#'
#' @return a list containing mixed model output data frame, grid tables for samples and summary of genelists

diffExpr <- function(object,
                     analysis.type,
                     groups,
                     group.col,
                     regions,
                     region.col,
                     slide.col = "slide name",
                     element = "q_norm",
                     multi.core = TRUE,
                     n.cores = 1,
                     p.adjust = "BY",
                     pairwise = NULL,
                     fc.lim = 1.2,
                     pval.lim.1 = 0.05,
                     pval.lim.2 = 0.01) {
  testClass <-
    testRegion <- slide <- p.adjust <- Gene <- Subset <- Gene <- NULL
  
  # convert test variables to factors after checking input
  reg.check <- regions[!regions %in% pData(object)[[region.col]]]
  if (length(reg.check) > 0) {
    stop(paste0(reg.check, " is not in region column.\n"))
  }
  
  regions <- regions[regions %in% pData(object)[[region.col]]]
  regions <- factor(regions, levels = c(regions[1], regions[2]))
  pData(object)$testRegion <-
    factor(pData(object)[[region.col]], levels = regions)
  
  grp.check <- groups[!groups %in% pData(object)[[group.col]]]
  if (length(grp.check) > 0) {
    stop(paste0(grp.check, " is not in group column.\n"))
  }
  
  groups <- groups[groups %in% pData(object)[[group.col]]]
  groups <- factor(groups, levels = c(groups[1], groups[2]))
  pData(object)$testClass <-
    factor(pData(object)[[group.col]], levels = groups)
  
  pData(object)$slide <- factor(pData(object)[[slide.col]])
  assayDataElement(object = object, elt = element) <-
    assayDataApply(object,
                   2,
                   FUN = log,
                   base = 2,
                   elt = element)
  
  #Test for correct selection of parameter columns and/or filling out of factors:
  ind.na <- colSums(is.na(pData(object)))
  param.na <- names(ind.na[ind.na > 0])
  
  if (length(param.na) > 0) {
    if (param.na[1] == "testRegion") {
      regdiff <-
        setdiff(unique(pData(object)[[region.col]]), unique(levels(pData(object)$testRegion)))
      regdiff <- paste0(regdiff,collapse = ", ")
      message(
        paste0(
          "At least one of the regions within the Region Column was not selected and is excluded:\n",
          regdiff,
          "\n"
        )
      )
    }
    else if (param.na[1] == "testClass") {
      classdiff <-
        setdiff(unique(pData(object)[[group.col]]), unique(levels(pData(object)$testClass)))
      classdiff <- paste0(classdiff,collapse = ", ")
      message(
        "At least one of the groups within the Group Column was not selected and is excluded:\n",
        classdiff,
        "\n"
      )
    }
  }
  
  reg.length <-
    length(unique(pData(object)$testRegion)[!is.na(unique(pData(object)$testRegion))]) #has to be 2 for first test
  grp.length <-
    length(unique(pData(object)$testClass)[!is.na(unique(pData(object)$testClass))]) #has to be 2 for second test
  
  #Print Metadata Pivot Table
  metadata <- pData(object) %>% rownames_to_column("sample")
  metadata %>% select(testClass, testRegion, sample, slide) -> met.tab
  met.tab %>% group_by(testClass, testRegion, slide) %>% count() -> met.sum
  met.sum %>% pivot_wider(names_from = slide, values_from = n) -> met.pivot
  colnames(met.pivot) <- str_wrap(colnames(met.pivot), 10)
  ind <- !(is.na(met.pivot$testClass) | is.na(met.pivot$testRegion))
  met.pivot <- met.pivot[ind,]
  grid.newpage()
  gt <- tableGrob(met.pivot, theme = ttheme_default(base_size = 8))
  
  #Run DEG Analysis
  options(digits = 9)
  
  if (analysis.type == "Within Groups") {
    cat("Running Within Group Analysis between Regions")
    if (reg.length < 2) {
      if ("testRegion" %in% param.na) {
        stop("Cannot run Within Group Analysis with 1 Region.\n")
      }
    }
    title1 <- "DEG lists from within slide contrast:"
    results <- c()
    for (status in groups) {
      ind <- pData(object)$testClass == status
      ind[is.na(ind)] <- FALSE
      ind2 <- pData(object)$testRegion %in% regions
      ind2[is.na(ind2)] <- FALSE
      mixedOutmc <- mixedModelDE(
        object[, ind & ind2],
        elt = element,
        modelFormula = ~ testRegion + (1 + testRegion |
                                         slide),
        groupVar = "testRegion",
        multiCore = multi.core,
        nCores = n.cores,
        pAdjust = p.adjust,
        pairwise = pairwise
      )
      
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
      r_test <-
        r_test[, c("Gene",
                   "Subset",
                   "Contrast",
                   "Estimate",
                   "Pr(>|t|)",
                   "FDR")]
      results <- rbind(results, r_test)
    }
  } else {
    cat("Running Between Group Analysis for Regions")
    if (grp.length < 2) {
      if ("testClass" %in% param.na) {
        stop("Cannot run Between Group Analysis with 1 Group.\n")
      }
    }
    title1 <- "DEG lists from Between Slides contrast:"
    results <- c()
    for (region in regions) {
      ind <- pData(object)$testRegion == region
      ind[is.na(ind)] <- FALSE
      ind2 <- pData(object)$testClass %in% groups
      ind2[is.na(ind2)] <- FALSE
      mixedOutmc <-
        mixedModelDE(
          object[, ind & ind2],
          elt = element,
          modelFormula = ~ testClass + (1 | slide),
          groupVar = "testClass",
          multiCore = multi.core,
          nCores = n.cores,
          pAdjust = p.adjust,
          pairwise = pairwise
        )
      
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
      r_test <-
        r_test[, c("Gene",
                   "Subset",
                   "Contrast",
                   "Estimate",
                   "Pr(>|t|)",
                   "FDR")]
      results <- rbind(results, r_test)
    }
  }
  
  
  #Change the names of columns for table:
  conname <- gsub(" ", "", unique(results$Contrast))
  logFC.colname <- paste0(conname, "_logFC")
  FC.colname <- paste0(conname, "_FC")
  pval.colname <- paste0(conname, "_pval")
  fdr.colname <- paste0(conname, "_adjpval")
  colnames(results) <-
    sub("Pr\\(>\\|t\\|\\)", pval.colname, colnames(results))
  colnames(results) <-
    sub("Estimate", logFC.colname, colnames(results))
  colnames(results) <- sub("FDR", fdr.colname, colnames(results))
  FC <- 2 ^ (results[[logFC.colname]])
  FC = ifelse(FC < 1,-1 / FC, FC)
  results[[FC.colname]] <- FC
  results %>% select(Gene, Subset, .data[[FC.colname]], .data[[logFC.colname]],
                     .data[[pval.colname]], .data[[fdr.colname]]) -> results
  results %>% arrange(.data[[pval.colname]]) -> results
  results[[FC.colname]] <-
    as.numeric(format(results[[FC.colname]], digits = 3))
  results[[logFC.colname]] <-
    as.numeric(format(results[[logFC.colname]], digits = 3))
  results[[pval.colname]] <-
    as.numeric(format(results[[pval.colname]], digits = 3))
  results[[fdr.colname]] <-
    as.numeric(format(results[[fdr.colname]], digits = 3))
  
  #Run Summary Lists:
  getgenelists <- function(groups, FClimit, pvallimit, pval) {
    upreggenes <- list()
    downreggenes <- list()
    for (i in 1:length(groups)) {
      if (pval == "pval") {
        results %>% dplyr::filter(Subset == groups[i] &
                                    .data[[FC.colname]] > FClimit &
                                    .data[[pval.colname]] < pvallimit) %>% pull(Gene) %>% length() -> upreggenes[[i]]
        results %>% dplyr::filter(Subset == groups[i] &
                                    .data[[FC.colname]] < -FClimit &
                                    .data[[pval.colname]] < pvallimit) %>% pull(Gene) %>% length() -> downreggenes[[i]]
      } else {
        results %>% dplyr::filter(Subset == groups[i] &
                                    .data[[FC.colname]] > FClimit &
                                    .data[[fdr.colname]] < pvallimit) %>% pull(Gene) %>% length() -> upreggenes[[i]]
        results %>% dplyr::filter(Subset == groups[i] &
                                    .data[[FC.colname]] < -FClimit &
                                    .data[[fdr.colname]] < pvallimit) %>% pull(Gene) %>% length() -> downreggenes[[i]]
      }
    }
    names(upreggenes) <- groups
    names(downreggenes) <- groups
    allreggenes <- rbind(unlist(upreggenes), unlist(downreggenes))
    rownames(allreggenes) <-
      c(
        paste0("upreg>", FClimit, ", ", pval, "<", pvallimit),
        paste0("downreg<-", FClimit, ", ", pval, "<", pvallimit)
      )
    return(allreggenes)
  }
  
  wraplines <- function(y) {
    j = unlist(strsplit(y, "-"))
    k = strwrap(j, width = 10)
    l = paste(k, collapse = "\n-")
    return(l)
  }
  
  #Return summary table of DEG results using different fold change and pvalue thresholds:
  runSummary <- function(selectGroups) {
    FCpval1 <-
      getgenelists(selectGroups,
                   FClimit = fc.lim,
                   pvallimit = pval.lim.1,
                   "pval")
    FCpval2 <-
      getgenelists(selectGroups,
                   FClimit = fc.lim,
                   pvallimit = pval.lim.2,
                   "pval")
    FCadjpval1 <-
      getgenelists(selectGroups,
                   FClimit = fc.lim,
                   pvallimit = pval.lim.1,
                   "adjpval")
    FCadjpval2 <-
      getgenelists(selectGroups,
                   FClimit = fc.lim,
                   pvallimit = pval.lim.2,
                   "adjpval")
    pvaltab <- rbind(FCpval1, FCpval2, FCadjpval1, FCadjpval2)
    colnames(pvaltab) <-
      sapply(colnames(pvaltab), function(x)
        wraplines(x))
    table <-
      tableGrob(pvaltab, theme = ttheme_default(base_size = 8))
    title2 <- unique(results$Contrast)
    t1 <- textGrob(title1, gp = gpar(fontsize = 15))
    t2 <- textGrob(title2, gp = gpar(fontsize = 15))
    
    padding <- unit(1, "line")
    table <-
      gtable_add_rows(table, heights = grobHeight(t1) + padding, pos = 0.5)
    table <-
      gtable_add_rows(table, heights = grobHeight(t2) + padding, pos = 0.5)
    table <- gtable_add_grob(
      table,
      list(t1, t2),
      t = c(1, 2),
      l = 1,
      r = ncol(table)
    )
    table$layout$clip <- "off"
    
    return(table)
  }
  
  if (analysis.type == "Within Groups") {
    summary.table <- runSummary(selectGroups = groups)
  } else {
    summary.table <- runSummary(selectGroups = regions)
  }
  
  #Create image for tables:
  g1 <- gt
  g2 <- summary.table
  gg <- wrap_elements(g1) + wrap_elements(g2) +
      plot_layout(ncol = 1, heights = c(0.1, 0.2))
  
  res.list <-
    list(
      "results" = results,
      "tables" = gg
    )
  return(res.list)
}
