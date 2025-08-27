import-module ./teamsTools/  -force  -Verbose

# Import the credentials from the file and connect to Teamstools

# Example 1
import-teamsToolsauthfile -filename /home/shane/Development/TeamsToolsAuth/teamsTools.auth | Connect-teamsTools

# Example 2
$auth = import-teamsToolsauthfile -filename /home/shane/Development/TeamsToolsAuth/teamsTools.auth
Connect-TeamsTools -TenantId $auth.TenantID -ClientId $auth.ClientID -ClientSecret $auth.ClientSecret -Verbose

# Disconnect from TeamsTools
Disconnect-TeamsTools
