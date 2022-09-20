test_that("deconv works", {
  dsp_qnorm_test = target_demoData@assayData$q_norm
  dsp_negnorm_test = target_demoData@assayData$neg_norm
  ref_mtx_test = as.matrix(t(ref_data_test$X))
  annot_1 = data.frame(CellID = rownames(ref_data_test$obs),
                                LabeledCellType = ref_data_test$obs$`cell types`)
  spatial_deconvolution(dsp_qnorm = dsp_qnorm_test, dsp_negnorm = dsp_negnorm_test, ref_mtx = ref_mtx_test, ref_annot = annot_1)
})
