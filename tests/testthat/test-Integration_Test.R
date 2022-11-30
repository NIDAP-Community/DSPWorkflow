test_that("DSP object and qc plots are returned", {
  
    datadir <- "/rstudio-files/ccr-dceg-data/data/WTA_NGS_Example" #For Human
    #datadir <- "/rstudio-files/ccr-dceg-data/data/Thymus_Dataset" #For Mouse 
    
    ####################################
    #  Test Study Design:           ####
    ####################################
    
    DCCFiles <- dir(file.path(datadir, "dccs"), pattern = ".dcc$",
                  full.names = TRUE, recursive = TRUE)
    PKCFiles <- unzip(dir(file.path(datadir, "pkcs"), pattern = ".pkc*",
                        full.names = TRUE, recursive = TRUE))
    SampleAnnotationFile <- dir(file.path(datadir, "annotation"), pattern = ".xlsx$",
                              full.names = TRUE, recursive = TRUE)
  
    sdesign.list <- StudyDesign(dccFiles = DCCFiles, 
                                pkcFiles = PKCFiles,
                                phenoDataFile = SampleAnnotationFile)
    
    print(sdesign.list$plot)
    print("Study Design Test Done")
    
    ####################################
    ##     Test QC Preprocessing:   ####
    ####################################
    
    QCoutput <-  QcProc(object = sdesign.list$dsp.obj,
                        minSegmentReads = 1000, # Minimum number of reads (1000)
                        percentTrimmed = 80,    # Minimum % of reads trimmed (80%)
                        percentStitched = 80,   # Minimum % of reads stitched (80%)
                        percentAligned = 75,    # Minimum % of reads aligned (80%)
                        percentSaturation = 50, # Minimum sequencing saturation (50%)
                        minNegativeCount = 1,   # Minimum negative control counts (10)
                        maxNTCCount = 9000,     # Maximum counts observed in NTC well (1000)
                        minNuclei = 20,         # Minimum # of nuclei estimated (100)
                        minArea = 1000)
    print(QCoutput$segments.qc)
    QCoutput$dsp.target
    
    print("QC Processing Test Done")
  
    ####################################
    #####    Test Filtering:        ####
    ####################################
    
    PKFil <- annotation(QCoutput$dsp.target)
    target_demoDataFil <- QCoutput$dsp.target
    demoDataFil <- QCoutput$dsp.target
    
    genes <- c("PDCD1", "CD274", "IFNG", "CD8A", "CD68", "EPCAM", "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
    
    FiltOutput <- filtering(Data = target_demoDataFil, 
                            dsp_obj = demoDataFil, 
                            PKCS = PKFil, 
                            LOQcutoff = 2, 
                            LOQmin = 2, 
                            CutSegment = .1, 
                            GOI = genes)
    
    print(FiltOutput$`Stacked Bar Plot`)
    print(FiltOutput$`Table of Cuts`)
    print(FiltOutput$`Sankey Plot`)
    print(FiltOutput$`Genes Deccted Plot`)
    print(FiltOutput$`target_demoData Dataset`)
    
    print("Filtering Test Done")
    
    ####################################
    ##   Test Normalization:        ###
    ####################################
    
    target_demoDataNorm <- FiltOutput$`target_demoData Dataset`
    
    NormOut.list <- GeoMxNorm(target_demoDataNorm, "quant")
  
    print(NormOut.list$plot)
    print(NormOut.list$boxplot)
    print(NormOut.list$`Normalized Dataframe`)
    
    #Test Unsupervised Analysis:
    target.Data <- NormOut.list$`Normalized Dataframe`
    UnSupervisedoutput <- DimReduct(object = target.Data,
                        point.size = 1,
                        point.alpha = 1,
                        color.variable1 = "region",
                        shape.variable = "class"
    )
    
    print(UnSupervisedoutput$plot.list$PCA)
    print(UnSupervisedoutput$plot.list$tSNE)
    print(UnSupervisedoutput$plot.list$UMAP)
    print(UnSupervisedoutput$dsp.object)
    
    print("Unsupervised Analysis Done")
    
    #######################################
    #Test Clustering CV Genes and Heatmap:#
    #######################################
    
    target.Data <- UnSupervisedoutput$dsp.object  
    
    dsp.list <- HeatMap(target.data = target.Data, 
                        ngenes = 200, 
                        image.width = 3600, 
                        image.height = 1800, 
                        image.resolution = 300, 
                        image.filename = "heatmap.clust.highCVgenes.png",
                        scale.by.row.or.col = "row", 
                        show.rownames = FALSE, 
                        show.colnames = FALSE, 
                        clustering.method = "average", 
                        cluster.rows = TRUE, 
                        cluster.cols = TRUE,
                        clustering.distance.rows = "correlation", 
                        clustering.distance.cols = "correlation", 
                        annotation.row = NA, 
                        annotation.col = pData(target.Data)[, c("class", "segment", "region")], 
                        breaks.by.values = seq(-3, 3, 0.05), 
                        heatmap.color = colorRampPalette(c("blue", "white", "red"))(120), 
                        norm.method = "quant")

    print(dsp.list$plot.genes)
    print(dsp.list$plot)
    
    print("Clustering and heatmap Done")
    
    ########################################
    #Test Differential Expression Analysis:#
    ########################################
    
    
    data <- UnSupervisedoutput$dsp.object 
    goi <- c("CD274", "CD8A", "CD68", "EPCAM",
             "KRT18", "NPHS1", "NPHS2", "CALB1", "CLDN8")
    data <- data[goi,]
    Gene <- Subset <- NULL
    
    #First analysis:
    reslist.1 <- DiffExpr(object = data, 
                          analysisType = "Within Groups",
                          regions = c("glomerulus", "tubule"), 
                          groups = c("DKD", "normal"), 
                          slideCol = "slide name",
                          classCol = "class")
    grid.draw(reslist.1$sample_table)
    grid.newpage()
    grid.draw(reslist.1$summary_table)
    
    lfc_col1 <- colnames(reslist.1$result)[grepl("logFC",colnames(reslist.1$result))]
    pval_col1 <- colnames(reslist.1$result)[grepl("_pval",colnames(reslist.1$result))]
    
    lfc.1 <- reslist.1$result %>% 
                        dplyr::filter(Gene == "CALB1" & Subset == "normal") %>% 
                        select(all_of(lfc_col1)) %>% 
                        as.numeric()
    pval.1 <- reslist.1$result %>% 
                        dplyr::filter(Gene == "CALB1" & Subset == "normal") %>% 
                        select(all_of(pval_col1)) %>% 
                        as.numeric()
    
    expect_equal(lfc.1, -2.014,tolerance=1e-3)
    expect_equal(pval.1, 0.0274,tolerance=1e-3)
    
    #Second analysis:
    reslist.2 <- DiffExpr(object = data, 
                          analysisType = "Between Groups",
                          regions = c("glomerulus", "tubule"), 
                          groups = c("DKD", "normal"), 
                          slideCol = "slide name",
                          classCol = "class")
    grid.draw(reslist.2$sample_table)
    grid.newpage()
    grid.draw(reslist.2$summary_table)
    
    lfc_col2 <- colnames(reslist.2$result)[grepl("logFC",colnames(reslist.2$result))]
    pval_col2 <- colnames(reslist.2$result)[grepl("_pval",colnames(reslist.2$result))]
    
    lfc.2 <- reslist.2$result %>% 
                          dplyr::filter(Gene == "CALB1" & Subset == "tubule") %>% 
                          select(all_of(lfc_col2)) %>% 
                          as.numeric()
    pval.2 <- reslist.2$result %>% 
                          dplyr::filter(Gene == "CALB1" & Subset == "tubule") %>% 
                          select(all_of(pval_col2)) %>% 
                          as.numeric()
    expect_equal(lfc.2, -1.408,tolerance=1e-3)
    expect_equal(pval.2, 0.01268,tolerance=1e-3)
    
    print("Differential Expression Analysis Done")
    
    ####################################
    ##  Test Violin Plot:         ######
    ####################################
    
    test_data <- UnSupervisedoutput$dsp.object
    
    test_genes <- head(rownames(test_data@assayData$q_norm),5)
    
    violin_plot_test <- violin_function(data = test_data, 
                                        genes = test_genes,
                                        group = "region")
    grid.arrange(violin_plot_test)
    
    print("Violin Plot Done")
    
    ####################################
    ## Test Spatial Deconvolution:  ###
    ####################################
    
    #For Mouse Thymus data:
    #load(test_path("fixtures", "target_demoData.RData"))
    #ref_mtx_test <- read.csv("tests/testthat/fixtures/sample_spatial_deconv_mtx.csv", row.names=1, check.names=FALSE)
    #annot_1 = read.csv("tests/testthat/fixtures/ref_annot.csv")
  
    #dsp_qnorm_test = target_demoData@assayData$q_norm
    #dsp_negnorm_test = target_demoData@assayData$neg_norm
    
    #For Human Kidney data:
    refdir <- "/rstudio-files/ccr-dceg-data/data/CellProfileLibrary/Human/Adult/"
    load(paste0(refdir,"Kidney_HCA.RData"))
    ref_mtx_test <- profile_matrix
    annot_1 <- data.frame(CellID = colnames(ref_mtx_test),LabeledCellType = colnames(ref_mtx_test))
    
    target_demoData <- UnSupervisedoutput$dsp.object
    dsp_qnorm_test = target_demoData@assayData$q_norm
    dsp_negnorm_test = target_demoData@assayData$q_norm
    
    #To derive neg probes: 
    target_demoData@featureData@data$TargetName[target_demoData@featureData@data$Negative == TRUE] 
    
    dsp_negnorm_test = derive_GeoMx_background(norm = target_demoData@assayData$q_norm,
                                 probepool = fData(target_demoData)$Module,
                                 negnames = c("NegProbe-WTX"))
    
    invisible(capture.output(res <- spatial_deconvolution(dsp_qnorm = dsp_qnorm_test, 
                                                          dsp_negnorm = dsp_negnorm_test, 
                                                          ref_mtx = ref_mtx_test, ref_annot = annot_1)))
    
    # Heatmap of estimated cell fraction ~ res$beta
    print(heatmap(t(res$beta), cexCol = 0.5, cexRow = 0.7, margins = c(10,7)))
    # Heatmap of cell profile matrix used ~ res$X
    print(heatmap(sweep(res$X, 1, apply(res$X, 1, max), "/"), labRow = NA, margins = c(10, 5)))
    # Abundance Barplot - draws legend in a new page 
    print(TIL_barplot(res$prop_of_all, draw_legend = TRUE, cex.names = 0.3))

    print("Spatial Deconvolution Done")
})

