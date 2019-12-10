#!/bin/bash
EXECUTABLE="memsweep"
if [ ! -e $EXECUTABLE ] ; then
	cc -O -o memsweep memsweep.c -lm
fi

if [ "$SYSTEMROOT" = "C:\Windows" ] ; then
	result=$(./${EXECUTABLE}.exe | cut -d " " -f 5)
else
	result=$(./${EXECUTABLE} | cut -d " " -f 5)
fi

echo $result