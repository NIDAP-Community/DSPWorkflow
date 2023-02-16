# Define custom linter

lint(filename = File_to_lint, 
     linters = linters_with_defaults(
       commented_code_linter(),
       line_length_linter(120),
       object_name_linter(styles = c("dotted.case", "lowercase", "camelCase"))
     )
)