selectDatasetQC <- function(dataset) {
  if (dataset == "kidney") {
    print("selected kidney dataset")
    object <-
      readRDS(test_path("fixtures/Human_Kidney", "studyDesignHumanKidney.RDS"))
    min.segment.reads = 1000
    percent.trimmed = 80
    percent.stitched = 80
    percent.aligned = 75
    percent.saturation = 50
    min.negative.count = 10
    max.ntc.count = 9000
    min.nuclei = 20
    min.area = 1000
    min.probe.count = 10
    min.probe.ratio = 0.1
    outlier.test.alpha = 0.01
    percent.fail.grubbs = 20
    remove.local.outliers = FALSE
    print.plots = FALSE
  } else if (dataset == "thymus") {
    print("selected thymus dataset")
    object <-
      readRDS(test_path("fixtures/Mouse_Thymus", "studyDesignMouseThymus.RDS"))
    min.segment.reads = 1000
    percent.trimmed = 65
    percent.stitched = 65
    percent.aligned = 65
    percent.saturation = 50
    min.negative.count = 10
    max.ntc.count = 9000
    min.nuclei = 200
    min.area = 16000
    min.probe.count = 10
    min.probe.ratio = 0.1
    outlier.test.alpha = 0.01
    percent.fail.grubbs = 20
    remove.local.outliers = FALSE
    print.plots = FALSE
  } else if (dataset == "colon") {
    print("selected colon dataset")
    object <-
      readRDS(test_path("fixtures/Human_Colon", "studyDesignHumanColon.RDS"))
    min.segment.reads = 1000
    percent.trimmed = 80
    percent.stitched = 80
    percent.aligned = 80
    percent.saturation = 50
    min.negative.count = 10
    max.ntc.count = 1000
    min.nuclei = 1000
    min.area = 16000
    min.probe.count = 10
    min.probe.ratio = 0.1
    outlier.test.alpha = 0.01
    percent.fail.grubbs = 20
    remove.local.outliers = FALSE
    print.plots = FALSE
  } else if (dataset == "nsclc") {
    print("selected nsclc dataset")
    object <-
      readRDS(test_path("fixtures/Human_NSCLC", "studyDesignHumanNSCLC.RDS"))
    min.segment.reads = 1000
    percent.trimmed = 80
    percent.stitched = 80
    percent.aligned = 80
    percent.saturation = 50
    min.negative.count = 10
    max.ntc.count = NULL
    min.nuclei = NULL
    min.area = NULL
    min.probe.count = 10
    min.probe.ratio = 0.1
    outlier.test.alpha = 0.01
    percent.fail.grubbs = 20
    remove.local.outliers = FALSE
    print.plots = FALSE
  }
  return(
    list(
      "object" = object,
      "min.segment.reads" = min.segment.reads,
      "percent.trimmed" = percent.trimmed,
      "percent.stitched" = percent.stitched,
      "percent.aligned" = percent.aligned,
      "percent.saturation" = percent.saturation,
      "min.negative.count" = min.negative.count,
      "max.ntc.count" = max.ntc.count,
      "min.nuclei" = min.nuclei,
      "min.area" = min.area,
      "min.probe.count" = min.probe.count,
      "min.probe.ratio" = min.probe.ratio,
      "outlier.test.alpha" = outlier.test.alpha,
      "percent.fail.grubbs" = percent.fail.grubbs,
      "remove.local.outliers" = remove.local.outliers,
      "print.plots" = print.plots
    )
  )
}
## assign NULL values to args directly
## replacing element of a list with NULL removes it entirely from the list
## e.g., output$min.nuclei <- NULL removes $min.nuclei and causes test failure
selectNullDatasetQC <- function(dataset) {
  if (dataset == "kidney") {
    print("selected kidney dataset")
    object <-
      readRDS(test_path("fixtures/Human_Kidney", "studyDesignHumanKidney.RDS"))
    min.segment.reads = 1000
    percent.trimmed = 80
    percent.stitched = 80
    percent.aligned = 75
    percent.saturation = 50
    min.negative.count = 10
    max.ntc.count = 9000
    min.nuclei = NULL
    min.area = 1000
    min.probe.count = 10
    min.probe.ratio = 0.1
    outlier.test.alpha = 0.01
    percent.fail.grubbs = 20
    remove.local.outliers = FALSE
    print.plots = FALSE
  } else if (dataset == "thymus") {
    print("selected thymus dataset")
    object <-
      readRDS(test_path("fixtures/Mouse_Thymus", "studyDesignMouseThymus.RDS"))
    min.segment.reads = 1000
    percent.trimmed = 65
    percent.stitched = 65
    percent.aligned = 65
    percent.saturation = 50
    min.negative.count = 10
    max.ntc.count = 9000
    min.nuclei = 200
    min.area = NULL
    min.probe.count = 10
    min.probe.ratio = 0.1
    outlier.test.alpha = 0.01
    percent.fail.grubbs = 20
    remove.local.outliers = FALSE
    print.plots = FALSE
  }
  return(
    list(
      "object" = object,
      "min.segment.reads" = min.segment.reads,
      "percent.trimmed" = percent.trimmed,
      "percent.stitched" = percent.stitched,
      "percent.aligned" = percent.aligned,
      "percent.saturation" = percent.saturation,
      "min.negative.count" = min.negative.count,
      "max.ntc.count" = max.ntc.count,
      "min.nuclei" = min.nuclei,
      "min.area" = min.area,
      "min.probe.count" = min.probe.count,
      "min.probe.ratio" = min.probe.ratio,
      "outlier.test.alpha" = outlier.test.alpha,
      "percent.fail.grubbs" = percent.fail.grubbs,
      "remove.local.outliers" = remove.local.outliers,
      "print.plots" = print.plots
    )
  )
}
