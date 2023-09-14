####This code derives from the following vignette:
# http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#7_Differential_Expression
# https://rdrr.io/github/Nanostring-Biostats/GeomxTools/src/R/NanoStringGeoMxSet-de.R

#' @title Run a linear mixed model on GeoMxSet
#'
#' @description diffExpr returns a DEG table with fold changes and p-values and 
#'  an image containing 2 tables, one showing the breakdown of number of samples
#'  used in the analysis and a summary table for number of differentially 
#'  expressed genes (DEG) given manually set fold-change and p-value thresholds.  
#'
#' @details This function will run mixedModelDE from the GeoMxTools package.
#'
#' @param object Name of the NanoStringGeoMxSet to perform DE analysis on
#' @param analysis.type Analysis type either "Between Groups" or "Within Groups"
#' @param groups One or more groups of interest (needs to be variables within
#'  group.col)
#' @param group.col Column for group (groups are usually found in different
#'  slides)
#' @param regions One or more regions of interest (needs to be variables within
#'  region.col)
#' @param region.col Column for region (regions are usually found within a
#'  slide)
#' @param slide.col Column for slide name (default is "slide name")
#' @param element assayDataElement of the geoMxSet object to run the DE on
#' @param multi.core Set to TRUE to use multicore, FALSE to run in cluster mode
#'  (default is TRUE)
#' @param n.cores Number of cores to use, set to 1 if running in serial mode
#'  (default is 1)
#' @param p.adjust Method to use for pvalue adjustment. Choices are "holm",
#'  "hochberg","hommel","bonferroni","BH","BY","fdr","none". (default is "BH")
#' @param pairwise Boolean to calculate least-square means pairwise differences
#'  (default is TRUE)
#' @param fc.lim Fold Change limit for summarizing genes of interest (default
#'  is 1.2)
#' @param pval.lim.1 P-value limit for summarizing differentially expressed 
#'  (DEG) genes, usually more stringent (default is 0.05)
#' @param pval.lim.2 P-value limit for summarizing differentially expressed 
#'  (DEG) genes, usually more lenient (default is 0.10)
#'
#' @importFrom GeomxTools mixedModelDE
#' @importFrom patchwork wrap_elements
#' @importFrom stats p.adjust
#' @importFrom dplyr group_by select filter arrange pull
#' @importFrom tidyr pivot_wider
#' @importFrom grid grid.newpage textGrob gpar grobHeight grid.draw
#' @importFrom gtable gtable_add_rows gtable_add_grob
#' @importFrom tibble rownames_to_column
#' @importFrom gridExtra tableGrob ttheme_default
#' @importFrom BiocGenerics rownames colnames rbind
#' @importFrom magrittr %>%
#' @importFrom Biobase pData assayDataElement
#' @importFrom parallel detectCores
#' @export
#'
#' @return a list containing mixed model output data frame, grid tables for
#' samples used in analysis and summary of significant genelists

