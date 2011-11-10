#!/bin/bash

##########
# Select non downloaded addresses from log file.
##########

SRC=$1

# example
# 	in log file:		2010-11-28 21:20:43 URL:http://cvs.4suite.org/viewcvs/uogbuji/Attic/opml2xbel.xsl?rev=1.4&view=log [6939] -> "../data/hand/cvs.4suite.org/viewcvs/uogbuji/Attic/opml2xbel.xsl?rev=1.4&view=log" [1]
# 	selected address:	http://cvs.4suite.org/viewcvs/uogbuji/Attic/opml2xbel.xsl
cut -f3 -d' ' ./all.log | grep '\.xslt?' | sed 's/URL://' | sed 's/[.]xslt[?].*$/.xslt/' | sort | uniq
cut -f3 -d' ' ./all.log | grep '\.xsl?' | sed 's/URL://' | sed 's/[.]xsl[?].*$/.xsl/' | sort | uniq | less


# example
# 	in log file:		2010-12-13 17:52:46 URL:http://xml.mfd-consult.dk/foaf/explorer/?foaf=http://www.w3.org/2005/08/online_xslt/xslt?xslfile=http://www.kanzaki.com/info/twitter2foaf.xsl%26xmlfile=http://twitter.com/statuses/friends/markbirbeck.xml%26content-type=application/rdf%2Bxml [399198/399198] -> "../data_dirty/seeds/xml.mfd-consult.dk/foaf/explorer/index.html?foaf=http:%2F%2Fwww.w3.org%2F2005%2F08%2Fonline_xslt%2Fxslt?xslfile=http:%2F%2Fwww.kanzaki.com%2Finfo%2Ftwitter2foaf.xsl&xmlfile=http:%2F%2Ftwitter.com%2Fstatuses%2Ffriends%2Fmarkbirbeck.xml&content-type=application%2Frdf+xml" [1]
# 	selected address:	http://www.kanzaki.com/info/twitter2foaf.xsl
cut -f3 -d' ' ./all.log | grep 'xslfile=' | sed 's/^.*xslfile=\([^%& ]*\)[%& ].*$/\1/' | sed 's/^.*xslfile=\(.*\)$/\1/' | sort | uniq
 