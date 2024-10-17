function scrapePage(){
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
    return $fullTable
}

scrapePage