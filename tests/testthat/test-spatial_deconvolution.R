
test_that("deconv works", {
  
  load(test_path("fixtures", "target_demoData.RData"))
  ref_mtx_test <- read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), row.names=1, check.names=FALSE)
  
  dsp_qnorm_test = target_demoData@assayData$q_norm
  dsp_negnorm_test = target_demoData@assayData$neg_norm
  annot_1 = read.csv(test_path("fixtures", "ref_annot.csv"))
  
  invisible(capture.output(res <- spatial_deconvolution(dsp_qnorm = dsp_qnorm_test, 
                                                        dsp_negnorm = dsp_negnorm_test, 
                                                        ref_mtx = ref_mtx_test, ref_annot = annot_1)))
  
  # Make sure that the final output matches expected.elements (names of the compartments of the spatial_deconv list results)
  expected.elements <- c("beta", "sigmas", "yhat", "resids", "p", "t", "se", "prop_of_all", "prop_of_nontumor", "X")
  expect_setequal(names(res), expected.elements)
})
