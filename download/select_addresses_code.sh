#!/bin/bash

##########
# From Google Code Search select only found url.
##########

SEARCH=$1

cat $SEARCH | 
grep 'href="/p/' | 
sed 's/.*href="\/p\/\([^/]*\)\/".*/\1/g' |
sort | 
uniq | 
sed 's/^\(.*\)$/http:\/\/\1.googlecode.com\/svn\//'