# This should check the user is enabled for enterprise voice 

Write-Warning "$MyInvocation.MyCommand.Name is not implemented"

function test-teamsUserPhoneSystem {
    param (
        $Identity 
    )
    
    $user = Get-CsOnlineUser -Identity $Indentity
    if ($user.featureTypes -notcontains "PhoneSystem" ) { $false } else { $true }

}



