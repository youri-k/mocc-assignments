#!/bin/bash
EXECUTABLE="forksum"
if [ ! -e $EXECUTABLE ] ; then
	gcc -o forksum forksum.c
fi

counter=0
SECONDS=0
while [ $SECONDS -lt 11 ]; do
	result=$((time ./$EXECUTABLE 1 7000) 2>&1 | grep real | cut -d "m" -f 2 | sed s/s//)
	((counter++))
	array+=( $result )
done

arr=($(printf '%f\n' "$array" | sort -n))
nel=${#arr[@]}
if (( $nel % 2 == 1 )); then     # Odd number of elements
  val="${arr[ $(($nel/2)) ]}"
else                            # Even number of elements
  (( j=nel/2 ))
  (( k=j-1 ))
  (( val=(${arr[j]} + ${arr[k]})/2 ))
fi
echo $val | sed s/,/\./