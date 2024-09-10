#Lab 2
# Task 1
Get-Process | Where-Object {$_.Name -ilike 'C*'}

# Task 2
Get-Process | Where-Object {$_.Path -notlike 'system32*'}

# Task 3
Get-Service | Where-Object {$_.Status -eq 'Stopped'} | Sort-Object DisplayName | Export-Csv -Path "$PSScriptRoot/StoppedServices.csv" -NoTypeInformation

# Task 4
$chrome = Get-Process | Where-Object {$_.Name -eq 'chrome'}

if($chrome){
    Stop-Process -Name 'chrome' -Force
} else {
    Start-Process "chrome.exe" -ArgumentList "https://www.champlain.edu"
}