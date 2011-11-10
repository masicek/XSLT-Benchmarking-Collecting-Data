#!/bin/bash

##########
# Select files tahat can be repaired.
##########

INVALID=$1

for FILE in `cat $INVALID`
do
	COUNT=`cat $FILE | grep -E '(xsl:stylesheet|xsl:transform|xsl:template)' | wc -l`
	if [ "$COUNT" != "0" ]; then
		echo $FILE
	fi
done

