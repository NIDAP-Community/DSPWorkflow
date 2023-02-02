test_that("Test Kidney dataset", {
  
  kidney_dat <- select_dataset_sd("kidney")
  
  study_design_output <- do.call(StudyDesign,kidney_dat)

  expected.elements = c("plot", "dsp.obj")
  expect_setequal(names(study_design_output), expected.elements)
  
})

test_that("Test Colon Dataset", {
  
  colon_dat <- select_dataset_sd("colon")
  
  study_design_output <- do.call(StudyDesign,colon_dat)
  
  expected.elements = c("plot", "dsp.obj")
  expect_setequal(names(study_design_output), expected.elements)
  
})

test_that("Test Mouse Thymus Dataset", {
  
  thymus_dat <- select_dataset_sd("thymus")
  
  study_design_output <- do.call(StudyDesign,thymus_dat)
  
  expected.elements = c("plot", "dsp.obj")
  expect_setequal(names(study_design_output), expected.elements)
  
})

test_that("Test Human NSCLC Dataset", {
  
  nsclc_dat <- select_dataset_sd("nsclc")
  
  study_design_output <- do.call(StudyDesign,nsclc_dat)
  
  expected.elements = c("plot", "dsp.obj")
  expect_setequal(names(study_design_output), expected.elements)
  
})

