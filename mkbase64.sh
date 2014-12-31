#!/bin/sh

# Make base64 code of config.json of shadowsocks.
# This script will create base64 file that filename is .json filename.

# eg:mkbase64.sh $1
if [ -z $1 ];then
	echo 'Not have $1.'
	exit 1
fi

# clean .base64 file
if [ $1 = "remove" ];then
	rm -f *.base64
	exit 0
fi


JSON_FILE=$1
FILE_NAME=${JSON_FILE%.*}
BASE64_FILE=${FILE_NAME}.base64
TEMP_FILE=${FILE_NAME}.tmp

cat ${JSON_FILE} |cut -f2 -d:|cut -f1 -d,|cut -f2 -d'"'|sed -n '/[{}]/!p'|sed '3d'|sed '4d'|sed -n '1,4p' > ${TEMP_FILE} 

# Start create .base64 file
if [ -f ${BASE64_FILE} ];then
	rm -f ${BASE64_FILE}
fi

cat ${TEMP_FILE}|sed -n '4p' >> ${BASE64_FILE}
echo ':' >> ${BASE64_FILE}
cat ${TEMP_FILE}|sed -n '3p' >> ${BASE64_FILE}
echo '@' >> ${BASE64_FILE}
cat ${TEMP_FILE}|sed -n '1p' >> ${BASE64_FILE}
echo ':' >> ${BASE64_FILE}
cat ${TEMP_FILE}|sed -n '2p' >> ${BASE64_FILE}
sed -i ':a;N;s/\n//g;ta' ${BASE64_FILE}
BASE64_TEMP=`sed ':a;N;s/\n//g;ta' ${BASE64_FILE}`
echo -n $BASE64_TEMP|base64 >> ${BASE64_FILE}
sed -i 's/^/ss:\/\//g' ${BASE64_FILE}
cat ${BASE64_FILE}

rm -f *.tmp
