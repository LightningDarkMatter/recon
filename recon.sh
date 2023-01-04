#!/bin/bash
PATN_TO_DIRSEARCH="-Where file is saved-"
TODAY=$(date)
echo "This scan was created on $TODAY"
DOMAIN=$1
DIRECTORY=${DOMAIN}_recon
echo "Creating directory $DIRECTORY."
mkdir $DIRECTORY
case $2 in
    nmap-only)
        nmap $DOMAIN > $DIRECTORY/nmap
        echo "The results of nmap scan are stored in $DIRECTORY/nmap."\
        ;;
    dirsearch-only
        $PATH_TO_DIRSEARCH/dirseach.py -u $DOMAIN -e php --simple-report=$DIRECTORY/dirsearch
        echo "The results of dirsearch scan are stored in $DIRECTORY/dirsearch."
        ;;
    crt-only)
        curl "https://crt.sh/?=q$DOMAIN&output=json" -o $DIRECTORY/crt
        echo "The results of cert parsing is stored in $DIRECTORY/crt."
        ;;
    *)
        nmap $DOMAIN > $DIRECTORY/nmap
        echo "The results of nmap scan are stored in $DIRECTORY/nmap."
        $PATH_TO_DIRSEARCH/dirseach.py -u $DOMAIN -e php --simple-report=$DIRECTORY/dirsearch
        echo "The results of dirsearch scan are stored in $DIRECTORY/dirsearch."
        curl "https://crt.sh/?=q$DOMAIN&output=json" -o $DIRECTORY/crt
        echo "The results of cert parsing is stored in $DIRECTORY/crt."
        ;;
esac