#!/bin/bash

###########
# Comapre each piars of files within same domain and with same name.
# TEST = detect identical and simillar files
# FINAL 1 = TEST + delete identical files
# FINAL 2 = FINAL 2 + delete similar files
###########

DATA=$1

IDENTICAL=./file_identical
SIMILAR=./file_similar

SIM='0.1'

echo -n '' > $IDENTICAL
echo -n '' > $SIMILAR

# each domain
for DIR in `ls $DATA`
do
	echo -n "$DIR --- "
	
	# each name of file that are exist more then once
	NAMES=`find $DATA/$DIR -type f | sed 's/^.*\/\([^/]*\)$/\1/' | sort | uniq --repeated`
	echo -n `echo $NAMES | wc -w`
	for NAME in $NAMES
	do
		# compare all pairs
		FILES_ALL=`find $DATA/$DIR -type f | grep "/${NAME}$"`
		FILES_WORK=$FILES_ALL
		for FILE_1 in $FILES_ALL
		do
			# remove FILE_1 from work list of files, we do not compare file with it self
			FILE_1_ESCAPE=`echo $FILE_1 | sed 's/[/]/\\\&/g'`
			FILES_WORK=`echo $FILES_WORK | sed "s/$FILE_1_ESCAPE//" | sed 's/  / /'`
			
			# do not test deleted files
			### TEST and FINAL 1
			IS_DELETED=`cat $IDENTICAL | grep $FILE_1 | wc -l`
			###
			### FINAL 2
			#IS_DELETED=`cat $IDENTICAL $SIMILAR | grep $FILE_1 | wc -l`
			###
			if [ $IS_DELETED = '0' ]; then
				for FILE_2 in $FILES_WORK
				do
					# compare pair of files
					RETURN=`./is_similar.sh $SIM $FILE_1 $FILE_2 1`
					TEST=`echo $RETURN | sed 's/ .*$//'`
					VALUE=`echo $RETURN | sed 's/^.* //'`
					if [ $TEST = '2' ]; then
						### TEST and FINAL 1,2
						echo -n 'I'
						echo $FILE_2 >> $IDENTICAL
						# remove name of deleted file from work list of files
						FILE_2_ESCAPE=`echo $FILE_2 | sed 's/[/]/\\\&/g'`
						FILES_WORK=`echo $FILES_WORK | sed "s/$FILE_2_ESCAPE//" | sed 's/  / /'`
						###
						
						### FINAL 1,2
						rm $FILE_2
						###
					elif [ $TEST = '1' ]; then
						### TEST and FINAL 1,2
						echo -n 'S'
						###
						
						### TEST and FINAL 1
						echo "######################################" >> $SIMILAR
						echo -e "$FILE_1\n$FILE_2\n$VALUE" >> $SIMILAR
						echo "--------------------------------------" >> $SIMILAR
						diff $FILE_1 $FILE_2 >> $SIMILAR
						echo "--------------------------------------" >> $SIMILAR
						###
						
						### FINAL 2
						#echo $FILE_2 >> $SIMILAR
						# remove name of deleted file from work list of files
						#FILE_2_ESCAPE=`echo $FILE_2 | sed 's/[/]/\\\&/g'`
						#FILES_WORK=`echo $FILES_WORK | sed "s/$FILE_2_ESCAPE//" | sed 's/  / /'`
						#rm $FILE_2
						###
					else
						echo -n '.'
					fi
				done
			fi
		done
	done
	echo ''
done

# control (it should be empty)
echo "FILES_WORK=$FILES_WORK;"

# clean directories
find $DATA -type d -empty -delete

