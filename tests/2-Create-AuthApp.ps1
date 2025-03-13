
#Connect to Graph and check if the app is available
Connect-TeamsToolsGraph
Get-TeamsToolsAuthApp
Test-TeamsToolsAuthApp
Remove-TeamsToolsAuthApp -confirm:$false


# Create a new app and save the credentials to a file

$auth = new-teamsToolsAuthApp
# Example 1
save-teamsToolsAuthfile -filename /home/shane/Documents/TeamsTools/TeamsToolsAuth.json -clientId $auth.ClientID -clientSecret $auth.ClientSecret -tenantId $auth.TenantID 
# Example 2
$auth | save-teamsToolsAuthfile -filename /home/shane/Documents/TeamsTools/TeamsToolsAuth.json
# Example 3
New-teamsToolsAuthApp | save-teamsToolsAuthfile -filename /home/shane/Documents/TeamsTools/TeamsToolsAuth.json

Disconnect-TeamsToolsGraph

dir /home/shane/Documents/TeamsTools/ 
del /home/shane/Documents/TeamsTools/TeamsToolsAuth.json


# import the credentials from the file and connect to Teamstools
import-teamsToolsauthfile -filename /home/shane/Documents/TeamsTools/TeamsToolsAuth.json | Connect-teamsTools
$auth2 = import-teamsToolsauthfile -filename /home/shane/Documents/TeamsTools/TeamsToolsAuth.json
Disconnect-TeamsTools

Connect-TeamsTools -TenantId $auth2.TenantID -ClientId $auth2.ClientID -ClientSecret $auth2.ClientSecret -Verbose
Disconnect-TeamsTools