#!/bin/bash

##########
# Delete files, that include wrong content.
# Do not delete invalid files included part of XSLT atc.
##########

DATA=$1
DELETE=./deleted_files


# get files for deleting
for FILE in `find $DATA -type f`
do
	COUNT=`cat $FILE | grep -E 'xsl:' | wc -l`
	if [ "$COUNT" = "0" ]; then
		echo $FILE >> $DELETE
	fi
done


# delete files
cat $DELETE | xargs rm

# deleted by hand
rm ../data/cvs.4suite.org/viewcvs/4Suite/Ft/Data/modules_html.xslt
rm ../data/cvs.4suite.org/viewcvs/4Suite/Ft/Data/Attic/resume.xslt
rm ../data/forums.dcm4che.org/jiveforums/tags/forward.xsl

# clean directories
find $DATA -type d -empty -delete