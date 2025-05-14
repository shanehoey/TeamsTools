

Connect-MgGraph -Scopes "User.ReadWrite.All"    
 
### Update Domain Current Useres 
$filter = "(assignedLicenses/any(x:x/skuId eq $($TeamsEnterpriseSku)))"
$filter = "$($filter) and NOT (startswith(displayName,'MOD'))"
$filter = "$($filter) and NOT (assignedLicenses/any(x:x/skuId eq $($TeamsPhoneSku)))"
$filter = "$($filter) and NOT (assignedLicenses/any(x:x/skuId eq $($TeamsCallingPlanSku)))"

foreach ($user in (Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count)) {                                                                                                   
    update-MgUser -UserId $user.id -userPrincipalName ($user.UserPrincipalName.Split(“@”)[0] + “@” + "sandbox.shanehoey.dev") -mail ($user.mail.Split(“@”)[0] + “@” + "sandbox.shanehoey.dev")
}
Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count | sort-object DisplayName

### Add Liceneses
foreach ($user in (Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count)) {                                                                                                                        
    $user | Add-MgUserLicense -LicenseId $TeamsPhoneSku                
}                                                                                                          
