#!/bin/bash

###########
# Return 1 if input files are simmilar.
# Return 2 if input files are identical.
# Othervise return 0.
###########

SIM=$1 # tipical 0.1
FIRST=$2
SECOND=$3
PRINT_VALUE=$4

LINES_ALL=`cat $FIRST $SECOND | wc -l`
LINES_DIFF=`diff $FIRST $SECOND | grep -P '(<|>)' | wc -l`
SIMILARITY=`echo "scale=2;${LINES_DIFF}/(${LINES_ALL}+2)" | bc`

IS_SIMILAR=`echo "$SIMILARITY < $SIM" | bc`

if [ $SIMILARITY = '0' ]; then
	echo 2;
else
	echo $IS_SIMILAR
fi

if [ $PRINT_VALUE ]; then
	echo $SIMILARITY
fi