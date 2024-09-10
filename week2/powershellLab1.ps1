# Task 1
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet0"}).IPAddress

# Task 2
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet0"}).PrefixLength

# Task 3/4
Get-WmiObject -List | Where-Object {$_.Name -ilike "Win32_Net*"} | Sort-Object

# Task 5/6
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled = $true" | select IPAddress | Format-Table -HideTableHeaders

# Task 7
(Get-DnsClientserverAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet0"}).ServerAddresses[0]

# Part 2 - Directory Listings:
# Task 8
cd $PSScriptRoot

$files = (Get-ChildItem)
for($j = 0; $j -le $files.count; $j++){
    if($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}

# Task 9
$folderPath = "$PSScriptRoot\outfolder"
if(Test-Path $folderPath){
    Write-Host "Folder Already Exists"
} else {
    New-Item -ItemType Directory -Path $folderPath
}

# Task 10
cd $PSScriptRoot
$files = (Get-ChildItem)

$folderPath = "$PSScriptRoot/outfolder/"
$filePath = Join-Path $folderPath "out.csv"

$files | Where-Object {$_.Extension -eq ".ps1"} | Export-Csv -Path $filePath

# Task 11
$files = Get-ChildItem -Recurse -File
$files | Rename-item -NewName {$_.Name -replace '.csv', '.log'}
Get-ChildItem -Recurse -File
