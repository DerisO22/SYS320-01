#!/bin/bash 

url='http://10.0.17.6/IOC.html'
curl $url > IOC.txt

extractIOC=$(cat IOC.txt | grep -E "etc/psswd|cmd=|/bin/bash|/bin/sh|1=1#|1=1--" | sed 's/<td>\|<\/td>//g' \
 						 | sed  's/^[[:space:]]*//;s/[[:space:]]*$//')

echo "$extractIOC" > IOC.txt


