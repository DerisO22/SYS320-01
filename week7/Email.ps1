function SendAlertEmail($Body){
    $From = "deris.omalley@mymail.champlain.edu"
    $To = "deris.omalley@mymail.champlain.edu"
    $Subject = "Suspicious Activity"

    $Password = "hjtz ggqv moah jlbq" | ConvertTo-SecureString -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
    -port 587 -UseSsl -Credential $Credential
}

SendAlertEmail "Body of Email"