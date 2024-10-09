function ApacheLogs1(){
    $logsNotFormatted = Get-Content C:\xampp\apache\logs\access.log
    
    $tableRecords = @()

    for($i = 0; $i -lt 10; $i++){
        $words = $logsNotFormatted[$i].Split(" ")

        $tableRecords += [PSCustomObject]@{ "IP" = $words[0]; `
                                            "Time" = $words[3].Trim("["); `
                                            "Method" = $words[5].Trim('"'); `
                                            "RequestedPage" = $words[6]; `
                                            "Protocol" = $words[7]; `
                                            "responseCode" = $words[8]; `
                                            "referrer" = $words[10]; `
                                            "client" = @($words[11..($words.Count - 1)]) -join " "
                                          }
    }
    return $tableRecords
}

function getFailedLogins($timeBack){
  
  $failedlogins = Get-EventLog security -After (Get-Date).AddDays("-"+"$timeBack") | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }

    }

    return $failedloginsTable
} # End of function getFailedLogins