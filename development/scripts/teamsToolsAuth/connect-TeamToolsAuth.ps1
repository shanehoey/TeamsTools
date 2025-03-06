

# Import the file from /home/documents/teamstools/teamstools.json
$ClientId = (Get-Content -Path "$home/Documents/TeamsTools/teamsTools.json" | ConvertTo-SecureString |  ConvertFrom-SecureString -AsPlainText | convertfrom-Json).ClientId
$ClientSecret = (Get-Content -Path "$home/Documents/TeamsTools/teamsTools.json" | ConvertTo-SecureString |  ConvertFrom-SecureString -AsPlainText | convertfrom-Json).ClientSecret
$TenantId = (Get-Content -Path "$home/Documents/TeamsTools/teamsTools.json" | ConvertTo-SecureString |  ConvertFrom-SecureString -AsPlainText | convertfrom-Json).TenantId
$ClientId
$ClientSecret
$TenantId

$graphtokenBody = @{
   Grant_Type    = "client_credentials"
   Scope         = "https://graph.microsoft.com/.default"
   Client_Id     = $ClientId
   Client_Secret = $ClientSecret
 }
$graphtokenBody

$graphToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -Method POST -Body $graphtokenBody 
Connect-MgGraph -AccessToken ($graphToken.access_token| ConvertTo-SecureString -AsPlainText -Force)


$teamstokenBody = @{
   Grant_Type    = "client_credentials"
   Scope         = "48ac35b8-9aa8-4d74-927d-1f4a14a0b239/.default"
   Client_Id     = $ClientId
   Client_Secret = $ClientSecret
}
 
$teamsToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token" -Method POST -Body $teamstokenBody
Connect-MicrosoftTeams -AccessTokens  @($graphToken.access_token, $teamsToken.access_token)



# BUG - Exhange Token Auth 
# This does not work, I not sure token authentication is supported for Exchange Online with a ClientID and Client Secret 
# Connect-ExchangeOnline -accessToken
# This is only need for the proxy update to delete the script so investigate graph instead

$exchangetokenBody = @{
   Grant_Type    = "client_credentialsd"
   Scope         = "https://outlook.office365.com/.default"
   Client_Id     = $ClientId
   Client_Secret = $ClientSecret
}
$exchangeToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token" -Method POST -Body $exchangetokenBody

Connect-ExchangeOnline -AccessToken $exchangeToken.access_token -Organization $tenantid

