# Task 9
$scraped_page = Invoke-WebRequest -Uri http://localhost/ToBeScraped.html

$scraped_page.Links.Count

# Task 10
$scraped_page.Links

# Task 11
$scraped_page.Links | Select-Object outerText, href

# Task 12
$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText
$h2s

# Task 13
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where {$_.getAttributeNode("class").value -ilike "div-1"} | select innerText
$divs1
