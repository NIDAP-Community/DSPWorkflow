# Data Testing
test_that("Spatial Deconvolution works for Human Kidney data", {
  
  kidney.data <- getSpatDeconData("kidney")
  
  invisible(capture.output(res <- do.call(spatialDeconvolution, kidney.data)))
  
  expected.elements <- c("dsp.data","figures")
  expect_setequal(names(res), expected.elements)
  
})

test_that("Spatial Deconvolution works for Mouse Thymus data", {
  
  thymus.data <- getSpatDeconData("thymus")
  
  invisible(capture.output(res <- do.call(spatialDeconvolution, thymus.data)))
  
  expected.elements <- c("dsp.data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Human Colon data", {
  
  colon.data <- getSpatDeconData("colon")
  
  invisible(capture.output(res <- do.call(spatialDeconvolution, colon.data)))
  
  expected.elements <- c("dsp.data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution works for Human NSCLC", {
  
  nsclc.data <- getSpatDeconData("nsclc")
  
  invisible(capture.output(res <- do.call(spatialDeconvolution, nsclc.data)))
  
  expected.elements <- c("dsp.data","figures")
  expect_setequal(names(res), expected.elements)
})

test_that("Spatial Deconvolution allows for grouping of samples", {
            
            kidney.data <- getSpatDeconData("kidney")
            
            res <- spatialDeconvolution(
              object = kidney.data$object, 
              ref.mtx = kidney.data$ref.mtx,
              expr.type = kidney.data$expr.type,
              ref.annot = kidney.data$ref.annot,
              cell.id.col = kidney.data$cell.id.col,
              celltype.col = kidney.data$celltype.col,
              group.by = "class")
            
            expected.elements <- c("dsp.data","figures")
            expect_setequal(names(res), expected.elements)
          })

# Error Testing
test_that("Spatial Deconvolution stops when normalized data slot is 
          not present", {
  
  kidney.data <- getSpatDeconData("kidney")
  
  expect_error(spatialDeconvolution(object = kidney.data$object, 
                                     ref.mtx = kidney.data$ref.mtx,
                                     expr.type = "wrong.expr.slot",
                                     ref.annot = kidney.data$ref.annot), 
               "Normalized data slot not found in the data")
})

test_that("Spatial Deconvolution stops when incorrect reference annotation 
          colnames are selected", {
  
  kidney.data <- getSpatDeconData("kidney")
  
  expect_error(spatialDeconvolution(
    object = kidney.data$object, 
    ref.mtx = kidney.data$ref.mtx,
    expr.type = kidney.data$expr.type,
    ref.annot = kidney.data$ref.annot,
    cell.id.col = "wrong.cell.id",
    celltype.col = "wrong.celltype"),
    "Check cell.id.col and celltype.col labels are correct")
})

test_that("Spatial Deconvolution stops when incorrect grouping parameter 
          is selected", {
            
            kidney.data <- getSpatDeconData("kidney")
            
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
