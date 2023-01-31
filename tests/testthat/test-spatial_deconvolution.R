test_that("Spatial Deconvolution works for Human Kidney data", {
  
  kidney_dat <- select_dataset_spat_decon("kidney")
  
  invisible(capture.output(res <- spatial_deconvolution(dsp_obj = kidney_dat$object, 
                                                        ref_mtx = kidney_dat$ref_mtx,
                                                        norm_expr_type = kidney_dat$norm_expr_type,
                                                        ref_annot = kidney_dat$ref_annot)))
  
  # Make sure that the final output matches expected.elements (names of the compartments of the spatial_deconv list results)
  expected.elements <- c("dsp_data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Mouse Thymus data", {
  
  thymus_dat <- select_dataset_spat_decon("thymus")
  
  invisible(capture.output(res <- spatial_deconvolution(dsp_obj = thymus_dat$object, 
                                                        ref_mtx = thymus_dat$ref_mtx,
                                                        norm_expr_type = thymus_dat$norm_expr_type,
                                                        ref_annot = thymus_dat$ref_annot)))
  
  # Make sure that the final output matches expected.elements (names of the compartments of the spatial_deconv list results)
  expected.elements <- c("dsp_data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Human Colon data", {
  
  colon_dat <- select_dataset_spat_decon("colon")
  
  invisible(capture.output(res <- spatial_deconvolution(dsp_obj = colon_dat$object, 
                                                        ref_mtx = colon_dat$ref_mtx,
                                                        norm_expr_type = colon_dat$norm_expr_type,
                                                        ref_annot = colon_dat$ref_annot)))
  
  # Make sure that the final output matches expected.elements (names of the compartments of the spatial_deconv list results)
  expected.elements <- c("dsp_data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Human NSCLC", {
  
  nsclc_dat <- select_dataset_spat_decon("nsclc")
  
  invisible(capture.output(res <- spatial_deconvolution(dsp_obj = nsclc_dat$object, 
                                                        ref_mtx = nsclc_dat$ref_mtx,
                                                        norm_expr_type = nsclc_dat$norm_expr_type,
                                                        ref_annot = nsclc_dat$ref_annot)))
  
  # Make sure that the final output matches expected.elements (names of the compartments of the spatial_deconv list results)
  expected.elements <- c("dsp_data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution stops when normalized data slot is not present", {
  
  kidney_dat <- select_dataset_spat_decon("kidney")
  
  expect_error(spatial_deconvolution(dsp_obj = kidney_dat$object, 
                                     ref_mtx = kidney_dat$ref_mtx,
                                     norm_expr_type = "jibberish",
                                     ref_annot = kidney_dat$ref_annot), "Normalized data slot not found in the data")
})

test_that("Spatial Deconvolution stops when incorrect reference annotation colnames are selected", {
  
  kidney_dat <- select_dataset_spat_decon("kidney")
  
  expect_error(spatial_deconvolution(dsp_obj = kidney_dat$object, 
                                     ref_mtx = kidney_dat$ref_mtx,
                                     norm_expr_type = kidney_dat$norm_expr_type,
                                     ref_annot = kidney_dat$ref_annot,
                                     CellID = "jibberish",
                                     cellTypeCol = "jibberish1"), "Check that CellID and cellTypeCol are properly labeled and present in reference annotation table")
})
