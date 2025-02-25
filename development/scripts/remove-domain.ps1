Connect-MgGraph -scopes "Domain.ReadWrite.All"  -NoWelcome
Connect-ExchangeOnline

$onMicrosoft = (Get-mgdomain | where {$_.id -like "*.onmicrosoft.com"}).Id
$domains = (Get-mgdomain | where {$_.id -notlike "*.onmicrosoft.com"}).Id

Write-host -message "On Microsoft: $onMicrosoft"
Write-Host -message "Domains: $domains"

update-MgDomain -DomainID $onMicrosoft -IsDefault

foreach ($domain in $domains) {

    foreach ($user in (get-mguser -all | where-object {$_.UserPrincipalName -match $domain })) {                                                                                                   

        update-MgUser -UserId $user.id -userPrincipalName ($user.UserPrincipalName.Split("@")[0] + "@" + $onMicrosoft) -mail ($user.mail.Split("@")[0] + "@" + $onMicrosoft) -MailNickname ($user.UserPrincipalName.Split("@")[0])
    }

    #update-mgDomain -DomainId $domain -SupportedServices $null
    Remove-MgDomain -DomainId $domain
}



foreach ($user in (get-mguser -all)){                                                                                                   
    
    Write-Verbose -Message "Updating $($user.UserPrincipalName)" -verbose
    $newMail = if ($user.mail) { $user.mail.Split("@")[0] + "@" + $onMicrosoft } else { $null }
    update-MgUser -UserId $user.id -userPrincipalName ($user.UserPrincipalName.Split("@")[0] + "@" + $onMicrosoft) -mail $newMail
    
    if ($newMail) {
        Set-Mailbox -Identity $user.UserPrincipalName -EmailAddresses @{add=$newMail}
    }
}
