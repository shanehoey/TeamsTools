import-module ./teamsTools/  -force  -Verbose

# Import the credentials from the file and connect to Teamstools

# Example 1
import-teamsToolsauthfile -filename /home/shane/Documents/TeamsTools/TeamsToolsAuth.json | Connect-teamsTools

# Example 2
$auth = import-teamsToolsauthfile -filename /home/shane/Documents/TeamsTools/TeamsToolsAuth.json
Connect-TeamsTools -TenantId $auth.TenantID -ClientId $auth.ClientID -ClientSecret $auth.ClientSecret -Verbose


# Disccnnect from TeamsTools
Disconnect-TeamsTools
