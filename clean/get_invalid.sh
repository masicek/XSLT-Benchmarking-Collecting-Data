#!/bin/bash

###########
# Test validations of data.
# Return names of invalid files.
###########

DATA=$1
SUFFIX=$2
LOG=./`basename $0 '.sh'`_${SUFFIX}.log
RESULT=./`basename $0 '.sh'`_${SUFFIX}.result

for FILE in `find $DATA -type f`
do
	echo $FILE >> $LOG
	xmllint $FILE 2>> $LOG > /dev/null
	RV=$?
	echo "----------------------------------------------" >> $LOG
	
	if [ "$RV" = "0"  ]; then
		echo "$FILE VALID" >> $RESULT
	else
		echo "$FILE INVALID $RV" >> $RESULT
	fi
	
done

cat $RESULT | grep 'INVALID' | sed 's/ INVALID.*$//'