diffExpr <- function(object,
                     analysis.type,
                     groups,
                     group.col,
                     regions,
                     region.col,
                     slide.col = "slide_name",
                     element = "q_norm",
                     multi.core = TRUE,
                     n.cores = 1,
                     p.adjust = "fdr",
                     pairwise = TRUE,
                     fc.lim = 1.2,
                     pval.lim.1 = 0.05,
                     pval.lim.2 = 0.01) {
  
  ###
  ### Helper functions
  ###
  
  # Alternative function for running liner model when # slide = 1
  # https://github.com/lardenoije/GeomxTools/blob/master/R/modelDE.R
  modelDE <- function (object, elt, modelFormula, groupVar, 
                       nCores, multiCore, pAdjust) 
  {
    if (is.null(modelFormula)) {
      modelFormula <- design(object)
    }
    mTerms <- all.vars(modelFormula)
    if ("1" %in% mTerms) {
      mTerms <- mTerms[which(!(mTerms %in% "1"))]
    }
    if (!groupVar %in% mTerms) {
      stop("Error: groupVar needs to be defined as fixed effect in the model.\n")
    }
    if (any(!mTerms %in% names(sData(object)))) {
      stop("Error: Not all terms in the model formula are in pheno or protocol data.\n")
    }
    pDat <- sData(object)[, mTerms, drop=FALSE]
    for (i in names(pDat)) {
      if (inherits(i, "character")) {
        pDat[, i] <- as.factor(pDat[, i])
      }
    }
    if (nCores > 1) {
      deFunc <- function(i, groupVar, pDat, modelFormula, exprs) {
        dat <- data.frame(expr = exprs$exprs[i, ], pDat)
        lmOut <- suppressWarnings(summary(lm(modelFormula, dat))$coefficients)
        lmOut <- matrix(cbind(lmOut[-1, "Estimate", drop=FALSE], lmOut[-1, "Pr(>|t|)", drop=FALSE]), 
                        ncol = 2, dimnames = list(gsub(groupVar, "", rownames(lmOut)[-1]), 
                                                  c("Estimate", "Pr(>|t|)")))
        return(lmOut)
      }
      exprs <- new.env()
      exprs$exprs <- assayDataElement(object, elt = elt)
      if (multiCore & Sys.info()["sysname"] != "Windows") {
        lmOut <- parallel::mclapply(featureNames(object),
                                    deFunc, groupVar, pDat, 
                                    formula(paste("expr", as.character(modelFormula)[2], sep = " ~ ")),
                                    exprs, mc.cores = nCores)
      }
      else {
        cl <- parallel::makeCluster(getOption("cl.cores", nCores))
        lmOut <- parallel::parLapply(cl, featureNames(object), deFunc, groupVar, pDat, 
                                     formula(paste("expr", as.character(modelFormula)[2], sep = " ~ ")),
                                     exprs)
        suppressWarnings(parallel::stopCluster(cl))
      }
      lmOut <- do.call("rbind", lmOut)
      rownames(lmOut) <- featureNames(object)
    }
    else {
      deFunc <- function(expr, groupVar, pDat, modelFormula) {
        dat <- data.frame(expr = expr, pDat)
        lmOut <- suppressWarnings(summary(lm(modelFormula, dat))$coefficients)
        lmOut <- matrix(cbind(lmOut[-1, "Estimate", drop=FALSE], lmOut[-1, "Pr(>|t|)", drop=FALSE]), 
                        ncol = 2, dimnames = list(gsub(groupVar, "", rownames(lmOut)[-1]), 
                                                  c("Estimate", "Pr(>|t|)")))
        return(lmOut)
      }
      lmOut <- t(assayDataApply(object, 1, deFunc, groupVar, pDat, 
                                formula(paste("expr", as.character(modelFormula)[2], sep = " ~ ")), 
                                elt = elt))
    }
    if (!is.null(pAdjust)) {
      lmOut <- cbind(lmOut, p.adjust(lmOut[, 2], method = pAdjust))
    }
    colnames(lmOut) <- c("Estimate", "Pr(>|t|)", pAdjust)
    return(lmOut)
  }
  
  
  ###
  ### Start of main function
  ###
  
  # Check the number of cores available for the current machine
  available.cores <- detectCores()
  
  # Adjust the number of cores selected within the machine's range
  if (n.cores > available.cores) {
    print(paste0("The number of cores selected is greater than the number of available cores, reducing number of cores to maximum of ", available.cores))
    n.cores <- available.cores
  }
  
  main.group <- sub.group <- Gene <- Subset <- NULL
  
  # convert test variables to factors after checking input
  reg.check <- regions[!regions %in% Biobase::pData(object)[[region.col]]]
  if (length(reg.check) > 0) {
    stop(paste0(reg.check, " is not in region column.\n"))
  }
  
  regions <- regions[regions %in% Biobase::pData(object)[[region.col]]]
  regions <- factor(regions, levels = c(regions[1], regions[2]))
  Biobase::pData(object)$sub.group <-
    factor(Biobase::pData(object)[[region.col]], levels = regions)
  
  grp.check <- groups[!groups %in% Biobase::pData(object)[[group.col]]]
  if (length(grp.check) > 0) {
    stop(paste0(grp.check, " is not in group column.\n"))
  }
  
  groups <- groups[groups %in% Biobase::pData(object)[[group.col]]]
  groups <- factor(groups, levels = c(groups[1], groups[2]))
  Biobase::pData(object)$main.group <-
    factor(Biobase::pData(object)[[group.col]], levels = groups)
  
  Biobase::pData(object)$slide <- factor(Biobase::pData(object)[[slide.col]])
  Biobase::assayDataElement(object = object, elt = element) <-
    assayDataApply(object,
                   2,
                   FUN = log,
                   base = 2,
                   elt = element)
  
  #Test for correct selection of parameter column and/or factors
  ind.na <- colSums(is.na(Biobase::pData(object)))
  param.na <- names(ind.na[ind.na > 0])
  
  if (length(param.na) > 0) {
    if (param.na[1] == "sub.group") {
      regdiff <-
        setdiff(unique(Biobase::pData(object)[[region.col]]),
                unique(levels(Biobase::pData(object)$sub.group)))
      regdiff <- paste0(regdiff, collapse = ", ")
      cat(
        sprintf(
          "At least one of the regions within the Region Column was not selected
            and is excluded: %s\n", regdiff)
      )
    } else if (param.na[1] == "main.group") {
      classdiff <-
        setdiff(unique(Biobase::pData(object)[[group.col]]),
                unique(levels(Biobase::pData(object)$main.group)))
      classdiff <- paste0(classdiff, collapse = ", ")
      cat(
        sprintf(
          "At least one of the groups within the Group Column was not selected and
            is excluded: %s\n", classdiff)
      )
    }
  }
  
  #Print Metadata Pivot Table
  metadata <- Biobase::pData(object) %>% rownames_to_column("sample")
  met.tab <- metadata %>% select(main.group, sub.group, sample, slide) 
  met.sum <- met.tab %>% group_by(main.group, sub.group, slide) %>% count() 
  met.pivot <- met.sum %>% pivot_wider(names_from = slide, values_from = n) 
  #replace str_wrap(colnames(met.pivot), 10) below
  colnames(met.pivot) <- sapply(strsplit(colnames(met.pivot)," "),paste,collapse = "\n")
  ind <- !(is.na(met.pivot$main.group) | is.na(met.pivot$sub.group))
  met.pivot <- met.pivot[ind,]
  grid.newpage()
  gt <- tableGrob(met.pivot, theme = ttheme_default(base_size = 8))
  
  #Check for numbers of groups and regions listed for comparison
  
  reg.col <- unique(Biobase::pData(object)$sub.group)
  reg.length <- length(reg.col[!is.na(reg.col)])
  grp.col <- unique(Biobase::pData(object)$main.group)
  grp.length <- length(grp.col[!is.na(grp.col)])
  
  #Run DEG Analysis
  options(digits = 3)
  
  # Check if the slide has greater than 1 for mixed model
  
  # Reset method flag 
  stat.method <- NULL
  
  if (analysis.type == "Within Groups") {
    cat("Running Within Group Analysis between Regions\n")
    if (reg.length < 2) {
      if ("sub.group" %in% param.na) {
        stop("Cannot run Within Group Analysis with 1 Region.\n")
      }
    }
    title1 <- "DEG lists from within slide contrast:"
    results <- c()
    for (status in groups) {
      ind <- Biobase::pData(object)$main.group == status
      ind[is.na(ind)] <- FALSE
      ind2 <- Biobase::pData(object)$sub.group %in% regions
      ind2[is.na(ind2)] <- FALSE
      #Check to see if there are 2 regions for comparison:
      object.sub <- object[, ind & ind2]
      r <- length(unique(pData(object.sub)$sub.group))
      cat(sprintf("Number of regions in group %s: %s \n", status,r))
      if(r < 2){
        stop("There are not enough sample regions to do the analysis")
      } else {
        
        # Check if there are enough slides for mixed effect model
        slide.list <- unique(pData(object.sub)$slide)
        
        if(length(slide.list) > 1) {
          print("Running DE with linear mixed-effect model")
          
          stat.method <- "mixed-effect model"
          
          mixed.out <- mixedModelDE(
            object.sub,
            elt = element,
            modelFormula = ~ sub.group + (1 + sub.group |
                                            slide),
            groupVar = "sub.group",
            multiCore = multi.core,
            nCores = n.cores,
            pAdjust = p.adjust,
            pairwise = pairwise
          )
        } else {
          print("Running DE with linear model (no mixed-effect)")
          warning("The random effect from slide to slide variance will not be considered.
                  This should only be used for exploratory purposes.")
          
          stat.method <- "linear model"
          
          lm.out <- modelDE(
            object = object.sub, 
            elt = element, 
            modelFormula = ~ sub.group, 
            groupVar = "sub.group", 
            nCores = n.cores, 
            multiCore = multi.core, 
            pAdjust = "fdr"
          )
        }
      }
      
      # Perform formatting specific to analysis type
      if(stat.method == "mixed-effect model") {
        # Formatting specific to the linear mixed model output
        
        # Format results as data.frame
        test.results <- do.call(rbind, mixed.out["lsmeans", ])
        
        # Rename pval column
        colnames(test.results)[2] <- "pval"
        
        # Create a column for contrast
        test.results <- as.data.frame(test.results)
        test.results$Contrast <- paste0(regions[1],"_",regions[2])
        
        # Create a column for gene
        test.results$Gene <-
          unlist(lapply(colnames(mixed.out),
                        rep, nrow(mixed.out["lsmeans", ][[1]])))
        
        # Create a column for the group
        test.results$Subset <- status
        
        # Run FDR multiple test correction
        test.results$FDR <-
          p.adjust(test.results$pval, method = "fdr")
        
        # Reorganize columns of final results
        test.results <-
          test.results[, c("Gene",
                           "Subset",
                           "Contrast",
                           "Estimate",
                           "pval",
                           "FDR")]
        
      } else if(stat.method == "linear model"){
        # Formatting specific to the linear model output (no mixed effect)
        
        # Correct pval and adjpval column name
        colnames(lm.out)[2] <- "pval"
        colnames(lm.out)[3] <- "FDR"
        
        # Correct pval column name and convert to dataframe 
        test.results <- data.frame(lm.out)
        
        # Create a column for contrast
        test.results$Contrast <- paste0(regions[1],"_",regions[2])
        
        # Create a column for gene and remove gene rownames
        test.results$Gene <- row.names(test.results)
        rownames(test.results) <- NULL
        
        # Create a column for the group
        test.results$Subset <- status
        
        # Reorganize columns of final results
        test.results <-
          test.results[, c("Gene",
                           "Subset",
                           "Contrast",
                           "Estimate",
                           "pval",
                           "FDR")]
      } else {
        stop("No valid statistics method was available for the data")
      }

      # Add results of current contrast to overall results
      results <- rbind(results, test.results)
    }
  } else {
    cat("Running Between Group Analysis for Regions\n")
    if (grp.length < 2) {
      if ("main.group" %in% param.na) {
        stop("Cannot run Between Group Analysis with 1 Group.\n")
      }
    }
    title1 <- "DEG lists from Between Slides contrast:"
    results <- c()
    for (region in regions) {
      ind <- Biobase::pData(object)$sub.group == region
      ind[is.na(ind)] <- FALSE
      ind2 <- Biobase::pData(object)$main.group %in% groups
      ind2[is.na(ind2)] <- FALSE
      object.sub <- object[, ind & ind2]
      #Check to see if there are 2 groups for comparison:
      r <- length(unique(pData(object.sub)$main.group))
      cat(sprintf("Number of groups in region %s: %s \n", region, r))
      if(r < 2){
        stop("There are not enough sample groups to do the analysis")
      } else {
        
        print("Running DE with linear mixed-effect model")
        
        stat.method <- "mixed-effect model"
        
        mixed.out <-
          mixedModelDE(
            object.sub,
            elt = element,
            modelFormula = ~ main.group + (1 | slide),
            groupVar = "main.group",
            multiCore = multi.core,
            nCores = n.cores,
            pAdjust = p.adjust,
            pairwise = pairwise
          )
      }
    }
    
    # Perform formatting specific to analysis type
    if(stat.method == "mixed-effect model") {
      # Formatting specific to the linear mixed model output
      
      # Format results as data.frame
      test.results <- do.call(rbind, mixed.out["lsmeans", ])
      
      # Rename pval column
      colnames(test.results)[2] <- "pval"
      
      # Create a column for contrast and remove contrast row names
      test.results <- as.data.frame(test.results)
      test.results$Contrast <- paste0(groups[1],"_",groups[2])
      rownames(test.results) <- NULL
      
      # Create a column for gene
      test.results$Gene <-
        unlist(lapply(colnames(mixed.out),
                      rep, nrow(mixed.out["lsmeans", ][[1]])))
      
      # Create a column for the group
      test.results$Subset <- region
      
      # Run FDR multiple test correction
      test.results$FDR <-
        p.adjust(test.results$pval, method = "fdr")
      
      # Reorganize columns of final results
      test.results <-
        test.results[, c("Gene",
                         "Subset",
                         "Contrast",
                         "Estimate",
                         "pval",
                         "FDR")]
      
    } else if(stat.method == "linear model") {
      # Formatting specific to the linear model output (no mixed effect)
      
      # Correct pval and adjpval column name
      colnames(lm.out)[2] <- "pval"
      colnames(lm.out)[3] <- "FDR"
      
      # Correct pval column name and convert to dataframe 
      test.results <- data.frame(lm.out)
      
      # Create a column for contrast
      test.results$Contrast <- paste0(groups[1],"_",groups[2])
      
      # Create a column for gene and remove gene rownames
      test.results$Gene <- row.names(test.results)
      rownames(test.results) <- NULL
      
      # Create a column for the group
      test.results$Subset <- region
      
      # Reorganize columns of final results
      test.results <-
        test.results[, c("Gene",
                         "Subset",
                         "Contrast",
                         "Estimate",
                         "pval",
                         "FDR")]
    } else {
      stop("No valid statistics method was available for the data")
    }
    
    # Add results of current contrast to overall results
    results <- rbind(results, test.results)
  }
  
  #Change the names of columns for table:
  conname <- gsub(" ", "", unique(results$Contrast))
  logFC.colname <- paste0(conname, "_logFC")
  FC.colname <- paste0(conname, "_FC")
  pval.colname <- paste0(conname, "_pval")
  fdr.colname <- paste0(conname, "_adjpval")
  colnames(results) <-
    sub("pval", pval.colname, colnames(results))
  colnames(results) <-
    sub("Estimate", logFC.colname, colnames(results))
  colnames(results) <- sub("FDR", fdr.colname, colnames(results))
  FC <- 2 ^ (results[[logFC.colname]])
  FC <- ifelse(FC < 1, -1 / FC, FC)
  results[[FC.colname]] <- FC
  results <- results %>%
    select(Gene, Subset, .data[[FC.colname]], .data[[logFC.colname]],
           .data[[pval.colname]], .data[[fdr.colname]])
  results <- results %>%
    arrange(.data[[pval.colname]])
  results[[FC.colname]] <-
    as.numeric(format(results[[FC.colname]], digits = 3))
  results[[logFC.colname]] <-
    as.numeric(format(results[[logFC.colname]], digits = 3))
  results[[pval.colname]] <-
    as.numeric(format(results[[pval.colname]], digits = 3))
  results[[fdr.colname]] <-
    as.numeric(format(results[[fdr.colname]], digits = 3))
  
  #Run Summary Lists:
  .getGeneLists <- function(groups, FClimit, pvallimit, pval) {
    upreggenes <- list()
    downreggenes <- list()
    for (i in 1:length(groups)) {
      if (pval == "pval") {
        upreggenes[[i]] <- results %>%
          dplyr::filter(Subset == groups[i] &
                          .data[[FC.colname]] > FClimit &
                          .data[[pval.colname]] < pvallimit) %>%
          pull(Gene) %>%
          length()
        downreggenes[[i]] <- results %>%
          dplyr::filter(Subset == groups[i] &
                          .data[[FC.colname]] < -FClimit &
                          .data[[pval.colname]] < pvallimit) %>%
          pull(Gene) %>%
          length()
      } else {
        upreggenes[[i]] <- results %>%
          dplyr::filter(Subset == groups[i] &
                          .data[[FC.colname]] > FClimit &
                          .data[[fdr.colname]] < pvallimit) %>%
          pull(Gene) %>%
          length()
        downreggenes[[i]] <- results %>%
          dplyr::filter(Subset == groups[i] &
                          .data[[FC.colname]] < -FClimit &
                          .data[[fdr.colname]] < pvallimit) %>%
          pull(Gene) %>%
          length()
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
  
  .wraplines <- function(y) {
    j = unlist(strsplit(y, "-"))
    k = strwrap(j, width = 10)
    l = paste(k, collapse = "\n-")
    return(l)
  }
  
  # Return summary table of DEG results using different fold change and p-value
  # thresholds:
  .runSummary <- function(select.groups) {
    FCpval1 <-
      .getGeneLists(select.groups,
                    FClimit = fc.lim,
                    pvallimit = pval.lim.1,
                    pval = "pval")
    FCpval2 <-
      .getGeneLists(select.groups,
                    FClimit = fc.lim,
                    pvallimit = pval.lim.2,
                    pval = "pval")
    FCadjpval1 <-
      .getGeneLists(select.groups,
                    FClimit = fc.lim,
                    pvallimit = pval.lim.1,
                    pval = "adjpval")
    FCadjpval2 <-
      .getGeneLists(select.groups,
                    FClimit = fc.lim,
                    pvallimit = pval.lim.2,
                    pval = "adjpval")
    
    pvaltab <- rbind(FCpval1, FCpval2, FCadjpval1, FCadjpval2)
    
    colnames(pvaltab) <-
      sapply(colnames(pvaltab), function(x)
        .wraplines(x))
    
    table <-
      tableGrob(pvaltab, theme = ttheme_default(base_size = 8))
    title2 <- unique(results$Contrast)
    t1 <- textGrob(title1, gp = gpar(fontsize = 15))
    t2 <- textGrob(title2, gp = gpar(fontsize = 15))
    
    padding <- unit(1, "line")
    table <-
      gtable_add_rows(table, heights = grobHeight(t1) + padding, pos = 0)
    table <-
      gtable_add_rows(table, heights = grobHeight(t2) + padding, pos = 0)
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
  
  # Get Summary of significant genes for analysis run and return table 
  if (analysis.type == "Within Groups") {
    summary.table <- .runSummary(select.groups = groups)
  } else {
    summary.table <- .runSummary(select.groups = regions)
  }
  
  #Create image for summary tables:
  g1 <- gt
  g2 <- summary.table
  gg <- wrap_elements(g1) + wrap_elements(g2) +
    plot_layout(ncol = 1, heights = c(0.1, 0.2))
  
  res.list <-
    list("results" = results,
         "tables" = gg)
  return(res.list)
}
