#!/bin/bash

function processLogs(){
	local logFile=$1
	local iocFile=$2

	:> report.txt

    iocLogs=$(egrep -i -f "$iocFile" "$logFile" | cut -d' ' -f1,4,7 | tr -d '[')
    
    echo "$iocLogs" > report.txt
    cat report.txt
}

processLogs "$1" "$2"
