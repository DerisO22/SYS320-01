.(Join-Path $PSScriptRoot Apache-Logs.ps1)
.(Join-Path $PSScriptRoot parsing_Logs.ps1)

$tableRecords = returnIPAddress "index.html" 200 "Mozilla"
$tableRecords | Format-Table Count, Name -AutoSize -Wrap

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap