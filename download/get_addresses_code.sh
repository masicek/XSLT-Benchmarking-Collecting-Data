#!/bin/bash

##########
# Found addresses with extensions $EXT from the Internet.
# Using Google Code Search for found them.
##########

EXT=$1
NUM_PAGES=$2
ZEROS=$3

TMP=./`basename $0 '.sh'`.tmp

# download search result from google for "label:$EXT"
for (( I=0; I<$NUM_PAGES; I++ ))
do
	w3m -dump_source "http://code.google.com/hosting/search?q=label:$EXT&start=${I}${ZEROS}&num=1${ZEROS}&filter=0" >> $TMP
done

# make list of addresses
./select_addresses_code.sh $TMP
rm $TMP
