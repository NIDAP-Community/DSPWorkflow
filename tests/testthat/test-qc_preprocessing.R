test_that("Test Human Kidney dataset", {
  kidney.dat <- selectDatasetQC("kidney")
  output <- do.call(qcProc, kidney.dat)
  expected.elements <- c("object", "plot","table","segment.flags","probe.flags")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
})
test_that("Test Mouse Thymus Dataset", {
  thymus.dat <- selectDatasetQC("thymus")
  output <- do.call(qcProc, thymus.dat)
  expected.elements <- c("object", "plot","table","segment.flags","probe.flags")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
})
test_that("Test Colon Dataset", {
  colon.dat <- selectDatasetQC("colon")
  expect_warning(output <- do.call(qcProc, colon.dat), regexp = NULL)
  expected.elements <- c("object", "plot","table","segment.flags","probe.flags")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
})
test_that("Test Human NSCLC Dataset", {
  nsclc.dat <- selectDatasetQC("nsclc") 
  expect_warning(output <- do.call(qcProc, nsclc.dat), regexp = NULL)
  expected.elements <- c("object", "plot","table","segment.flags","probe.flags")
  expect_equal(length(setdiff(expected.elements, names(output))), 0)
})
test_that(
  "Check for an error message when running QC for a dataset with a required
  parameter listed as a string",
  {
    kidney.dat <- selectDatasetQC("kidney")
    thymus.dat <- selectDatasetQC("thymus")
    #Assign strings to a required parameter
    kidney.dat$min.segment.reads <- "one thousand"
    thymus.dat$percent.aligned <- "80"
    expect_error(
      do.call(qcProc, kidney.dat),
      fixed = TRUE,
      "min.segment.reads is not numeric, please specify a numeric value"
    )
    expect_error(
      do.call(qcProc, thymus.dat),
      fixed = TRUE,
      "percent.aligned is not numeric, please specify a numeric value"
    )
  }
)
test_that("Check for a warning message when running QC for a dataset missing an
          optional parameter",
          {
            colon.dat <- selectDatasetQC("colon")
            expect_warning(
              do.call(qcProc, colon.dat),
              paste0(
                "nuclei not found in the annotation, min.nuclei will not ",
                "be considered"
              )
            )
            nsclc.dat <- selectDatasetQC("nsclc")
            expect_warning(
              do.call(qcProc, nsclc.dat),
              paste0(
                "NTC, nuclei, area not found in the annotation, max.ntc.",
                "count, min.nuclei, min.area will not be considered"
              )
            )
          })
test_that(
  "Check for an error message when running QC for a dataset with an optional
  parameter listed as NULL",
  {
    kidney.dat <- selectDatasetQC("kidney")
    kidney.dat$min.nuclei <- list(NULL)
    kidney.dat <- lapply(kidney.dat, unlist)
    thymus.dat <- selectDatasetQC("thymus")
    thymus.dat$min.area <- list(NULL)
    thymus.dat <- lapply(thymus.dat, unlist)
    expect_error(
      do.call(qcProc, kidney.dat),
      fixed = TRUE,
      paste0(
        "nuclei is part of the annotation, please specify a numeric ",
        "value for min.nuclei"
      ),
    )
    expect_error(
      do.call(qcProc, thymus.dat),
      fixed = TRUE,
      paste0(
        "area is part of the annotation, please specify a numeric ",
        "value for min.area"
      )
    )
  }
)
