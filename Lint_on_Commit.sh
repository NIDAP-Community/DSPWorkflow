#!/bin/sh -l

cd "$1"

last_commit="$2"

current_dir="$1"
current_branch="$(git rev-parse --abbrev-ref HEAD)"
echo "Checking latest push to $current_branch"

cp ./.github/workflows/.lintr ~/

if [ -f DESCRIPTION ]; then
    echo "DESCRIPTION exist."
    
    
    R_script_test=($(git diff "$last_commit" HEAD --name-only $current_branch | \
                    grep -E 'tests/testthat'))
                    
    echo -e "Test script changed: \n${R_script_test[*]}\n"
    
    R_script_func=($(git diff "$last_commit" HEAD --name-only $current_branch | \
                    grep -E 'R/'))
                    
    echo -e "Function script changed: \n${R_script_func[*]}\n"
    
    
    Lint_list=( "${R_script_test[@]}" "${R_script_func[@]}" )
    
    echo -e "Lint to run as: \n${R_script_test[*]}\n"
    
    for test_to_run in "${Lint_list[@]}"
    do 
      
      test_call='File_to_lint = "'"$test_to_run"'";source(".github/workflows/Workflow_linter.R", local=FALSE, print.eval=TRUE);'
      
      
      echo "====================================================================="
      echo "Running $test_call"
      
      R -e '.libPaths(c("/renv/library/R-4.1/x86_64-pc-linux-gnu",.libPaths()));library(lintr);sink(file="'"${current_dir}"'/lint.log");'"$test_call"'sink()'  
      
      cat lint.log
      
      echo "====================================================================="
      echo "====================================================================="
    done
      
else 

    echo "DESCRIPTION file does not exist."
    exit 1
    
fi

