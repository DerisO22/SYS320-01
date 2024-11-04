#!bin/bash

results=""
file="/var/log/apache2/access.log"

function pageCount(){
	results=$(cat "$file" | grep "page2.html" | cut -d' ' -f1,7 | tr -d "[")
}

pageCount
echo "$results" | grep "page2.html"
