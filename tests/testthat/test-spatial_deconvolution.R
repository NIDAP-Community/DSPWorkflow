
test_that("deconv works", {
  
  load(test_path("fixtures", "target_demoData.RData"))
  ref_mtx_test <- read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), row.names=1, check.names=FALSE)
  
  dsp_qnorm_test = target_demoData@assayData$q_norm
  dsp_negnorm_test = target_demoData@assayData$neg_norm
  annot_1 = read.csv(test_path("fixtures", "ref_annot.csv"))
  spatial_deconvolution(dsp_qnorm = dsp_qnorm_test, dsp_negnorm = dsp_negnorm_test, ref_mtx = ref_mtx_test, ref_annot = annot_1)
  
})
