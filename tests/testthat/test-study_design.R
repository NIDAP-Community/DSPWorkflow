test_that("Test Kidney dataset", {
  
  kidney.dat <- selectDatasetSD("kidney")
  
  study.design.output <- do.call(studyDesign,kidney.dat)

  expected.elements = c("sankey.plot", "object")
  expect_setequal(names(study.design.output), expected.elements)
  
})

test_that("Test Colon Dataset", {
  
  colon.dat <- selectDatasetSD("colon")
  
  study.design.output <- do.call(studyDesign,colon.dat)
  
  expected.elements = c("sankey.plot", "object")
  expect_setequal(names(study.design.output), expected.elements)
  
})

test_that("Test Mouse Thymus Dataset", {
  
  thymus.dat <- selectDatasetSD("thymus")
  
  study.design.output <- do.call(studyDesign,thymus.dat)
  
  expected.elements = c("sankey.plot", "object")
  expect_setequal(names(study.design.output), expected.elements)
  
})

test_that("Test Human NSCLC Dataset", {

  nsclc.dat <- selectDatasetSD("nsclc")
  
  study.design.output <- do.call(studyDesign,nsclc.dat)
  
  expected.elements = c("sankey.plot", "object")
  expect_setequal(names(study.design.output), expected.elements)
  
})

test_that("Check for an error message when running study design 
          on an annotation file without required fields", {
  
  kidney.dat <- selectDatasetSD("kidney")
  thymus.dat <- selectDatasetSD("thymus")
  nsclc.dat <- selectDatasetSD("nsclc")
  colon.dat <- selectDatasetSD("colon")
  
  # Load the test annotation files with faulty field names 
  # and check for an error message
  kidney.dat$pheno.data.file <- test_path("fixtures/Human_Kidney", 
                                        "test_annotation_kidney.xlsx")
  expect_error(do.call(studyDesign,kidney.dat), "is not found in the annotation sheet field names")
  
  thymus.dat$pheno.data.file <- test_path("fixtures/Mouse_Thymus", 
                                        "test_annotation_thymus.xlsx")
  expect_error(do.call(studyDesign,thymus.dat), "is not found in the annotation sheet field names")
  
  nsclc.dat$pheno.data.file <- test_path("fixtures/Human_NSCLC", 
                                       "test_annotation_nsclc.xlsx")
  expect_error(do.call(studyDesign,nsclc.dat), "is not found in the annotation sheet field names")
  
  colon.dat$pheno.data.file <- test_path("fixtures/Human_Colon", 
                                       "test_annotation_colon.xlsx")
  expect_error(do.call(studyDesign,colon.dat), "is not found in the annotation sheet field names")
  
})

