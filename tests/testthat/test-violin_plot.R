# Data Testing
test_that("Violin Plot works for Human Kidney data", {

  kidney.data <- getViolinParam("kidney")

  violin.out <- do.call(violinPlot, kidney.data)

  # .drawViolinFig creates figure in tmp, compare with figure in _snaps
  skip_on_ci()
  expect_snapshot_file(
    .drawViolinFig(violin.out),
    "kidney_violin.png"
  )

  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(expected.elements, class(violin.out))

})

test_that("Violin Plot works for Mouse Thymus data", {

  thymus.data <- getViolinParam("thymus")

  violin.out <- do.call(violinPlot, thymus.data)
  
  skip_on_ci()
  expect_snapshot_file(
    .drawViolinFig(violin.out),
    "thymus_violin.png"
  )

  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(expected.elements, class(violin.out))

})

test_that("Violin Plot works for Human Colon data", {

  colon.data <- getViolinParam("colon")

  violin.out <- do.call(violinPlot, colon.data)
  
  skip_on_ci()
  expect_snapshot_file(
    .drawViolinFig(violin.out),
    "colon_violin.png"
  )

  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(expected.elements, class(violin.out))

})

test_that("Violin Plot works for Human NSCLC data", {

  nsclc.data <- getViolinParam("nsclc")

  violin.out <- do.call(violinPlot, nsclc.data)
  
  skip_on_ci()
  expect_snapshot_file(
    .drawViolinFig(violin.out),
    "nsclc_violin.png"
  )

  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(expected.elements, class(violin.out))

})

test_that("Violin Plot works when using a facet parameter", {

  nsclc.data <- getViolinParam("nsclc")
  
  # organize facet.by variable by levels
  pData(nsclc.data$object)$segment <- factor(pData(nsclc.data$object)$segment,
                                             levels = c("tumor", "TME",
                                                        "immune TME",
                                                        "control"))
  
  violin.out <- violinPlot(object = nsclc.data$object,
                                 expr.type = nsclc.data$expr.type,
                                 genes = nsclc.data$genes,
                                 group = nsclc.data$group,
                                 facet.by = "segment")
  
  skip_on_ci()
  expect_snapshot_file(
    .drawViolinFig(violin.out),
    "facet_violin.png"
  )

  expected.elements <- c("gtable", "gTree", "grob", "gDesc")
  expect_equal(expected.elements, class(violin.out))

})


# Error Testing
test_that("Violin Plot stops when gene expression type is absent", {

  kidney.data <- getViolinParam("kidney")

  expect_error(violinPlot(object = kidney.data$object,
                          expr.type = "absentexpr",
                          genes = kidney.data$genes,
                          group = kidney.data$group),
               "expression data type was not found in DSP object")

})

test_that("Violin Plot stops when all genes are absent", {

  kidney.data <- getViolinParam("kidney")

  incorrect.genes <- paste0("absentgene",1:10)

  expect_error(violinPlot(object = kidney.data$object,
                          expr.type = kidney.data$expr.type,
                          genes = incorrect.genes,
                          group = kidney.data$group),
               "no genes were found in DSP object")

})

test_that("Violin Plot stops when grouping parameter is absent", {

  kidney.data <- getViolinParam("kidney")

  expect_error(violinPlot(object = kidney.data$object,
                          expr.type = kidney.data$expr.type,
                          genes = kidney.data$genes,
                          group = "absentgroup"),
               "grouping parameter was not found in DSP object")

})

test_that("Violin Plot stops when faceting parameter is absent", {

  kidney.data <- getViolinParam("kidney")

  expect_error(violinPlot(object = kidney.data$object,
                          expr.type = kidney.data$expr.type,
                          genes = kidney.data$genes,
                          group = kidney.data$group,
                          facet.by = "absentfacet"),
               "facet parameter was not found in DSP object")

})
