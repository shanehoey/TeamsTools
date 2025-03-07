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
        [TeamsToolsAuthApp]$secret = [TeamsToolsAuthApp]::new()

        )

    try {

        if ($PSCmdlet.ShouldProcess($filename, "Save Teams Tools Auth File")) {

            if ($PSCmdlet.ParameterSetName -eq 'byFile') {
                $secrets = [TeamsToolsAuthApp]@{
                    clientId = $ClientId 
                    ClientSecret = $ClientSecret
                    TenantId = $TenantId
                }
            } 
            $secretsJson =  $secrets | ConvertTo-Json
            $secureContent = ConvertTo-SecureString -String $secretsJson -AsPlainText -Force
            $secureContent | ConvertFrom-SecureString | Out-File -FilePath $filename -Force
        }
    } catch {
        Write-Error "An error occurred while reading the file $filename"
        return $null
    }

}
