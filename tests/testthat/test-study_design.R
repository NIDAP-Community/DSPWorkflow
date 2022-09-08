test_that("Load Kidney dataset", {
  datadir <- "/rstudio-files/ccr-dceg-data/data/Kidney_Dataset/"
  DCCFiles <- dir(file.path(datadir, "dccs"), pattern = ".dcc$",
                  full.names = TRUE, recursive = TRUE)
  PKCFiles <- dir(file.path(datadir, "pkcs"), pattern = ".pkc",
                  full.names = TRUE, recursive = TRUE)
  SampleAnnotationFile <- dir(file.path(datadir, "annotation"), pattern = ".xlsx$",
                              full.names = TRUE, recursive = TRUE)

  dsp.list <- study_design(dccFiles = DCCFiles, pkcFiles = PKCFiles,
                           phenoDataFile = SampleAnnotationFile)
  print(dsp.list$plot)
  expected.elements = c("plot", "dsp.obj")
  expect_equal(length(setdiff(expected.elements, names(dsp.list))), 0)

})
