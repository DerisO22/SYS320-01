function pageApacheLogs(){
    #Page Scraping
    $scrapedPage = Invoke-WebRequest -Uri http://10.0.17.5/IOC.html
    $trs = $scrapedPage.ParsedHtml.body.getElementsByTagName("tr")

    $scrapedPage = Invoke-WebRequest -Uri http://10.0.17.5/IOC.html
    
    $trs = $scrapedPage.ParsedHtml.body.getElementsByTagName("tr")

    $fullTable = @()

    for($i = 1; $i -lt $trs.length; $i++){
        $tds = $trs[$i].getElementsByTagName("td")

        $fullTable += [PSCustomObject]@{
                      "Pattern" = $tds[0].innerText; `
                      "Explaination" = $tds[1].innerText 
                      }
    }

    #Apache Logs and check page properties
    $file = Get-Content C:\Users\champuser\SYS320-01\midterm\access.log
    $tableRecords = @()

    for($i=0; $i -lt $file.Count; $i++){
        $words = $file[$i].Split(" ") 

        $pattern1 = $fullTable[0].Pattern
        $pattern2 = $fullTable[1].Pattern
        $pattern3 = $fullTable[2].Pattern
        $pattern4 = $fullTable[3].Pattern
        $pattern5 = $fullTable[4].Pattern
        $pattern6 = $fullTable[5].Pattern
        
        if(($words[6] -ilike "*$pattern1*") -or ($words[6] -ilike "*$pattern2*") -or ($words[6] -ilike "*$pattern3*") -or ($words[6] -ilike "*$pattern4*") -or ($words[6] -ilike "*$pattern5*") -or ($words[6] -ilike "*$pattern6*")){
        $tableRecords += [PSCustomObject]@{
                         "IP" = $words[0]; `
                         "Time" = $words[3].Trim("["); `
                         "Method" = $words[5].Trim('"'); `
                         "RequestedPage" = $words[6]; `
                         "Protocol" = $words[7]; `
                         "responseCode" = $words[8]; `
                         "referrer" = $words[10]; `
                         "client" = @($words[11..($words.Count -1 )]) -join " " }
        }
    }
    return $tableRecords
}

$tableRecords = pageApacheLogs
$tableRecords | Format-Table -AutoSize -Wrap