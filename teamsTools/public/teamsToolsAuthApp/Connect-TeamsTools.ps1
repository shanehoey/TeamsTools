# DOC Documentation NewteamsToolsAuth
# IMPROVEMENT Add support for SupportsShouldProcess

function Connect-TeamsTools {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [string]$TenantId,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [string]$ClientId,  
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [securestring]$ClientSecret,
        [Parameter(Mandatory = $true, ParameterSetName = 'Secrets', ValueFromPipeline = $true)]
        [TeamsToolsAuthApp]$Secrets
    )


    if ($PSCmdlet.ShouldProcess("Connecting to Microsoft Graph and Teams")) {

        if ($PSCmdlet.ParameterSetName -eq 'Default') {
        
            $secrets = [TeamsToolsAuthApp]@{
                clientId = $ClientId 
                ClientSecret = $ClientSecret
                TenantId = $TenantId
            }
        
        }



        

        $body = @{
            grant_type    = "client_credentials"
            client_id     = $secrets.ClientId
            client_secret = $secrets.ClientSecret | ConvertFrom-SecureString -AsPlainText
            scope         = "https://graph.microsoft.com/.default"
        }
        $graphToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$($secrets.TenantId)/oauth2/v2.0/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body
        if ($graphToken.access_token) {
            Write-Output "Successfully created token to Microsoft Graph."
            Connect-MgGraph -AccessToken ($graphToken.access_token | ConvertTo-SecureString -AsPlainText -Force)
        } else {
            Write-Error "Failed to connect to Microsoft Graph."
        }

        $body = @{
            grant_type    = "client_credentials"
            scope         = "48ac35b8-9aa8-4d74-927d-1f4a14a0b239/.default"
            client_id     = $secrets.ClientId
            client_secret =  $secrets.ClientSecret | ConvertFrom-SecureString -AsPlainText
        }
        $teamsToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$($secrets.TenantId)/oauth2/v2.0/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body
        if ($teamsToken.access_token) {
            Write-Output "Successfully created token to Microsoft Teams."
            Connect-MicrosoftTeams -AccessTokens @($graphToken.access_token, $teamsToken.access_token)
        } else {
            Write-Error "Failed to connect to Microsoft Teams."
        }

        Write-Warning "Exchange not Implemented"
        <#
        $body = @{
            grant_type    = "client_credentials"
            scope         = "https://outlook.office365.com/.default"
            client_id     = $ClientId
            client_secret = $plainClientSecret
        }
        $exchangeToken = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $body
        if ($exchangeToken.access_token) {
            Write-Output "Successfully created token to Microsoft Exchange."
            Connect-ExchangeOnline -AccessToken ($exchangeToken.access_token | ConvertTo-SecureString -AsPlainText -Force)
        } else {
            Write-Error "Failed to connect to Microsoft Exchange."
        }
        #>
    }
}
