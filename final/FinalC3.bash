#!/bin/bash

logFile="report.txt"
allLogs=$(cat "$logFile")

:> report.html

echo "<html><head><title>Indicators of Compromise</title><style>table, th, td {border: 1px solid black;}</style></head><body><p>Access Logs with IOC Indicators:</p><br><table>" >> report.html

#Loop Through Report

echo "$allLogs" | while read -r line;
do
	echo "<tr>" >> report.html
	
	ipAddress=$(echo "$line" | cut -d" " -f1)
	date=$(echo "$line" | cut -d" " -f2)
	ioc=$(echo "$line" | cut -d" " -f3)

	echo "<td>$ipAddress</td><td>$date</td><td>$ioc</td>" >> report.html
	echo "</tr>" >> report.html
done

echo "</table></body></html>" >> report.html

sudo mv report.html /var/www/html/
