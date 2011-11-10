#!/bin/bash

#########
# Dowload XSLT and XSL files form the Internet.
# For founding files use:
#	- Google Search
#	- Google Code Search
#	- seeds made from founding files
#	- seeds collected by hand
#########


NAME=`basename \`pwd\``
RESULT=./${NAME}.xml
DOWNLOAD_DIR=../data_dirty

NUM_PAGES_SEARCH=10
ZEROS_SEARCH=00
NUM_PAGES_CODE=4
ZEROS_CODE=00

ADDR_SEARCH=./addresses_search
ADDR_SEEDS=./addresses_seeds
ADDR_GCODE=./addresses_googlecode
ADDR_HAND=./addresses_hand
ADDR_NONRECURSIVE=./addresses_nonrecursive
ADDR_NOT_DOWNLOAD=./addresses_not_download


LOG=./`basename $0 '.sh'`.log


# download addresses
./get_addresses_search.sh xslt $NUM_PAGES_SEARCH $ZEROS_SEARCH >> $ADDR_SEARCH
./get_addresses_search.sh xsl $NUM_PAGES_SEARCH $ZEROS_SEARCH >> $ADDR_SEARCH
./filter_addresses.sh $ADDR_SEARCH > $ADDR_NOT_DOWNLOAD

# make seeds
./make_seeds.sh $ADDR_SEARCH >> $ADDR_SEEDS

# make seeds (Google Code)
./get_addresses_code.sh xslt $NUM_PAGES_CODE $ZEROS_CODE >> $ADDR_GCODE
./get_addresses_code.sh xsl $NUM_PAGES_CODE $ZEROS_CODE >> $ADDR_GCODE


# download files
./download_recursive.sh $DOWNLOAD_DIR/hand/ $ADDR_HAND 2>> $LOG
echo 'HAND done'; echo 'HAND done' >> $LOG
./download_recursive.sh $DOWNLOAD_DIR/search/ $ADDR_SEARCH 2>> $LOG
echo 'SEARCH done'; echo 'SEARCH done' >> $LOG
./download_recursive.sh $DOWNLOAD_DIR/seeds/ $ADDR_SEEDS 2>> $LOG
echo 'SEEDS done'; echo 'SEEDS done' >> $LOG
./download_recursive.sh $DOWNLOAD_DIR/googlecode/ $ADDR_GCODE 2>> $LOG
echo 'GOOGLECODE done'; echo 'GOOGLECODE done' >> $LOG

# get aadresses from log and download
./get_addresses_not_downloaded.sh $LOG >> $ADDR_NONRECURSIVE
./download_nonrecursive.sh $DOWNLOAD_DIR/nonrecursive/ $ADDR_NONRECURSIVE 2>> $LOG
echo 'NONRECURSIVE done'; echo 'NONRECURSIVE done' >> $LOG

# delete empty directories
find $DOWNLOAD_DIR/hand/ -type d -empty -delete
find $DOWNLOAD_DIR/search/ -type d -empty -delete
find $DOWNLOAD_DIR/seeds/ -type d -empty -delete
find $DOWNLOAD_DIR/googlecode/ -type d -empty -delete
find $DOWNLOAD_DIR/nonrecursive/ -type d -empty -delete


# print report
./report.sh $DOWNLOAD_DIR

