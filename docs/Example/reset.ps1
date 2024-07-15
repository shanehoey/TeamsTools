try {
    get-cstenant | Select-Object Sipdomain
} catch {
    Connect-MicrosoftTeams -UseDeviceAuthentication
}

Set-Location -Path S:\DevDrive
Remove-Module -Name TeamsToolsReset
Import-Module  -Name .\TeamsToolsReset\ -Verbose -Force

remove-teamstoolsconfig -domainname "sandbox.shanehoey.dev"  -clean  