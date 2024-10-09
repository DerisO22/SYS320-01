.(Join-Path $PSScriptRoot functions.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Display Last 10 Apache Logs`n"
$Prompt += "2 - Display Last 10 Failed Logins for All Users`n"
$Prompt += "3 - Display at Risk Users`n"
$Prompt += "4 - Open Chrome and go to www.champlain.edu`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    # End Script
    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }
    # Choice 1
    elseif($choice -eq 1){
        Write-Host "Apache Logs:`n"
        $tableRecords = ApacheLogs1
        $tableRecords | Format-Table -AutoSize -Wrap
    }
    # Choice 2
    elseif($choice -eq 2){
        $timeSince = Read-Host -Prompt "Please enter the number of days to search back"
        $userLogins = getFailedLogins $timeSince

        $failedLogins = $userLogins | Sort-Object Time -Descending

        $lastTenFailed = $failedLogins | Select-Object -First 10

        if($lastTenFailed.Count -gt 0){
            Write-Host "Last 10 Failed Logins For all Users:`n"
            $lastTenFailed | Format-Table Time, User, Event, ID
        } else {
            Write-Host "There were no Failed Logins in the past $timeSince days"
        }
    }
    # Choice 3
    elseif($choice -eq 3){
        $timeSince = Read-Host -Prompt "Please enter the number of days to search back"
        $userLogins = getFailedLogins $timeSince

        $riskUser = $userLogins | Group-Object -Property User | Where-Object {$_.Count -gt 10}

        if($riskUser.Count -gt 0){
            Write-Host "At Risk users:`n"
            $riskUser | Format-Table Name, Count
        } else {
            Write-Host "There were no At Risk Users in the past $timeSince days`n"
        }
    }
    # Choice 4
    elseif($choice -eq 4){
        $chrome = Get-Process | Where-Object {$_.Name -eq 'chrome'}

        if($chrome){
            Write-Host "Closed already opened chrome tab`n"
            Stop-Process -Name 'chrome' -Force
        } else {
            Write-Host "Chrome opened`n"
            Start-Process "chrome.exe" -ArgumentList "https://www.champlain.edu"
        }
    }
    # Invalid Input
    else {
        Write-Host "Invalid Input. Enter Number Between 1-5`n"
    }
}