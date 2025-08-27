import-module ./teamsTools/ -force -Verbose

#Connect to Graph and check if the app is available
Connect-TeamsToolsGraph -useDeviceCode
Get-TeamsToolsAuthApp
Test-TeamsToolsAuthApp
Remove-TeamsToolsAuthApp -confirm:$false

# Create a new app and save the credentials to a file

$auth = new-teamsToolsAuthApp
$auth

# Example 1
# BUG if the folder does not exist, it will fail
save-teamsToolsAuthfile -filename /home/shane/Development/teamsToolsAuth/teamsTools.auth -clientId $auth.ClientID -clientSecret $auth.ClientSecret -tenantId $auth.TenantID 

# Example 2
$auth | save-teamsToolsAuthfile -filename /home/shane/Development/teamsToolsAuth/teamsTools.auth

# Example 3
New-teamsToolsAuthApp | save-teamsToolsAuthfile -filename /home/shane/Development/teamsToolsAuth/teamsTools.auth

Disconnect-TeamsToolsGraph

