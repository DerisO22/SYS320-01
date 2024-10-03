# Task 1
function gatherClasses(){
    $page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html

    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    $fullTable = @()

    for($i = 1; $i -lt $trs.length; $i++){
        $tds = $trs[$i].getElementsByTagName("td")

        $time = $tds[5].innerText.split("-")

        $fullTable += [pscustomobject]@{
                     "Class Code" = $tds[0].innerText;
                     "Title"      = $tds[1].innerText;
                     "Days"       = $tds[4].innerText;
                     "Time Start" = $time[0];
                     "Time End"   = $time[1];
                     "Instructor" = $tds[6].innerText;
                     "Location"   = $tds[9].innerText; }
    }
    return $fullTable
}

# Task 2
function daysTranslator($fullTable){
    for($i=0; $i -lt $fullTable.length; $i++){
        $Days = @()

        if($fullTable[$i].Days -ilike "M")       { $Days += "Monday" }
        if($fullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday" }
        if($fullTable[$i].Days -ilike "T")       { $Days += "Tuesday" }
        if($fullTable[$i].Days -ilike "W")       { $Days += "Wednesday" }
        if($fullTable[$i].Days -ilike "TH")      { $Days += "Thursday" }
        if($fullTable[$i].Days -ilike "F")       { $Days += "Friday" }

        $fullTable[$i].Days = $Days
    }
    return $fullTable
}