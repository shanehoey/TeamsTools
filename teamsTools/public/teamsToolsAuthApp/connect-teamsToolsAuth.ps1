# DOC Documentation NewteamsToolsAuth
# IMPROVEMENT Add support for SupportsShouldProcess


function Connect-teamsToolsAuth {
    param (
        [Parameter(Mandatory = $true)]
        [string]$TenantId,
        [Parameter(Mandatory = $true)]
        [string]$ClientId,  
        [Parameter(Mandatory = $true)]
        [securestring]$ClientSecret,
        [switch]$microsoftGraph,
        [switch]$microsoftTeams,
        [switch]$microsoftExchange
    )

    if ($microsoftGraph) {
        $body = @{
            grant_type    = "client_credentials"
            client_id     = $ClientId
            client_secret = $ClientSecret | ConvertFrom-SecureString -AsPlainText
            scope         = "https://graph.microsoft.com/.default"
        }
        $graphtoken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body
        if ($graphtoken.access_token) {
            Write-Output "Successfully created token to Microsoft Graph."
            Connect-MgGraph -AccessToken ($graphToken.access_token | ConvertTo-SecureString -AsPlainText -Force)
        } else {
            Write-Error "Failed to connect to Microsoft Graph."
        }
    }

    if($microsoftTeams) {
        $body = @{
            Grant_Type    = "client_credentials"
            Scope         = "48ac35b8-9aa8-4d74-927d-1f4a14a0b239/.default"
            Client_Id     = $ClientId
            Client_Secret = $ClientSecret
        }
        $teamsToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$($teamsauth.TenantID)/oauth2/v2.0/token" -Method POST -Body $bod
            if ($teamsToken.access_token) {
            Write-Output "Successfully created tolkeen to Microsoft Teams."
            $GraphAccessToken = $teamsToken.access_token
            Connect-MicrosoftTeams -AccessTokens  @($graphToken.access_token, $teamsToken.access_token) 
        } else {
            Write-Error "Failed to connect to Microsoft Teams."
        }

    }

    if($microsoftExchange) {
        write-warning "Exchange not Implemented"
        <#
        $body = @{
            Grant_Type    = "client_credentials"
            Scope         = "https://outlook.office365.com/.default"
            Client_Id     = $ClientId
            Client_Secret = $ClientSecret
        }
        $exchangeToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$($teamsauth.TenantID)/oauth2/v2.0/token" -Method POST -Body $bod
        if ($exchangeToken.access_token) {
            Write-Output "Successfully created token to Microsoft Exchange."
            $GraphAccessToken = $exchangeToken.access_token
            Connect-ExchangeOnline -AccessToken ($exchangeToken.access_token | ConvertTo-SecureString -AsPlainText -Force)
        } else {
            Write-Error "Failed to connect to Microsoft Exchange."
        }
        #>
    }


}
