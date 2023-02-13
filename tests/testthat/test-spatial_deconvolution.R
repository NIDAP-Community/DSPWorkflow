test_that("Spatial Deconvolution works for Human Kidney data", {
  
  kidney_dat <- select_dataset_spat_decon("kidney")
  
  invisible(capture.output(res <- spatialDeconvolution(dsp.obj = kidney_dat$object, 
                                                        ref.mtx = kidney_dat$ref.mtx,
                                                        norm.expr.type = kidney_dat$norm.expr.type,
                                                        ref.annot = kidney_dat$ref.annot)))
  
  # Make sure that the final output matches expected.elements (names of the compartments of the spatial_deconv list results)
  expected.elements <- c("dsp_data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Mouse Thymus data", {
  
  thymus_dat <- select_dataset_spat_decon("thymus")
  
  invisible(capture.output(res <- spatialDeconvolution(dsp.obj = thymus_dat$object, 
                                                        ref.mtx = thymus_dat$ref.mtx,
                                                        norm.expr.type = thymus_dat$norm.expr.type,
                                                        ref.annot = thymus_dat$ref.annot)))
  
  # Make sure that the final output matches expected.elements (names of the compartments of the spatial_deconv list results)
  expected.elements <- c("dsp_data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Human Colon data", {
  
  colon_dat <- select_dataset_spat_decon("colon")
  
  invisible(capture.output(res <- spatialDeconvolution(dsp.obj = colon_dat$object, 
                                                        ref.mtx = colon_dat$ref.mtx,
                                                        norm.expr.type = colon_dat$norm.expr.type,
                                                        ref.annot = colon_dat$ref.annot)))
  
  # Make sure that the final output matches expected.elements (names of the compartments of the spatial_deconv list results)
  expected.elements <- c("dsp_data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Human NSCLC", {
  
  nsclc_dat <- select_dataset_spat_decon("nsclc")
  
  invisible(capture.output(res <- spatialDeconvolution(dsp.obj = nsclc_dat$object, 
                                                        ref.mtx = nsclc_dat$ref.mtx,
                                                        norm.expr.type = nsclc_dat$norm.expr.type,
                                                        ref.annot = nsclc_dat$ref.annot)))
  
  # Make sure that the final output matches expected.elements (names of the compartments of the spatial_deconv list results)
  expected.elements <- c("dsp_data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution stops when normalized data slot is not present", {
  
  kidney_dat <- select_dataset_spat_decon("kidney")
  
  expect_error(spatialDeconvolution(dsp.obj = kidney_dat$object, 
                                     ref.mtx = kidney_dat$ref.mtx,
                                     norm.expr.type = "jibberish",
                                     ref.annot = kidney_dat$ref.annot), "Normalized data slot not found in the data")
})

test_that("Spatial Deconvolution stops when incorrect reference annotation colnames are selected", {
  
  kidney_dat <- select_dataset_spat_decon("kidney")
  
  expect_error(spatialDeconvolution(dsp.obj = kidney_dat$object, 
                                     ref.mtx = kidney_dat$ref.mtx,
                                     norm.expr.type = kidney_dat$norm.expr.type,
                                     ref.annot = kidney_dat$ref.annot,
                                     cell.id = "jibberish",
                                     celltype.col = "jibberish1"), "Check that cell.id and celltype.col are properly labeled and present in reference annotation table")
})
