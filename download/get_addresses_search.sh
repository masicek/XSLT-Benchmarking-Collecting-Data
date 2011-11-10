#!/bin/bash

##########
# Found addresses with extensions $EXT from the Internet.
# Using Google Search for found them.
##########

EXT=$1
NUM_PAGES=$2
ZEROS=$3

TMP=./`basename $0 '.sh'`.tmp

# download search result from google for "filetype:$EXT"
for (( I=0; I<$NUM_PAGES; I++ ))
do
	w3m -dump_source "http://www.google.com/search?q=filetype:$EXT&start=${I}${ZEROS}&num=1${ZEROS}&filter=0" >> $TMP
done

# make list of addresses
./select_addresses_search.sh $TMP $EXT
rm $TMP
