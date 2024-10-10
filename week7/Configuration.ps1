function readConfiguration(){
    $file = (join-path $PSSCriptRoot configuration.txt)
    $fileContent = Get-Content $file

    $days = $fileContent[0]
    $time = $fileContent[1]

    $table = @()
    $table += [PSCustomObject]@{
               "Days" = $days; `
               "ExecutionTime" = $time
              }
    return $table
}

function changeConfiguration(){
    $days = Read-Host "Enter number of days for which the logs will be obtained"
    
    while($days -notmatch "\d") {
        Write-Host "Invalid Input. Only enter digits. Try again`n"
        $days = Read-Host "Enter number of days for which the logs will be obtained"
    }

    $time = Read-Host "Enter the daily execution time of the script"
    
    #Didn't Know the condition for checking time format
    #while($days -notmatch "") {
    #    Write-Host "Invalid Input and/or format. Please use 'digit:digitdigit AM/PM' format`n"
    #    $time = Read-Host "Enter the daily execution time of the script"
    #}

    "$days" | Out-File -FilePath C:\Users\champuser\SYS320-01\week7\configuration.txt -Force
    "$time" | Out-File -FilePath C:\Users\champuser\SYS320-01\week7\configuration.txt -Append
}

clear

function configurationMenu(){

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Show Configuration`n"
$Prompt += "2 - Change Configuration`n"
$Prompt += "3 - Exit`n"

$operation = $true

while($operation){
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    # End Script
    if($choice -eq 3){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }
    # Choice 1
    elseif($choice -eq 1){
        Write-Host "Contents:"
        $formatTable = readConfiguration
        $formatTable | Out-String
    }
    # Choice 2
    elseif($choice -eq 2){
        changeConfiguration
        Write-Host "Configuration Changed`n"
    }
    # Invalid Input
    else {
        Write-Host "Invalid Input. Enter Number Between 1-3`n"
    }
}
}

configurationMenu