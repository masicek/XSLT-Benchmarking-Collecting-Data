#!/bin/bash

##########
# Download files from specific address and their children.
# Download only XSLT and XSL files.
##########

DOWNLOAD_DIR=$1
ADDR=$2

# domains that were excluded during downloading (they had small efficienci, then we shipped them)
#EXCLUDE_DOMAINS='code.google.com,botanyfree.appspot.com,cvs.4suite.org,h41105.www4.hp.com,billstatus.ls.state.ms.us,mundogeek.net,people.apache.org,quexml.svn.sourceforge.net,slps.svn.sourceforge.net,svn.berlios.de,svn.openlaszlo.org,tecfa.unige.ch,www.abc.net.au,www.dmg.org,www.dr.dk,www.elanso.com,www.ibiblio.org,www.liveinternet.ru,www.loc.gov,www.nea.org,www.parade.com,www.sfu.ca,www.vh1.com,www.who.int,www.window.state.tx.us,xml.mfd-consult.dk,yactayo.com'
EXCLUDE_DOMAINS=''

TMP=./`basename $0 '.sh'`.tmp

cat $ADDR | sed '/^#/d' | sed '/^[:blank:]*$/d' > $TMP
wget -e robots=off --no-verbose --timeout=20 --tries=1 --recursive --no-parent --level=20 --accept "*?.[xX][sS][lL][tT],*?.[xX][sS][lL]" --exclude-domains "$EXCLUDE_DOMAINS" --directory-prefix=$DOWNLOAD_DIR --input-file=$TMP
rm $TMP
