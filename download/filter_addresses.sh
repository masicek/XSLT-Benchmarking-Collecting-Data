#!/bin/bash

##########
# Filter non presective addresses.
##########

ADDR=$1

TMP=./`basename $0 '.sh'`.tmp


# fmi -- downloaded document are tipicaly html
#        and have to many children for recursive download
cat $ADDR | grep '/fmi/'
cat $ADDR | grep -v '/fmi/' > $TMP
cat $TMP > $ADDR
rm $TMP


