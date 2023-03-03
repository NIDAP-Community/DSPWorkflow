#!/bin/sh -l

cd "$1"

last_commit="$2"

current_dir="$1"
current_branch="$(git rev-parse --abbrev-ref HEAD)"
echo "Checking latest push to $current_branch"


if [ -f DESCRIPTION ]; then
    echo "DESCRIPTION exist."
    
    
    R_script_test=($(git diff "$last_commit" HEAD --name-only $current_branch | \
                    grep -E 'tests/testthat' | grep -v '/fixtures' | \
                    sed 's:.*/::' | grep -v '^helper-.*.R$'))
                    
    echo -e "Test script changed: \n${R_script_test[*]}\n"
    
    R_script_func=($(git diff "$last_commit" HEAD --name-only $current_branch | \
                    grep -E 'R/' | sed 's:.*/::' | grep -iE '*.R$'))
                    
    echo -e "Function script changed: \n${R_script_func[*]}\n"
    
    for R_script in "${R_script_func[@]}"
    do
      test_file=$(ls tests/testthat | grep -iE "$R_script" | grep -iE "test")
      if [[ ! " ${R_script_test[*]} " =~ " ${test_file} " ]]; then
        R_script_test+=("$test_file")
      fi
    done
    
    echo -e "Tests to run as: \n${R_script_test[*]}\n"
    
    R -e '.libPaths(c("/renv/library/R-4.1/x86_64-pc-linux-gnu",.libPaths()));.libPaths();ip = as.data.frame(installed.packages()[,c(1,3:4)]);ip = ip[is.na(ip$Priority),1:2,drop=FALSE];ip;sessionInfo();'
    
    for test_to_run in "${R_script_test[@]}"
    do 
      
      test_call='test_file("'"$current_dir"'/tests/testthat/'"$test_to_run"'");'

      
      echo "====================================================================="
      echo "Running $test_call"
      
      R -e '.libPaths(c("/renv/library/R-4.1/x86_64-pc-linux-gnu",.libPaths()));library(devtools);sink(file="'"${current_dir}"'/test.log");load_all();'"$test_call"'sink()'  
      
      cat test.log
      
      echo "====================================================================="
      echo "====================================================================="
      
      message_check=$(tail -n 1 test.log | cut -d'|' -f 4 | cut -d' ' -f 2)
      echo "Message Check: $message_check"
      
      if [ "$message_check" = "PASS" ]; then
        FAIL_num=$(tail -n 1 test.log | cut -d'|' -f 1 | cut -d' ' -f 3)
        if [ "$FAIL_num" != "0" ]; then
          echo "Number of FAIL in test is $FAIL_num"
          exit 2
        else
          echo "Passed Check!"
        fi
        
      else
        FAIL_num=$(tail -n3 test.log | head -n1 | cut -d'|' -f 1 | cut -d' ' -f 3)
        
        if [ "$FAIL_num" != "0" ]; then
          echo "Number of FAIL in test is $FAIL_num"
          exit 2
        else
          echo "Passed Check!"
        fi
      fi
    done
else 
    echo "DESCRIPTION file does not exist."
    exit 1
fi

