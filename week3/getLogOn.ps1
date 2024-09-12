function getLogInOuts($daysBefore){
$loginouts = Get-EventLog System -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-($daysBefore))

$loginoutsTable = @()
for($i=0; $i -le $loginouts.Count; $i++){
    $event = ""
    if($loginouts[$i].EventId -eq '7001') {$event="Logon"}
    if($loginouts[$i].EventId -eq '7002') {$event="Logoff"}

    $user = (New-Object System.Security.Principal.SecurityIdentifier $loginouts[$i].ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount]) 
    $loginouts[$i].ReplacementStrings[1]

    $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                         "Id"   = $loginouts[$i].EventId;
                                         "Event"= $event;
                                         "User" = $user;
                                        }
}

return $loginoutsTable
}
