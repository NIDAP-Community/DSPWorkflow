# Data Testing
test_that("Spatial Deconvolution works using custom reference", {

  kidney.data <- getSpatDeconData("kidney_w_custom_ref")

  invisible(capture.output(res <- do.call(spatialDeconvolution, kidney.data)))
  
  # Check for consistent image output across runs
  skip_on_ci()
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$abundance.heatmap),
    "kidney_abd_heat_custom.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$cell.profile.heatmap),
    "kidney_cellprof_heat_custom.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$composition.barplot),
    "kidney_comp_bar_custom.png"
  )
  
  # Check for consistent cell fractions and signature across runs
  expect_equal(res$dsp.data$beta["cTEC(cycling)",
                                 "DSP-1002510007866-C-F07.dcc"], 
               6.225, tolerance = 1e-3)
  
  expect_equal(res$dsp.data$X["INPP5J","mTEC_IV(tuft)"], 0.6312, 
               tolerance = 1e-3)

  expected.elements <- c("dsp.data","figures")
  expect_setequal(names(res), expected.elements)

})

test_that("Spatial Deconvolution works for Human Kidney data", {
  
  kidney.data <- getSpatDeconData("kidney")
  
  invisible(capture.output(res <- do.call(spatialDeconvolution, kidney.data)))
  
  # Check for consistent image output across runs
  skip_on_ci()
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$abundance.heatmap),
    "kidney_abd_heat.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$cell.profile.heatmap),
    "kidney_cellprof_heat.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$composition.barplot),
    "kidney_comp_bar.png"
  )
  
  # Check for consistent cell fractions and signature across runs
  expect_equal(res$dsp.data$beta["Peritubular.capillary.endothelium.2",
                                 "DSP-1002510007866-C-H12.dcc"], 
               4.524, tolerance = 1e-3)
  
  expect_equal(res$dsp.data$X["CA2","Principal.cell"], 1.71, 
               tolerance = 1e-3)
  
  expected.elements <- c("dsp.data","figures")
  expect_setequal(names(res), expected.elements)
  
})

test_that("Spatial Deconvolution works for Mouse Thymus data", {

  thymus.data <- getSpatDeconData("thymus")

  invisible(capture.output(res <- do.call(spatialDeconvolution, thymus.data)))
  
  # Check for consistent image output across runs
  skip_on_ci()
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$abundance.heatmap),
    "thymus_abd_heat.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$cell.profile.heatmap),
    "thymus_cellprof_heat.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$composition.barplot),
    "thymus_comp_bar.png"
  )
  
  # Check for consistent cell fractions and signature across runs
  expect_equal(res$dsp.data$beta["alpha.beta.T.cell",
                                 "DSP-1001660007393-A-H10.dcc"], 
               134.7, tolerance = 1e-3)
  
  expect_equal(res$dsp.data$X["0610009B22Rik","Proliferating.thymocyte"],0.1316, 
               tolerance = 1e-3)

  expected.elements <- c("dsp.data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Human Colon data", {

  colon.data <- getSpatDeconData("colon")

  invisible(capture.output(res <- do.call(spatialDeconvolution, colon.data)))
  
  # Check for consistent image output across runs
  skip_on_ci()
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$abundance.heatmap),
    "colon_abd_heat.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$cell.profile.heatmap),
    "colon_cellprof_heat.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$composition.barplot),
    "colon_comp_bar.png"
  )
  
  # Check for consistent cell fractions and signature across runs
  expect_equal(res$dsp.data$beta["pericyte",
                                 "DSP-1012550000101-H-F07.dcc"], 
               12.76, tolerance = 1e-3)
  
  expect_equal(res$dsp.data$X["GSN","endothelial.cell.type.1"], 3.2146, 
               tolerance = 1e-3)

  expected.elements <- c("dsp.data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Human NSCLC", {

  nsclc.data <- getSpatDeconData("nsclc")

  invisible(capture.output(res <- do.call(spatialDeconvolution, nsclc.data)))
  
  # Check for consistent image output across runs
  skip_on_ci()
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$abundance.heatmap),
    "nsclc_abd_heat.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$cell.profile.heatmap),
    "nsclc_cellprof_heat.png"
  )
  
  expect_snapshot_file(
    .drawSpatDeconFig(res[["figures"]]$composition.barplot),
    "nsclc_comp_bar.png"
  )
  
  # Check for consistent cell fractions and signature across runs
  expect_equal(res$dsp.data$beta["fibroblast",
                                 "GSM6573816_DSP-1012310141221-B-C08.dcc"], 
               0.8877, tolerance = 1e-3)
  
  expect_equal(res$dsp.data$X["ADA","plasmacytoid.dendritic.cell"], 0.427, 
               tolerance = 1e-3)

  expected.elements <- c("dsp.data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution allows for grouping of samples", {

            kidney.data <- getSpatDeconData("kidney_w_custom_ref")

            res <- spatialDeconvolution(
              object = kidney.data$object,
              prof.mtx = NULL,
              ref.mtx = kidney.data$ref.mtx,
              expr.type = kidney.data$expr.type,
              ref.annot = kidney.data$ref.annot,
              cell.id.col = kidney.data$cell.id.col,
              celltype.col = kidney.data$celltype.col,
              group.by = "class")

            # Check for consistent image output across runs
            skip_on_ci()
             expect_snapshot_file(
               .drawSpatDeconFig(res[["figures"]]$abundance.heatmap),
               "kidney_abd_heat_grouped.png"
             )

             expect_snapshot_file(
               .drawSpatDeconFig(res[["figures"]]$cell.profile.heatmap),
               "kidney_cellprof_heat_grouped.png"
             )

            expect_snapshot_file(
              .drawSpatDeconFig(res[["figures"]]$composition.barplot),
              "kidney_comp_bar_grouped.png"
            )

            # Check for consistent cell fractions and signature across runs
            expect_equal(res$dsp.data$beta["B.naive",
                                           "DSP-1002510007866-C-H11.dcc"],
                         2.2216481, tolerance = 1e-3)

            expect_equal(res$dsp.data$X["A2M","endothelial.cells"], 1.762301e+01,
                         tolerance = 1e-3)

            expected.elements <- c("dsp.data","figures")
            expect_setequal(names(res), expected.elements)
          })

# Error Testing
test_that("Spatial Deconvolution stops when normalized data slot is
          not present", {

  kidney.data <- getSpatDeconData("kidney_w_custom_ref")

  expect_error(spatialDeconvolution(object = kidney.data$object,
                                    prof.mtx = NULL,
                                    ref.mtx = kidney.data$ref.mtx,
                                    expr.type = "wrong.expr.slot",
                                    ref.annot = kidney.data$ref.annot),
               "Normalized data slot not found in the data")
})

test_that("Spatial Deconvolution stops when incorrect grouping parameter
          is selected", {

            kidney.data <- getSpatDeconData("kidney_w_custom_ref")

            expect_error(spatialDeconvolution(
              object = kidney.data$object,
              ref.mtx = kidney.data$ref.mtx,
              expr.type = kidney.data$expr.type,
              ref.annot = kidney.data$ref.annot,
              cell.id.col = kidney.data$cell.id.col,
              celltype.col = kidney.data$celltype.col,
              group.by = "wrong.group"),
              "Check that group.by category is present in metadata")
          })
