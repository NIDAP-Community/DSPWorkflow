selectDatasetSD <- function(dataset) {
  # Human kidney diabetes dataset from the vignette
  if (dataset == "kidney") {
    print("selected kidney dataset")
    dcc.files <- dir(
      file.path(
        "/rstudio-files/ccr-dceg-data/data/WTA_NGS_Example/",
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
    dcc.files <- dir(
      file.path(
        "/rstudio-files/ccr-dceg-data/data/Thymus_Dataset/",
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
    dcc.files <- dir(
      file.path(
        "/rstudio-files/ccr-dceg-data/data/Colon_Dataset/",
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
    dcc.files <- dir(
      file.path(
        "/rstudio-files/ccr-dceg-data/data/NSCLC_Dataset/",
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