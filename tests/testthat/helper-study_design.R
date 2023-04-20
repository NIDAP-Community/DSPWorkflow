# Error checking for DCC file download
downloadDccs <- function(input.url, output.folder, tar.file) {
  
  output.path <- paste0(output.folder, tar.file)
  
  # The number of times to try the download until success
  num.tries <- 5
  
  for (i in 1:num.tries) {
    
    # Wait 30 seconds for the next download attempt
    if (i > 1) {
      print("Waiting 30 seconds until next download attempt...")
      Sys.sleep(30)
    }
    
    # Check if output directory exists
    if (dir.exists(output.folder) == FALSE){
      print(paste0("Could not find directory ", output.folder, ", download will not proceed..."))
      break
    }
    
    print(paste("Starting download attempt ", i))
    
    if (i == 5) {
      print("Final download attempt...")
    }
    result <- try({
      download.file(input.url, output.path)
      untar(output.path, exdir = output.folder)
    })
    if (class(result) != "try-error") {
      print(paste("Files downloaded to", output.folder))
      break
    }
  }
}

selectDatasetSD <- function(dataset) {
  # Human kidney diabetes dataset from the vignette
  if (dataset == "kidney") {
    print("selected kidney dataset")
    
    downloaded.folder <- "fixtures/Human_Kidney/downloaded/"
    tar.file.name <- "kidney_dccs.tar.gz"
    tar.file.path <- paste0(downloaded.folder, tar.file.name)
    
    # Check if dcc files were previously downloaded
    if (!file.exists(tar.file.path)) {
      
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/kidney_dccs.tar.gz"
      # Download dcc files and place in data folder
      downloadDccs(input.url = data.url, 
                   output.folder = downloaded.folder, 
                   tar.file = tar.file.name)
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
    
    downloaded.folder <- "fixtures/Mouse_Thymus/downloaded/"
    tar.file.name <- "thymus_dccs.tar.gz"
    tar.file.path <- paste0(downloaded.folder, tar.file.name)
    
    # Check if dcc files were previously downloaded
    if (!file.exists(tar.file.path)) {
      
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/thymus_dccs.tar.gz"
      # Download dcc files and place in data folder
      downloadDccs(input.url = data.url, 
                   output.folder = downloaded.folder, 
                   tar.file = tar.file.name)
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
    
    downloaded.folder <- "fixtures/Human_Colon/downloaded/"
    tar.file.name <- "colon_dccs.tar.gz"
    tar.file.path <- paste0(downloaded.folder, tar.file.name)
    
    # Check if dcc files were previously downloaded
    if (!file.exists(tar.file.path)) {
      
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/colon_dccs.tar.gz"
      # Download dcc files and place in data folder
      downloadDccs(input.url = data.url, 
                   output.folder = downloaded.folder, 
                   tar.file = tar.file.name)
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
    
    downloaded.folder <- "fixtures/Human_NSCLC/downloaded/"
    tar.file.name <- "nsclc_dccs.tar.gz"
    tar.file.path <- paste0(downloaded.folder, tar.file.name)
    
    # Check if dcc files were previously downloaded
    if (!file.exists(tar.file.path)) {
      
      data.url <- "http://hpc.nih.gov/~CCBR/DSPWorkflow/nsclc_dccs.tar.gz"
      # Download dcc files and place in data folder
      downloadDccs(input.url = data.url, 
                   output.folder = downloaded.folder, 
                   tar.file = tar.file.name)
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
      test_path("fixtures/Human_NSCLC", "DevCom_H_WTA_v1.0.pkc")
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
