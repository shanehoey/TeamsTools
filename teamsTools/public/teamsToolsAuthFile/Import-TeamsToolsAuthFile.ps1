# DOC Documentation Import-TeamsToolsAuthFile
# IMPROVEMENT Add support for SupportsShouldProcess

function Import-TeamsToolsAuthFile {
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
        $response = [TeamsToolsAuthApp]@{
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