.(Join-Path $PSScriptRoot scrapingClasses.ps1)

$fullTable = gatherClasses
#$fullTable

$daysFormatTable = daysTranslator $fullTable
$daysFormatTable

# Task 3
$fullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | where {$_."Instructor" -ilike "*Furkan*"}

# Task 4
$fullTable | Where-Object {($_.Location -ilike "JOYC 310") -and ($_.Days -contains "Monday")} | Sort-Object "Time Start" | Select-Object "Time Start", "Time End", "Class Code"

# Task 5
$ITSInstructors = $fullTable | Where-Object {($_."Class Code" -ilike "SYS*") -or
                                             ($_."Class Code" -ilike "NET*") -or
                                             ($_."Class Code" -ilike "SEC*") -or
                                             ($_."Class Code" -ilike "FOR*") -or
                                             ($_."Class Code" -ilike "CSI*") -or
                                             ($_."Class Code" -ilike "DAT*") } | select "Instructor" | Sort-Object "Instructor" -Unique
#$ITSInstructors

# Task 6
$fullTable | Where {$_.Instructor -in $ITSInstructors.Instructor} `
           | Group-Object "Instructor"  `
           | Select-Object Count,Name   `
           | Sort-Object Count -Descending