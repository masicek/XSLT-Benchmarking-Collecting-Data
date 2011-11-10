#!/bin/bash

NAME=`basename \`pwd\``
RESULT=./${NAME}.xml

DOWNLOAD_DIR=$1


# print report
echo -e '<?xml version="1.0" encoding="UTF-8"?>' > $RESULT
echo -e "<$NAME>" >> $RESULT
	echo -e "\t<hand>" >> $RESULT
		echo -e "\t\t<addresses>`cat addresses_hand | sed '/^#/d' | sed '/^[:blank:]*$/d' | wc -l`</addresses>" >> $RESULT
		echo -e "\t\t<xslt>`find $DOWNLOAD_DIR/hand/ -type f -regex '.*xslt' | wc -l`</xslt>" >> $RESULT
		echo -e "\t\t<xsl>`find $DOWNLOAD_DIR/hand/ -type f -regex '.*xsl' | wc -l`</xsl>" >> $RESULT
	echo -e "\t</hand>" >> $RESULT
	echo -e "\t<search>" >> $RESULT
		echo -e "\t\t<addresses>`cat addresses_search | sed '/^#/d' | sed '/^[:blank:]*$/d' | wc -l`</addresses>" >> $RESULT
		echo -e "\t\t<xslt>`find $DOWNLOAD_DIR/search/ -type f -regex '.*xslt' | wc -l`</xslt>" >> $RESULT
		echo -e "\t\t<xsl>`find $DOWNLOAD_DIR/search/ -type f -regex '.*xsl' | wc -l`</xsl>" >> $RESULT
	echo -e "\t<search>" >> $RESULT
	echo -e "\t<seeds>" >> $RESULT
		echo -e "\t\t<addresses>`cat addresses_seeds | sed '/^#/d' | sed '/^[:blank:]*$/d' | wc -l`</addresses>" >> $RESULT
		echo -e "\t\t<xslt>`find $DOWNLOAD_DIR/seeds/ -type f -regex '.*xslt' | wc -l`</xslt>" >> $RESULT
		echo -e "\t\t<xsl>`find $DOWNLOAD_DIR/seeds/ -type f -regex '.*xsl' | wc -l`</xsl>" >> $RESULT
	echo -e "\t</seeds>" >> $RESULT
	echo -e "\t<googlecode>" >> $RESULT
		echo -e "\t\t<addresses>`cat addresses_googlecode | sed '/^#/d' | sed '/^[:blank:]*$/d' | wc -l`</addresses>" >> $RESULT
		echo -e "\t\t<xslt>`find $DOWNLOAD_DIR/googlecode/ -type f -regex '.*xslt' | wc -l`</xslt>" >> $RESULT
		echo -e "\t\t<xsl>`find $DOWNLOAD_DIR/googlecode/ -type f -regex '.*xsl' | wc -l`</xsl>" >> $RESULT
	echo -e "\t</googlecode>" >> $RESULT
	echo -e "\t<nonrecursive>" >> $RESULT
		echo -e "\t\t<addresses>`cat addresses_nonrecursive | sed '/^#/d' | sed '/^[:blank:]*$/d' | wc -l`</addresses>" >> $RESULT                                                                                                                        
		echo -e "\t\t<xslt>`find $DOWNLOAD_DIR/nonrecursive/ -type f -regex '.*xslt' | wc -l`</xslt>" >> $RESULT
		echo -e "\t\t<xsl>`find $DOWNLOAD_DIR/nonrecursive/ -type f -regex '.*xsl' | wc -l`</xsl>" >> $RESULT
	echo -e "\t<nonrecursive>" >> $RESULT
echo -e "</$NAME>" >> $RESULT
                                                                                                                        