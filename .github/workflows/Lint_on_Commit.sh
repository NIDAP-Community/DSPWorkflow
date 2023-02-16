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
                    grep -E 'tests/testthat' | sed 's:.*/::' ))
                    
    echo -e "Test script changed: \n${R_script_test[*]}\n"
    
    R_script_func=($(git diff "$last_commit" HEAD --name-only $current_branch | \
                    grep -E 'R/' | sed 's:.*/::' ))
                    
    echo -e "Function script changed: \n${R_script_func[*]}\n"
    
    for R_script in "${R_script_func[@]}"
    do
      test_file=$(ls tests/testthat | grep -iE "$R_script" | grep -iE "test")
      if [[ ! " ${R_script_test[*]} " =~ " ${test_file} " ]]; then
        R_script_test+=("$test_file")
      fi
    done
    
    echo -e "Tests to run as: \n${R_script_test[*]}\n"
    
    for test_to_run in "${R_script_test[@]}"
    do 
      
      test_call='lint("'"$current_dir"'/tests/testthat/'"$test_to_run"'", style = "lintr");'
      echo "Running: $test_call"
      
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

