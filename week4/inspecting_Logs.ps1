#Task 3
Get-Content C:\xampp\apache\logs\access.log

#Task 4
Get-Content C:\xampp\apache\logs\access.log -Tail 5

#Task 5
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

#Task 6
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

#Task 7
$A = Get-ChildItem -Path C:\xampp\apache\logs\*.log | Select-String -allmatches 'error'
$A[-5..-1]

#Task 8
$notFounds = Get-Content -Path C:\xampp\apache\logs\access.log | Select-String ' 404 '

$regex = [regex] "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"

$ipsUnorganized = $regex.Matches($notFounds)

$ips = @()
for($i = 0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;}
}
$ips | Where-Object {$_.IP -ilike "10.*"}

#Task 9
$ipsoftens = $ips | Where-Object {$_.IP -ilike "10.*"}
$counts = $ipsoftens | Group-Object -Property IP
$counts | Select-Object Count, Name

