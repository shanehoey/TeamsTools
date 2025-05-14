import-module ./teamsTools/ -force -Verbose

#Connect to Graph and check if the app is available
Connect-TeamsToolsGraph
Get-TeamsToolsAuthApp
Test-TeamsToolsAuthApp
Remove-TeamsToolsAuthApp -confirm:$false

# Create a new app and save the credentials to a file

$auth = new-teamsToolsAuthApp
$auth
# Example 1
save-teamsToolsAuthfile -filename /home/shane/Documents/TeamsToolsAuth/TeamsToolsAuth.auth -clientId $auth.ClientID -clientSecret $auth.ClientSecret -tenantId $auth.TenantID 
# Example 2
$auth | save-teamsToolsAuthfile -filename /home/shane/Documents/TeamsToolsAuth/TeamsToolsAuth1.auth
# Example 3
New-teamsToolsAuthApp | save-teamsToolsAuthfile -filename /home/shane/Documents/TeamsToolsAuth/TeamsTools.auth

Disconnect-TeamsToolsGraph

