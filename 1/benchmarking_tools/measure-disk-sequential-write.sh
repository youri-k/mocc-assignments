#!/bin/bash 
result=$(dd if=/dev/zero of=testfile bs=1G count=1 oflag=direct |& tail -1 | cut -d " " -f 1,8 | sed 's/,/\./' )
IFS=' ' read -r -a array <<< "$result"
echo "${array[0]} / ${array[1]}" | bc -l;