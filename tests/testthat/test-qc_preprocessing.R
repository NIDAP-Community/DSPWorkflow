test_that("DSP object and qc plots are returned", {
  
  dsp.obj <- readRDS(test_path("fixtures", "dsp.obj.rds"))
  output <-
    QcProc(
      object = dsp.obj
    )
  expected.elements = c("dsp.target", "segments.qc")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
  
})

