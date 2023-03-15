selectDatasetSD <- function(dataset) {
  # Human kidney diabetes dataset from the vignette
  if (dataset == "kidney") {
    print("selected kidney dataset")
    
    tar.file.path <- "fixtures/Human_Kidney/downloaded/kidney_dccs.tar.gz"
    
    # Check if dcc files were previously downloaded
    if (!file.exists(tar.file.path)) {
      
      # Download dcc files and place in data folder
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/kidney_dccs.tar.gz"
      download.file(data.url, tar.file.path)
      untar(tar.file.path, exdir = "fixtures/Human_Kidney/downloaded/")

    }
    
    dcc.files <- dir(
      file.path(
        "fixtures/Human_Kidney/downloaded",
        "dccs"
      ),
      pattern = ".dcc$",
      full.names = TRUE,
      recursive = TRUE
    )
      
    pkc.files <-
      test_path("fixtures/Human_Kidney", "TAP_H_WTA_v1.0.pkc")
    pheno.data.file <-
      "fixtures/Human_Kidney/kidney_annotations.xlsx"
    pheno.data.sheet = "Template"
    
    
    # Mouse thymus cancer dataset from PMID 36049655
  } else if (dataset == "thymus") {
    print("selected thymus dataset")
    
    tar.file.path <- "fixtures/Mouse_Thymus/downloaded/thymus_dccs.tar.gz"
    
    # Check if dcc files were previously downloaded
    if (!file.exists(tar.file.path)) {
      
      # Download dcc files and place in data folder
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/thymus_dccs.tar.gz"
      download.file(data.url, tar.file.path)
      untar(tar.file.path, exdir = "fixtures/Mouse_Thymus/downloaded/")
      
    }
    
    dcc.files <- dir(
      file.path(
        "fixtures/Mouse_Thymus/downloaded",
        "dccs"
      ),
      pattern = ".dcc$",
      full.names = TRUE,
      recursive = TRUE
    )
      
    pkc.files <-
      test_path("fixtures/Mouse_Thymus", "Mm_R_NGS_WTA_v1.0.pkc")
    pheno.data.file <-
      "fixtures/Mouse_Thymus/Thymus_Annotation_updated_3.xlsx"
    pheno.data.sheet = "Annotation"
    
    # Human colon cancer dataset from Nanostring Spatial Organ Atlas
  } else if (dataset == "colon") {
    print("selected colon dataset")
    
    tar.file.path <- "fixtures/Human_Colon/downloaded/colon_dccs.tar.gz"
    
    # Check if dcc files were previously downloaded
    if (!file.exists(tar.file.path)) {
      
      # Download dcc files and place in data folder
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/colon_dccs.tar.gz"
      download.file(data.url, tar.file.path)
      untar(tar.file.path, exdir = "fixtures/Human_Colon/downloaded/")
      
    }
    
    dcc.files <- dir(
      file.path(
        "fixtures/Human_Colon/downloaded",
        "dccs"
      ),
      pattern = ".dcc$",
      full.names = TRUE,
      recursive = TRUE
    )
    
    pkc.files <-
      test_path("fixtures/Human_Colon", "Hs_R_NGS_WTA_v1.0.pkc")
    pheno.data.file <- "fixtures/Human_Colon/colon_soa_annotation.xlsx"
    pheno.data.sheet = "SegmentProperties"
    
    # Human non-small cell lung carcinoma dataset from PMID 36216799
  } else if (dataset == "nsclc") {
    print("selected nsclc dataset")
    
    tar.file.path <- "fixtures/Human_NSCLC/downloaded/nsclc_dccs.tar.gz"
    
    # Check if dcc files were previously downloaded
    if (!file.exists(tar.file.path)) {
      
      # Download dcc files and place in data folder
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/nsclc_dccs.tar.gz"
      download.file(data.url, tar.file.path)
      untar(tar.file.path, exdir = "fixtures/Human_NSCLC/downloaded/")
      
    }
    
    dcc.files <- dir(
      file.path(
        "fixtures/Human_NSCLC/downloaded",
        "dccs"
      ),
      pattern = ".dcc$",
      full.names = TRUE,
      recursive = TRUE
    )
    
    pkc.files <-
      test_path("fixtures/Human_NSCLC", "Hs_R_NGS_WTA_v1.0.pkc")
    pheno.data.file <- "fixtures/Human_NSCLC/NSCLC_annotation.xlsx"
    pheno.data.sheet = "Template"
    
  }
  
  # Additional fields with no dataset-specific values
  pheno.data.dcc.col.name <- "Sample_ID"
  protocol.data.col.names <- c("aoi", "roi")
  experiment.data.col.names = c("panel")
  
  return(
    list(
      "pkc.files" = pkc.files,
      "pheno.data.file" = pheno.data.file,
      "pheno.data.sheet" = pheno.data.sheet,
      "dcc.files" = dcc.files,
      "pheno.data.dcc.col.name" = pheno.data.dcc.col.name,
      "protocol.data.col.names" = protocol.data.col.names,
      "experiment.data.col.names" = experiment.data.col.names
    )
  )
  
}