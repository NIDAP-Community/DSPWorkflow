test_that("Test Human Kidney dataset", {
  kidney.dat <- selectDatasetQC("kidney")
  expect_warning(output <- do.call(qcProc, kidney.dat), regexp = NA)
  expected.elements = c("object", "plot")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
})
test_that("Test Mouse Thymus Dataset", {
  thymus.dat <- selectDatasetQC("thymus")
  expect_warning(output <- do.call(qcProc, thymus.dat), regexp = NA)
  expected.elements = c("object", "plot")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
})
test_that("Test Colon Dataset", {
  colon.dat <- selectDatasetQC("colon")
  expect_warning(output <- do.call(qcProc, colon.dat), regexp = NULL)
  expected.elements = c("object", "plot")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
})
## removed nsclc until a solution found to multiple warnings in expect_warning()
#test_that("Test Human NSCLC Dataset", {
#nsclc.dat <- selectDatasetQC("nsclc")
#expect_warning(output <- do.call(qcProc, nsclc.dat), regexp = NULL)
#expected.elements = c("object", "plot")
#expect_equal(length(setdiff(expected.elements, names(output))), 0)
#})
test_that(
  "Check for an error message when running QC for a dataset with a required
  parameter listed as a string",
  {
    kidney.dat <- selectDatasetQC("kidney")
    thymus.dat <- selectDatasetQC("thymus")
    # Assign strings to a required parameter
    kidney.dat$min.segment.reads <- "one thousand"
    thymus.dat$percent.aligned <- "80"
    expect_error(
      output <- do.call(qcProc, kidney.dat),
      fixed = TRUE,
      "is not numeric. Please specify a numeric value"
    )
    expect_error(
      output <- do.call(qcProc, thymus.dat),
      fixed = TRUE,
      "is not numeric. Please specify a numeric value"
    )
  }
)
## removed nsclc until a solution found to multiple warnings in expect_warning()
test_that("Check for a warning message when running QC for a dataset missing an
          optional parameter",          {
            colon.dat <- selectDatasetQC("colon")
            expect_warning(
              output <- do.call(qcProc, colon.dat),
              "nuclei is not found in the annotation, min.nuclei will not be considered")
          })
            # nsclc.dat <- selectDatasetQC("nsclc")
            #expect_warning(
            #output <- do.call(qcProc, nsclc.dat),
            #"NTC is not found in the annotation, max.ntc.count will not be considered"
            # "nuclei is not found in the annotation, min.nuclei will not be considered",
            #"area is not found in the annotation, min.area will not be considered"
            #)
 test_that(
  "Check for an error message when running QC for a dataset with an optional
  parameter listed as NULL",
  {
    kidney.dat <- selectNullDatasetQC("kidney")
    thymus.dat <- selectNullDatasetQC("thymus")
    expect_error(
      output <- do.call(qcProc, kidney.dat),
      fixed = TRUE,
      "nuclei is part of the annotation, please specify a numeric value for min.nuclei",
    )
    expect_error(
      output <- do.call(qcProc, thymus.dat),
      fixed = TRUE,
      "area is part of the annotation, please specify a numeric value for min.area"
    )
    
  }
)
