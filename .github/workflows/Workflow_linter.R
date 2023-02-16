# Define custom linter

lint(filename = File_to_lint, 
     linters = linters_with_defaults(
       any_duplicated_linter(),
       any_is_na_linter(),
       backport_linter("oldrel-4", except = c("R_user_dir", "str2lang", "str2expression", "deparse1")),
       consecutive_stopifnot_linter(),
       expect_comparison_linter(),
       expect_length_linter(),
       expect_named_linter(),
       expect_not_linter(),
       expect_null_linter(),
       expect_s3_class_linter(),
       expect_s4_class_linter(),
       expect_true_false_linter(),
       expect_type_linter(),
       implicit_integer_linter(),
       line_length_linter(120),
       missing_argument_linter(),
       nested_ifelse_linter(),
       numeric_leading_zero_linter(),
       paste_linter(),
       redundant_ifelse_linter(),
       sprintf_linter(),
       strings_as_factors_linter(),
       yoda_test_linter()
     )
)