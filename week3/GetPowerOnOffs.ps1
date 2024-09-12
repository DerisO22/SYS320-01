function getPowerOns($daysBefore){
$powerOnOffs = Get-EventLog System -After (Get-Date).AddDays(-($daysBefore)) | Where {$_.EventID -eq '6005'}

$powerOnOffsTable = @()
for($i=0; $i -le $powerOnOffs.Count; $i++){
    $event = ""
    if($powerOnOffs[$i].EventId -eq '6005') {$event="PowerOn"}

    $powerOnOffsTable += [pscustomobject]@{"Time" = $powerOnOffs[$i].TimeGenerated;
                                         "Id"   = $powerOnOffs[$i].EventId;
                                         "Event"= $event;
                                         "User" = "System";
                                        }
}

return $powerOnOffsTable
}

function getShutDowns($daysBefore){
$powerOnOffs = Get-EventLog System -After (Get-Date).AddDays(-($daysBefore)) | Where {$_.EventID -eq '6006'}

$powerOnOffsTable = @()
for($i=0; $i -le $powerOnOffs.Count; $i++){
    $event = ""
    if($powerOnOffs[$i].EventId -eq '6006') {$event="PowerOff"}

    $powerOnOffsTable += [pscustomobject]@{"Time" = $powerOnOffs[$i].TimeGenerated;
                                         "Id"   = $powerOnOffs[$i].EventId;
                                         "Event"= $event;
                                         "User" = "System";
                                        }
}

return $powerOnOffsTable
}


