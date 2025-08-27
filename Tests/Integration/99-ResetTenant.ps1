#Requires -Modules @{ ModuleName="TeamsTools"; ModuleVersion="1.0.0" }#
#Requires -Modules @{ ModuleName="TeamsToolsReset"; ModuleVersion="1.0.0" }

import-module ./teamsTools/ -force -Verbose
import-module ./teamsToolsReset/ -force -Verbose

import-teamsToolsauthfile -filename /home/shane/Development/TeamsToolsAuth/TeamsTools.auth | Connect-teamsTools

#TODO NEED TO REMOVE GROUP POLICY need to add the group policy check to the scripts to the test script

remove-teamstoolsconfig -domainname "sandbox.shanehoey.dev"  -clean 

foreach ($number in (get-csphonenumberassignment)) {
    $number | Select TelephoneNumber, PstnAssignmentStatus
    remove-csonlinetelephonenumber -telephoneNumber $number.TelephoneNumber
}

foreach($i in (get-CsPhoneNumberassignment | select-object TelephoneNumber)) { 
    remove-csonlineTelephoneNumber -telephonenumber $i.TelephoneNumber 
}



# Remove Domain

Remove-teamstoolsdomain -domainname "sandbox.shanehoey.dev"
Remove-teamstoolsdomain -domainname "play.shanehoey.dev"


# Remove Teams authapp 

Connect-TeamsToolsGraph
Get-TeamsToolsAuthApp
Test-TeamsToolsAuthApp
Remove-TeamsToolsAuthApp -confirm:$false
