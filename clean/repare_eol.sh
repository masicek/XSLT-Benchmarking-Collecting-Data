#!/bin/bash

DATA=$1

TMP=./`basename $0 '.sh'`.tmp

# repare end of lines
for FILE in `find $DATA -type f`
do
	cat "$FILE" | sed 's/\r//' > $TMP
	cat $TMP > "$FILE"
done
rm $TMP
