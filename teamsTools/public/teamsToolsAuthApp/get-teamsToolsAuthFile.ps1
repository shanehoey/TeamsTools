# DOC Documentation NewteamsToolsAuth
# IMPROVEMENT Add support for SupportsShouldProcess

function import-teamsToolsAuth {
    param (
        [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
        [Parameter(Mandatory = $true)]
        $filename
    )

    if (-Not (Test-Path -Path $filename)) {
        Write-Error "The file $filename does not exist."
        return $null
    }

    try {
        $content = Get-Content -Path $filename | ConvertTo-SecureString | ConvertFrom-SecureString -AsPlainText | ConvertFrom-Json
        $response = [PSCustomObject]@{
            ClientId     = $content.ClientId
            ClientSecret = $content.ClientSecret | ConvertTo-SecureString -AsPlainText
            TenantId     = $content.TenantId
        }
        return $response
    } catch {
        Write-Error "An error occurred while reading the file $filename"
        return $null
    }
}