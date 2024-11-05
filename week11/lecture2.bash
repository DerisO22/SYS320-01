#!bin/bash

allLogs=""
logFile="/var/log/apache2/access.log"

countingCurlAccess() {
    allLogs=$(grep "curl" "$logFile" | cut -d' ' -f1,2 | paste -d' ' - <(grep "curl" "$logFile" | grep -o "curl/[0-9.]*") | sort | uniq -c)
}

countingCurlAccess
echo "$allLogs"

