function ApacheLogs(){
    $file = Get-Content C:\Users\champuser\SYS320-01\midterm\access.log
    $tableRecords = @()

    for($i =0; $i -lt $file.Count; $i++){
        $words = $file[$i].Split(" ")

        $tableRecords += [PSCustomObject]@{
                         "IP" = $words[0]; `
                         "Time" = $words[3].Trim("["); `
                         "Method" = $words[5].Trim('"'); `
                         "RequestedPage" = $words[6]; `
                         "Protocol" = $words[7]; `
                         "responseCode" = $words[8]; `
                         "referrer" = $words[10]; `
                         "client" = @($words[11..($words.Count -1 )]) -join " "
        }
    }
    return $tableRecords
}

$tableRecords = ApacheLogs
$tableRecords | Format-Table -AutoSize -Wrap