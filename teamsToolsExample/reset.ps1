try {
    get-cstenant | Select-Object Sipdomain
} catch {
    Connect-MicrosoftTeams -UseDeviceAuthentication
}


Remove-Module -Name teamsToolsReset
Import-Module  -Name .\TeamsToolsReset\ -Verbose -Force

remove-teamstoolsconfig -domainname "sandbox.shanehoey.dev"  -clean 