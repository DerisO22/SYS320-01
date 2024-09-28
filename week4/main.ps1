.(Join-Path $PSScriptRoot Apache-Logs.ps1)

$tableRecords = returnIPAddress "index.html" 200 "Mozilla"
$tableRecords | Format-Table Count, Name -AutoSize -Wrap