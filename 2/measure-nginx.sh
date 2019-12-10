#!/bin/bash
SECONDS=0
counter=0
sum=0
while [ $SECONDS -lt 11 ]; do
	result=$(for i in {1..3}; do echo $1; done | xargs -P3 -n 1 curl -o /dev/null -s -w '%{time_total}#' | sed 's/,/\./g')
	((counter++))
	IFS='#' read -r -a array <<< "$result"
	for element in "${array[@]}"
	do
    	sum=$(echo "$sum + $element" | bc)
	done
done

echo "$sum / $counter" | bc -l | sed 's/^\./0./'