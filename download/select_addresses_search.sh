#!/bin/bash

##########
# From Google Search select only found url.
##########

SEARCH=$1
EXT=$2

cat $SEARCH | 
tr -d '\n' | 
sed 's/<h3 class=r><a href="/\n---BEGIN---/g' | 
sed 's/<h3 class="r"><a href="/\n---BEGIN---/g' | 
sed "s/\(---BEGIN---http[^\"]*$EXT\)/\1---END---\n/g" | 
grep -e '^---BEGIN---.*---END---$' | 
sed 's/---BEGIN---//' | 
sed 's/---END---//' |
sort |
uniq
