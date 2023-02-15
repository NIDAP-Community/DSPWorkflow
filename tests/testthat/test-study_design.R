#test_that("Test Kidney dataset", {
  
#  kidney.dat <- selectDatasetSD("kidney")
  
#  study.design.output <- do.call(StudyDesign,kidney.dat)

#  expected.elements = c("plot", "dsp.obj")
#  expect_setequal(names(study.design.output), expected.elements)
  
#})

#test_that("Test Colon Dataset", {
  
#  colon.dat <- selectDatasetSD("colon")
  
#  study.design.output <- do.call(StudyDesign,colon.dat)
  
#  expected.elements = c("plot", "dsp.obj")
#  expect_setequal(names(study.design.output), expected.elements)
  
#})

#test_that("Test Mouse Thymus Dataset", {
  
#  thymus.dat <- selectDatasetSD("thymus")
  
#  study.design.output <- do.call(StudyDesign,thymus.dat)
  
#  expected.elements = c("plot", "dsp.obj")
#  expect_setequal(names(study.design.output), expected.elements)
  
#})

#test_that("Test Human NSCLC Dataset", {

#  nsclc.dat <- selectDatasetSD("nsclc")
  
#  study.design.output <- do.call(StudyDesign,nsclc.dat)
  
#  expected.elements = c("plot", "dsp.obj")
#  expect_setequal(names(study.design.output), expected.elements)
  
#})

test_that("Check for an error message when running study design on an annotation file without required fields", {
  
  kidney.dat <- selectDatasetSD("kidney")
  thymus.dat <- selectDatasetSD("thymus")
  nsclc.dat <- selectDatasetSD("nsclc")
  colon.dat <- selectDatasetSD("colon")
  
  # Load the test annotation files with faulty field names and check for an error message
  kidney.dat$phenoDataFile <- test_path("fixtures/Human_Kidney", "test_annotation_kidney.xlsx")
  expect_error(do.call(StudyDesign,kidney.dat), "slide name is required")
  
  thymus.dat$phenoDataFile <- test_path("fixtures/Mouse_Thymus", "test_annotation_thymus.xlsx")
  expect_error(do.call(StudyDesign,thymus.dat), "class is required")
  
  nsclc.dat$phenoDataFile <- test_path("fixtures/Human_NSCLC", "test_annotation_nsclc.xlsx")
  expect_error(do.call(StudyDesign,nsclc.dat), "segment is required")
  
  colon.dat$phenoDataFile <- test_path("fixtures/Human_Colon", "test_annotation_colon.xlsx")
  expect_error(do.call(StudyDesign,colon.dat), "region is required")
  
})

