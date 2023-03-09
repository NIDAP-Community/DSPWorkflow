selectDatasetSD <- function(dataset) {
  # Human kidney diabetes dataset from the vignette
  if (dataset == "kidney") {
    print("selected kidney dataset")
    
    # Check if dcc files were previously downloaded
    if (!dir.exists("data/kidney/dccs")) {
      
      # Download dcc files and place in data folder
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/kidney_dccs.tar.gz"
      file.name <- "data/kidney_dccs.tar.gz"
      download.file(data.url, file.name)
      untar(file.name, exdir = "data/kidney/")
      
      # Remove the downloaded tar.gz 
      unlink(file.name)
    }
    
    dcc.files <- dir(
      file.path(
        "/data/kidney",
        "dccs"
      ),
      pattern = ".dcc$",
      full.names = TRUE,
      recursive = TRUE
    )
      
    pkc.files <-
      test_path("fixtures/Human_Kidney", "TAP_H_WTA_v1.0.pkc")
    pheno.data.file <-
      "/rstudio-files/ccr-dceg-data/data/Kidney_Dataset/annotation/kidney_AOI_Annotations_all_vignette.xlsx"
    pheno.data.sheet = "Template"
    
    # Mouse thymus cancer dataset from PMID 36049655
  } else if (dataset == "thymus") {
    print("selected thymus dataset")
    
  # Check if dcc files were previously downloaded
    if (!dir.exists("data/thymus/dccs")) {
    
      # Download dcc files and place in data folder
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/thymus_dccs.tar.gz"
      file.name <- "data/thymus_dccs.tar.gz"
      download.file(data.url, file.name)
      untar(file.name, exdir = "data/thymus/")
      
      # Remove the downloaded tar.gz 
      unlink(file.name)
    }
    
    dcc.files <- dir(
      file.path(
        "/data/thymus",
        "dccs"
      ),
      pattern = ".dcc$",
      full.names = TRUE,
      recursive = TRUE
    )
      
    pkc.files <-
      test_path("fixtures/Mouse_Thymus", "Mm_R_NGS_WTA_v1.0.pkc")
    pheno.data.file <-
      "/rstudio-files/ccr-dceg-data/data/Thymus_Dataset/annotations/Thymus_Annotation_updated_3.xlsx"
    pheno.data.sheet = "Annotation"
    
    # Human colon cancer dataset from Nanostring Spatial Organ Atlas
  } else if (dataset == "colon") {
    print("selected colon dataset")
    
    # Check if dcc files were previously downloaded
    if (!dir.exists("data/colon/dccs")) {
      
      # Download dcc files and place in data folder
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/colon_dccs.tar.gz"
      file.name <- "data/colon_dccs.tar.gz"
      download.file(data.url, file.name)
      untar(file.name, exdir = "data/colon/")
      
      # Remove the downloaded tar.gz 
      unlink(file.name)
    }
    
    dcc.files <- dir(
      file.path(
        "/data/colon",
        "dccs"
      ),
      pattern = ".dcc$",
      full.names = TRUE,
      recursive = TRUE
    )
    
    pkc.files <-
      test_path("fixtures/Human_Colon", "Hs_R_NGS_WTA_v1.0.pkc")
    pheno.data.file <- dir(
      file.path(
        "/rstudio-files/ccr-dceg-data/data/Colon_Dataset/",
        "annotation"
      ),
      pattern = ".xlsx$",
      full.names = TRUE,
      recursive = TRUE
    )
    pheno.data.sheet = "SegmentProperties"
    
    # Human non-small cell lung carcinoma dataset from PMID 36216799
  } else if (dataset == "nsclc") {
    print("selected nsclc dataset")
    
    # Check if dcc files were previously downloaded
    if (!dir.exists("data/nsclc/dccs")) {
      
      # Download dcc files into data folder
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/nsclc_dccs.tar.gz"
      file.name <- "data/nsclc_dccs.tar.gz"
      download.file(data.url, file.name)
      untar(file.name, exdir = "data/nsclc/")
      
      # Remove the downloaded tar.gz 
      unlink(file.name)
    } 
    
    dcc.files <- dir(
      file.path(
        "data/nsclc",
        "dccs"
      ),
      pattern = ".dcc$",
      full.names = TRUE,
      recursive = TRUE
    )
    
    pkc.files <-
      test_path("fixtures/Human_NSCLC", "Hs_R_NGS_WTA_v1.0.pkc")
    pheno.data.file <- dir(
      file.path(
        "/rstudio-files/ccr-dceg-data/data/NSCLC_Dataset/",
        "annotation"
      ),
      pattern = ".xlsx$",
      full.names = TRUE,
      recursive = TRUE
    )
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