getSpatDeconData <- function(dataset) {
  
  if (dataset == "kidney_w_custom_ref"){
    
    print("selected kidney dataset") 
    object = selectNormalizedRtd("kidney")
    
    expr.type = "q_norm"
    load(test_path("fixtures/Human_Kidney", "Human_Adult_Kidney_HCA.RData"))
    prof.mtx = NULL
    use.custom.prof.mtx = TRUE
    ref.mtx = read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), 
                       row.names=1, check.names=FALSE)
    set.seed(10)
    rownames(ref.mtx) = sample(rownames(object), size = 1500, replace = FALSE)
    ref.annot = read.csv(test_path("fixtures", "ref_annot.csv"))
    ref.annot = ref.annot[match(colnames(ref.mtx), ref.annot$CellID),]
    cell.id.col = "CellID"
    celltype.col = "LabeledCellType"
    
  } else if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object = selectNormalizedRtd("kidney")
    
    expr.type = "q_norm"
    load(test_path("fixtures/Human_Kidney", "Human_Adult_Kidney_HCA.RData"))
    prof.mtx = as.matrix.data.frame(profile_matrix)
    use.custom.prof.mtx = FALSE
    ref.mtx = read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), 
                       row.names=1, check.names=FALSE)
    set.seed(10)
    rownames(ref.mtx) = sample(rownames(object), size = 1500, replace = FALSE)
    ref.annot = read.csv(test_path("fixtures", "ref_annot.csv"))
    ref.annot = ref.annot[match(colnames(ref.mtx), ref.annot$CellID),]
    cell.id.col = "CellID"
    celltype.col = "LabeledCellType"
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object = selectNormalizedRtd("thymus")
    load(test_path("fixtures/Mouse_Thymus", "Mouse_Adult_Thymus_MCA.RData"))
    prof.mtx = as.matrix.data.frame(profile_matrix)
    expr.type = "q_norm"
    use.custom.prof.mtx = FALSE
    ref.mtx = read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), 
                       row.names=1, check.names=FALSE)
    set.seed(11)
    rownames(ref.mtx) = sample(rownames(object), size = 1500, replace = FALSE)
    ref.annot = read.csv(test_path("fixtures", "ref_annot.csv"))
    ref.annot = ref.annot[match(colnames(ref.mtx), ref.annot$CellID),]
    cell.id.col = "CellID"
    celltype.col = "LabeledCellType"
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object = selectNormalizedRtd("colon")
    load(test_path("fixtures/Human_Colon", "Human_Adult_Colon_HCA.RData"))
    prof.mtx = as.matrix.data.frame(profile_matrix)
    expr.type <- "q_norm"
    use.custom.prof.mtx = FALSE
    ref.mtx = read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), 
                       row.names=1, check.names=FALSE)
    set.seed(12)
    rownames(ref.mtx) = sample(rownames(object), size = 1500, replace = FALSE)
    ref.annot = read.csv(test_path("fixtures", "ref_annot.csv"))
    ref.annot = ref.annot[match(colnames(ref.mtx), ref.annot$CellID),]
    cell.id.col = "CellID"
    celltype.col = "LabeledCellType"
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object = selectNormalizedRtd("nsclc")
    load(test_path("fixtures/Human_NSCLC", "Human_Adult_Lung_HCA.RData"))
    prof.mtx = as.matrix.data.frame(profile_matrix)
    expr.type <- "q_norm"
    use.custom.prof.mtx = FALSE
    ref.mtx = read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), 
                       row.names=1, check.names=FALSE)
    set.seed(13)
    rownames(ref.mtx) = sample(rownames(object), size = 1500, replace = FALSE)
    ref.annot = read.csv(test_path("fixtures", "ref_annot.csv"))
    ref.annot = ref.annot[match(colnames(ref.mtx), ref.annot$CellID),]
    cell.id.col = "CellID"
    celltype.col = "LabeledCellType"

  }
  
  return(list("object" = object, 
              "expr.type" = expr.type, 
              "prof.mtx" = prof.mtx,
              "use.custom.prof.mtx" = use.custom.prof.mtx,
              "ref.mtx" = ref.mtx, 
              "ref.annot" = ref.annot,
              "cell.id.col" = cell.id.col, 
              "celltype.col" = celltype.col))
  
}

.drawSpatDeconFig <- function(x, width = 10, height = 10){
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
