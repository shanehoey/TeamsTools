
Connect-MgGraph -Scopes "User.ReadWrite.All"    
 
Get-MgSubscribedSku |  select skuPartNumber,ConsumedUnits,@{name="PrepaidUnits";e={$_.PrepaidUnits.Enabled}},ServicePlans,skuId,id | Format-table -autosize


$TeamsEnterpriseSku = (Get-MgSubscribedSku -all | where {$_.skuPartNumber -eq 'Microsoft_Teams_Enterprise_New'}).skuid
$TeamsPhoneSku = (Get-MgSubscribedSku -all | where {$_.skuPartNumber -eq 'MCOEV'}).skuid
$TeamsCallingPlanSku = (Get-MgSubscribedSku -all | where {$_.skuPartNumber -eq 'MCOPSTN2'}).skuid

# Users
$filter = ""
$filter = "NOT (startswith(displayName,'MOD'))"
$filter = "(startswith(displayName,'Conf'))"

# Licenses
$filter = "(assignedLicenses/any(x:x/skuId eq $($TeamsEnterpriseSku)))"
$filter = "(assignedLicenses/any(x:x/skuId eq $($TeamsPhoneSku)))"
$filter = "(assignedLicenses/any(x:x/skuId eq $($TeamsCallingPlanSku)))"
Get-MgUser -Filter $filter 

$filter = "(assignedLicenses/any(x:x/skuId eq $($TeamsEnterpriseSku)))"
$filter = "$filter and NOT (startswith(displayName,'MOD'))"
Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count | sort-object DisplayName

$filter = "(assignedLicenses/any(x:x/skuId eq $($TeamsPhoneSku)))"
$filter = "$filter and NOT (startswith(displayName,'MOD'))"
Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count | sort-object DisplayName

$filter = "(assignedLicenses/any(x:x/skuId eq $($TeamsCallingPlanSku)))"
$filter = "$($filter) and NOT (startswith(displayName,'MOD'))"
Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count | sort-object DisplayName

$filter = "NOT (assignedLicenses/any(x:x/skuId eq $($TeamsEnterpriseSku)))"
Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count | sort-object DisplayName

$filter = "(assignedLicenses/any(x:x/skuId eq $($TeamsEnterpriseSku)))"
$filter = "$($filter) and NOT (startswith(displayName,'MOD'))"
$filter = "$($filter) and NOT (assignedLicenses/any(x:x/skuId eq $($TeamsPhoneSku)))"
$filter = "$($filter) and NOT (assignedLicenses/any(x:x/skuId eq $($TeamsCallingPlanSku)))"
Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count | sort-object DisplayName ; $count

                                                                                                                                                                                                       
#$filter = "assignedLicenses/any eq 0"
#$filter = "assignedLicenses/any() eq false"
#$filter = "assignedLicenses/any() eq 0"
#$filter = "assignedLicenses/any(x:x/skuId eq null)"

$filter = 'assignedLicenses/$count eq 0'
Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count | sort-object DisplayName

### Update Domain 
foreach ($user in (Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count)) {                                                                                                   
    update-MgUser -UserId $user.id -userPrincipalName ($user.UserPrincipalName.Split(“@”)[0] + “@” + "sandbox.shanehoey.dev") -mail ($user.mail.Split(“@”)[0] + “@” + "sandbox.shanehoey.dev")
}
Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count | sort-object DisplayName

### Add Liceneses
foreach ($user in (Get-MgUser -Filter $filter -consistencyLevel eventual -countVariable count)) {                                                                                                                        
    $user | Add-MgUserLicense -LicenseId $TeamsPhoneSku                
}                                                                                                          
