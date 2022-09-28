
test_that("deconv works", {
  
  library(anndata)

  load("/rstudio-files/ccr-dceg-data/users/Jing/DSPWorkflow/tests/testthat/fixtures/target_demoData.RData")
  ref_data_test = read_h5ad("/rstudio-files/ccr-dceg-data/users/Jing/DSPWorkflow/tests/testthat/fixtures/HTA08.v02.A04.Science_mouse_stromal.h5ad")
  
  dsp_qnorm_test = target_demoData@assayData$q_norm
  dsp_negnorm_test = target_demoData@assayData$neg_norm
  ref_mtx_test <- read.csv("/rstudio-files/ccr-dceg-data/users/Jing/DSPWorkflow/tests/testthat/fixtures/sample_spatial_deconv_mtx.csv", row.names=1, check.names=FALSE)
  annot_1 = data.frame(CellID = rownames(ref_data_test$obs),
                                LabeledCellType = ref_data_test$obs$`cell types`)
  spatial_deconvolution(dsp_qnorm = dsp_qnorm_test, dsp_negnorm = dsp_negnorm_test, ref_mtx = ref_mtx_test, ref_annot = annot_1)
  
})
