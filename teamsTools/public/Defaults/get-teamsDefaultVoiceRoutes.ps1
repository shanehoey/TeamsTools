# DOC Documentation initialize-teamsDefaultVoiceRoutes
# IMPROVEMENT Add support for SupportsShouldProcess

function get-teamsDefaultVoiceRoutes {
    param (
        [string]$CountryCode,
        [string]$CountryName,
        [string]$Type
    )

    $routes = initialize-teamsDefaultVoiceRoutes

    if ($CountryCode) {
        $routes = $routes | Where-Object { $_.CountryCode -eq $CountryCode }
    }

    if ($CountryName) {
        $routes = $routes | Where-Object { $_.CountryName -eq $CountryName }
    }

    if ($Type) {
        $routes = $routes | Where-Object { $_.Type -eq $Type }
    }

    return $routes
}



