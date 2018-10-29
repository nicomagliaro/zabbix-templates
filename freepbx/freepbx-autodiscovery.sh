#!/bin/bash
# Author: Nicolas Magliaro
# Created: 26/10/2018

export PATH=${PATH}:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin

set -e

if [[ $# -eq 0 ]] ; then
    echo 'USAGE: $0 {args} trunks|peers'
    exit 1
fi

OPCION="$1"

case "$OPCION" in
  "trunks")
	echo "{"
	echo '    "data":['
	FIRST=1

	while read line; do
    		if [ $FIRST != 0 ]; then
        		FIRST=0
    		else
        OUTPUT="{ \"{#TNAME}\":\"$NAME\" , \"{#TSTATE}\":\"$STATE\" },"
        echo "        $OUTPUT"
    		fi
    		NAME=$(echo "$line" | awk '{print $1}' | cut -f1 -d":")
    		STATE=$(echo "$line" | awk '{print $2}')
	done <<< "$(sudo -n -u root asterisk -r -x "sip show registry" | awk '{ print $1, $5 }' | sed '1,1d; $d')"
	OUTPUT="{ \"{#TNAME}\":\"$NAME\" , \"{#TSTATE}\":\"$STATE\" }"
	echo "        $OUTPUT"
	echo '    ]'
	echo "}"

    ;;
  "peers")
	echo "{"
	echo '    "data":['
	FIRST=1
 
	while read line; do
    		if [ $FIRST != 0 ]; then
        		FIRST=0
    		else
        OUTPUT="{ \"{#PNAME}\":\"$NAME\" , \"{#PSTATE}\":\"$STATE\" },"
        echo "        $OUTPUT"
    		fi
    		NAME=$(echo "$line" | awk '{print $1}' | cut -f1 -d"/")
    		STATE=$(echo "$line" | awk '{print $2}')
	done <<< "$(sudo -n -u root asterisk -r -x "sip show peers" | awk '{ if($3 =="D" ){print $1, $8 }}' | sed '1,1d')"
	OUTPUT="{ \"{#PNAME}\":\"$NAME\" , \"{#PSTATE}\":\"$STATE\" }"
	echo "        $OUTPUT"
	echo '    ]'
	echo "}"
  ;;
  "peer")
    PEER=$2
    STATUS=$(sudo -n -u root asterisk -r -x "sip show peer $PEER" | grep Status | awk '{print $3}')
    echo $STATUS
  ;;
  "trunk")
    TRUNK=$2
    STATUS=$(sudo -n -u root asterisk -r -x "sip show registry" |  grep $TRUNK | awk '{print $5}')
    echo $STATUS
  ;;
  *)
   	echo "ZBX_NOTSUPPORTED"
  ;;
esac
