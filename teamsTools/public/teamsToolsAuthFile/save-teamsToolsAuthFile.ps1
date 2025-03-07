# DOC Documentation Save-TeamsToolsAuthFile
# IMPROVEMENT Add support for SupportsShouldProcess

function Save-TeamsToolsAuthFile {
    param (
        [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]

        [Parameter(Mandatory = $true,ParameterSetName = 'byFile')]
        [Parameter(Mandatory = $true,ParameterSetName = 'bySecret')]
        [Alias("FilePath","File")]
        [ValidateScript({ Test-Path (Split-Path $_ -Parent) })]
        [string]$filename,

        [Parameter(Mandatory = $true,ParameterSetName = 'byFile')]
        [Alias("AppID")]
        [string]$clientId,

        [Parameter(Mandatory = $true,ParameterSetName = 'byFile')]
        [securestring]$clientSecret,

        [Parameter(Mandatory = $true,ParameterSetName = 'byFile')]
        [string]$tenantId,

        [Parameter(Mandatory = $true, ParameterSetName = 'bySecret', ValueFromPipeline = $true)]
        [TeamsToolsAuthApp]$secrets 

        )

    try {

        if ($PSCmdlet.ShouldProcess($filename, "Save Teams Tools Auth File")) {

            if ($PSCmdlet.ParameterSetName -eq 'byFile') {
                $secretsJson = [PSCustomObject]@{
                    ClientId = $ClientId
                    ClientSecret = $ClientSecret | ConvertFrom-SecureString -AsPlainText
                    TenantId = $TenantId
                } |  ConvertTo-Json | ConvertTo-SecureString -AsPlainText -force
            } else {
                $secretsJson = [PSCustomObject]@{
                    ClientId = $secrets.ClientId
                    ClientSecret = $secrets.ClientSecret | ConvertFrom-SecureString -AsPlainText
                    TenantId = $secrets.TenantId
                } |  ConvertTo-Json | ConvertTo-SecureString -AsPlainText -force
            }
     
            $secretsJson | ConvertFrom-SecureString | Out-File -FilePath $filename -Force
        
        }
    } catch {
        Write-Error "An error occurred while reading the file $filename"
        return $null
    }

}
 