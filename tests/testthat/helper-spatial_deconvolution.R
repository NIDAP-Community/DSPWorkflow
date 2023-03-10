getSpatDeconData <- function(dataset) {
  
  if (dataset == "kidney"){
    
    print("selected kidney dataset") 
    object = select_normalized_RTD("kidney")
    
    expr.type = "q_norm"
    ref.mtx = read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), 
                       row.names=1, check.names=FALSE)
    rownames(ref.mtx) = sample(rownames(object), size = 1500, replace = FALSE)
    ref.annot = read.csv(test_path("fixtures", "ref_annot.csv"))
    cell.id.col = "CellID"
    celltype.col = "LabeledCellType"
    
  } else if (dataset == "thymus"){
    
    print("selected thymus dataset")
    object = select_normalized_RTD("thymus")
    
    expr.type = "q_norm"
    ref.mtx = read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), 
                       row.names=1, check.names=FALSE)
    rownames(ref.mtx) = sample(rownames(object), size = 1500, replace = FALSE)
    ref.annot = read.csv(test_path("fixtures", "ref_annot.csv"))
    cell.id.col = "CellID"
    celltype.col = "LabeledCellType"
    
  } else if (dataset == "colon"){
    
    print("selected colon dataset")
    object = select_normalized_RTD("colon")
    
    expr.type <- "q_norm"
    ref.mtx = read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), 
                       row.names=1, check.names=FALSE)
    rownames(ref.mtx) = sample(rownames(object), size = 1500, replace = FALSE)
    ref.annot = read.csv(test_path("fixtures", "ref_annot.csv"))
    cell.id.col = "CellID"
    celltype.col = "LabeledCellType"
    
  } else if (dataset == "nsclc"){
    
    print("selected nsclc dataset")
    object = select_normalized_RTD("nsclc")
    
    expr.type <- "q_norm"
    ref.mtx = read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), 
                       row.names=1, check.names=FALSE)
    rownames(ref.mtx) = sample(rownames(object), size = 1500, replace = FALSE)
    ref.annot = read.csv(test_path("fixtures", "ref_annot.csv"))
    cell.id.col = "CellID"
    celltype.col = "LabeledCellType"

  }
  
  return(list("object" = object, 
              "expr.type" = expr.type, 
              "ref.mtx" = ref.mtx, 
              "ref.annot" = ref.annot,
              "cell.id.col" = cell.id.col, 
              "celltype.col" = celltype.col))
  
}
