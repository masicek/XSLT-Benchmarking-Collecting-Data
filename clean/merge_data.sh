#!/bin/bash

###########
# Merge downloaded data into ine directory.
# Repare non standart name.
# Repare EOL.
###########

NAME=`basename \`pwd\``
RESULT=./${NAME}.xml

DATA_DIRTY=$1
MERGE=$2

DOUBLE_FILES=./double_files

TMP=./`basename $0 '.sh'`.tmp

# copy with backup
mkdir $MERGE
cp --suffix=.backup --recursive $DATA_DIRTY/hand/* $MERGE
cp --suffix=.backup --recursive $DATA_DIRTY/search/* $MERGE
cp --suffix=.backup --recursive $DATA_DIRTY/seeds/* $MERGE
cp --suffix=.backup --recursive $DATA_DIRTY/nonrecursive/* $MERGE


# repare name with space
mv "$MERGE/www.caubo.ca/fedora/repository/object_download/caubo:university_managers/COLLECTION_VIEW/Collection View.xsl" $MERGE/www.caubo.ca/fedora/repository/object_download/caubo:university_managers/COLLECTION_VIEW/Collection_View.xsl
mv "$MERGE/www.caubo.ca/fedora/repository/caubo:university_managers/COLLECTION_VIEW/Collection View.xsl.backup" $MERGE/www.caubo.ca/fedora/repository/caubo:university_managers/COLLECTION_VIEW/Collection_View.xsl.backup
mv "$MERGE/www.caubo.ca/fedora/repository/caubo:university_managers/COLLECTION_VIEW/Collection View.xsl" $MERGE/www.caubo.ca/fedora/repository/caubo:university_managers/COLLECTION_VIEW/Collection_View.xsl
mv "$MERGE/www.osteopathic.org/Style Library" $MERGE/www.osteopathic.org/Style_Library
mv "$MERGE/alttext.googlecode.com/svn/trunk/tests/xlst/inline elements" $MERGE/alttext.googlecode.com/svn/trunk/tests/xlst/inline_elements
mv "$MERGE/www.aadi.no/Aanderaa/Products/RealTime/PictureLib/1/Realtimeweb Stylesheet.xslt" $MERGE/www.aadi.no/Aanderaa/Products/RealTime/PictureLib/1/Realtimeweb_Stylesheet.xslt
mv "$MERGE/www.hannonhill.com/kb/cast -DO NOT PUBLISH" $MERGE/www.hannonhill.com/kb/cast_-DO_NOT_PUBLISH
mv "$MERGE/www.fieldds.com/xslt/In (copy).xslt" $MERGE/www.fieldds.com/xslt/In__copy_.xslt


# repare end of lines
./repare_eol.sh $MERGE


# delte backup files
find $MERGE -type f -regex '.*\.backup' > $DOUBLE_FILES
for BACKUP in `find $MERGE -type f -regex '.*\.backup'`
do
	FILE=`echo $BACKUP | sed 's/[.]backup$//'`
	diff $FILE $BACKUP > /dev/null
	RV=$?
	
	if [ "$RV" != "0" ]; then
		echo $FILE >> $TMP
		diff $FILE $BACKUP >> $TMP
	fi
done
##############################
# look into TMP file by hand #
##############################
# major the part of differences are insignificant, so we can delete backup files
find $MERGE -type f -regex '.*\.backup' -delete
rm $TMP

