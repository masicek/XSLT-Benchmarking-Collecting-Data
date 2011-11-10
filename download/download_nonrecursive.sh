#!/bin/bash

##########
# Download files from specific address.
# Download only XSLT and XSL files.
##########

DOWNLOAD_DIR=$1
ADDR=$2

TMP=./`basename $0 '.sh'`.tmp

cat $ADDR | sed '/^#/d' | sed '/^[:blank:]*$/d' > $TMP
wget -e robots=off --no-verbose --timeout=20 --tries=1 --accept "*?.[xX][sS][lL][tT],*?.[xX][sS][lL]" --force-directories --directory-prefix=$DOWNLOAD_DIR --input-file=$TMP

rm $TMP
