function returnIPAddress($page, $httpCode, $browserName){
    $pages = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()

    for($i = 0; $i -lt $pages.Count; $i++){
        $words = $pages[$i].Split(" ")
            
        $ip = $words[0]
        $time = $words[3].Trim('[')
        $method = $words[5].Trim('"')
        $requestedPage = $words[6]
        $protocol = $words[7]
        $responseCode = $words[8]
        $referrer = $words[10]
        $client = @($words[11..($words.Count - 1)]) -join " "
    
        if($requestedPage -like "*$page*" -and $responseCode -eq $httpCode -and $client -like "*$browserName*") {
            $tableRecords += $ip
        }
    }

    $counts = $tableRecords | Group-Object | Sort-Object Count -Descending
    return $counts
}

