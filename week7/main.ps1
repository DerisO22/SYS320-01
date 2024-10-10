. "C:\Users\champuser\SYS320-01\week6\localUserManage\Event-Logs.ps1"
. "C:\Users\champuser\SYS320-01\week7\Email.ps1"
. "C:\Users\champuser\SYS320-01\week7\Configuration.ps1"
. "C:\Users\champuser\SYS320-01\week7\Scheduler.ps1"

$configuration = readConfiguration

#Didn't create a function AtRiskUsers in previous assignment
$userLogins = getFailedLogins $timeSince
$Failed = $userLogins | Group-Object -Property User | Where-Object {$_.Count -gt 10}

SendAlertEmail ($Failed | Format-Table | Out-String)

ChooseTimeToRun($configuration.ExecutionTime)