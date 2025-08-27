# DOC Documentation initialize-teamsDefaultVoiceRoutes
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsDefaultVoiceRoutes {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [string]$CountryCode,
        [string]$CountryName,
        [string]$Type
    )

    if ($PSCmdlet -and -not $PSCmdlet.ShouldProcess('DefaultVoiceRoutes','Retrieve default voice routes')) {
        Write-Verbose "Skipping retrieval of default voice routes because ShouldProcess returned false."
        return
    }

    $routes = Initialize-TeamsDefaultVoiceRoutes

    if ($CountryCode) {
        $routes = $routes | Where-Object { $_.CountryCode -eq $CountryCode }
    }

    if ($CountryName) {
        $routes = $routes | Where-Object { $_.CountryName -eq $CountryName }
    }

    if ($Type) {
        $routes = $routes | Where-Object { $_.Type -eq $Type }
    }

    if ($routes) {
        return $routes
    } else {
        Write-Warning "No matching routes found for $CountryCode, $CountryName, $Type"
    }

}
