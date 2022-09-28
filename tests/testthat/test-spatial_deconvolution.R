
test_that("deconv works", {
  
  library(anndata)
  
  load(test_path("fixtures", "target_demoData.RData"))
  ref_data_test <- read_h5ad(test_path("fixtures", "HTA08.v02.A04.Science_mouse_stromal.h5ad"))
  ref_mtx_test <- read.csv(test_path("fixtures", "sample_spatial_deconv_mtx.csv"), row.names=1, check.names=FALSE)
  
  dsp_qnorm_test = target_demoData@assayData$q_norm
  dsp_negnorm_test = target_demoData@assayData$neg_norm
  annot_1 = data.frame(CellID = rownames(ref_data_test$obs),
                                LabeledCellType = ref_data_test$obs$`cell types`)
  spatial_deconvolution(dsp_qnorm = dsp_qnorm_test, dsp_negnorm = dsp_negnorm_test, ref_mtx = ref_mtx_test, ref_annot = annot_1)
  
})
