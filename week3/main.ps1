.(Join-Path $PSScriptRoot getLogOn.ps1)
.(Join-Path $PSScriptRoot GetPowerOnOffs.ps1)

clear

$loginoutsTable = getLogInOuts 15
$loginoutsTable

$shutdownsTable = getShutDowns 25
$shutdownsTable

$startupsTable = getPowerOns 25
$startupsTable