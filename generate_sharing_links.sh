#!/bin/bash
# 
# Script to generate web sharing links from a non public directory
#

# Variables
WEB_ROOT="https://your.site.com"
FILE_ROOT="/var/www/site"
SHARED_FOLDER="subfolder"
DATE=$(date +%Y%m%d%H%M%S)
OUT_FILE="/tmp/shared_links_${DATE}.txt"

# Functions

GenerateLinks(){
	folder=${FILE_ROOT}/${SHARED_FOLDER}/$1
	echo In to $folder
	if [ -d ${folder} ];then
		for file in $(ls "${folder}");do
			if [ -d ${folder}/$file ];then
				echo Go to folder $file
				GenerateLinks $1/$file
			else
				echo "${WEB_ROOT}/${SHARED_FOLDER}/$1/${file}" >> $OUT_FILE
			fi
		done
	else
		echo "ERR: ${folder} is not a folder"	
	fi
}

DisplayLinks (){
	echo "############### Link list from ${FILE_ROOT}${SHARED_FOLDER} ###############"
	cat $OUT_FILE
}

# Program
GenerateLinks
DisplayLinks
