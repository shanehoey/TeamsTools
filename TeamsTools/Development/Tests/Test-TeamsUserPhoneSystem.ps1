# This should check the user is enabled for enterprise voice 

Write-warning "Not Implemented: $($PSCommandPath ?? $MyInvocation.MyCommand.Path)"
Function Test-TeamsUserPhoneSystem {
    param (
        $Identity 
    )
    
    $user = Get-CsOnlineUser -Identity $Indentity
    if ($user.featureTypes -notcontains "PhoneSystem" ) { $false } else { $true }

}



