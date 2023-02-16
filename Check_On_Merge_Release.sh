#!/bin/sh -l

cd $1

current_dir="$1"
# Check if DESCRIPTION file exist

if [ -f DESCRIPTION ]; then
    echo "DESCRIPTION exist."
    
    
    R_scripts=($(ls ./R))
                    
    function_name_list=()
    
    R_script_test=()
    
    for script in "${R_scripts[@]}"; do
      function_name="${script%.R}"
      function_name_list+=("${script%.R}")
      
      test_file=$(ls tests/testthat | grep -iE "$script" | grep -iE "test")
      R_script_test+=("$test_file")
    done
    
    
    printf "%-35s %-35s\n" "Function_Scripts" "Test_scripts"
    line=$(printf "%-$(($(tput cols)-1))s" "")
    line=${line// /-}
    printf "%s\n" "$line"
    for ((i=0; i<${#function_name_list[@]}; i++)); do
      if [ -z "${R_script_test[i]}" ];
      then
        printf "%-35s %-35s\n" "${function_name_list[i]}" "MISSING"
        printf "%s\n" "$line"
      else
        printf "%-35s %-35s\n" "${function_name_list[i]}" "${R_script_test[i]}"
        printf "%s\n" "$line"
      fi
    done
    
    for test_to_run in ${R_script_test[@]}
    do 
      
      test_call='test_file("'"$current_dir"'/tests/testthat/'"$test_to_run"'");'
      
      echo "====================================================================="
      echo -e "Running $test_call"
      
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

