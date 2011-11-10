#!/bin/bash

##########
# Merge downloaded dirty data and test on validation.
# Try correct non valid files by hand.
# Finaly, delete non correct files.
##########

NAME=`basename \`pwd\``
DATA=../data
DATA_DIRTY=../data_dirty

INVALID=./files_invalid
INVALID_FINAL=./files_invalid_final
FOR_REPAIR=./files_for_repair

SIMILARITY=./similarity_report

# merge dirty data
./merge_data.sh $DATA_DIRTY $DATA


# select invalid files
./get_invalid.sh $DATA first > $INVALID
# select files, that can be XSLT file with some mistakes
./get_invalid_for_repair.sh $INVALID > $FOR_REPAIR
###########################
# repare mistakes by hand #
###########################
echo "repare mistakes by hand !!!"


# delete non XSLT files from DATA
#./delete_non_xslt.sh $DATA

# control
#./get_invalid.sh $DATA final > $INVALID_FINAL

# delete identical files
#./similarity.sh $DATA > $SIMILARITY
