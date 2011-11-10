#!/bin/bash

##########
# Make seeds for downloading for wget.
# From each address make two seeds.
# Example:
#	http://www.site.com/first/sedond/doc.xsl
#		--> http://www.site.com/
#		--> http://www.site.com/first/
##########

ADDR=$1

cat $ADDR | 
sed 's/[^/]*$//' | 
sed 's/^\(http:\/\/[^/]*\)\/\([^/]*\)\/.*$/\1\/\n\1\/\2\//' | 
sort | 
uniq
