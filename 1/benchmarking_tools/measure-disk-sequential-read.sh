#!/bin/bash 
result=$(dd if=testfile of=/dev/null bs=1G count=1 |& tail -1 | cut -d " " -f 1,8 | sed 's/,/\./' )
IFS=' ' read -r -a array <<< "$result"
echo "${array[0]} / ${array[1]}" | bc -l;