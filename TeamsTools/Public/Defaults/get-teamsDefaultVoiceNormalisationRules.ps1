# DOC Documentation initialize-teamsDefaultVoiceNormalisationRules
# IMPROVEMENT Add support for SupportsShouldProcess


function get-teamsDefaultVoiceNormalisationRules {
    [CmdletBinding()]
    param (
        [string]$CountryCode,
        [string]$CountryName,
        [string]$Type
    )

    Write-Verbose "Initializing default voice normalization rules"
    $rules = initialize-teamsDefaultVoiceNormalisationRules

    if ($PSBoundParameters.ContainsKey('CountryCode')) {
        Write-Verbose "Filtering by CountryCode: $CountryCode"
        $rules = $rules | Where-Object { $_.CountryCode -eq $CountryCode }
    }

    if ($PSBoundParameters.ContainsKey('CountryName')) {
        Write-Verbose "Filtering by CountryName: $CountryName"
        $rules = $rules | Where-Object { $_.CountryName -eq $CountryName }
    }

    if ($PSBoundParameters.ContainsKey('Type')) {
        Write-Verbose "Filtering by Type: $Type"
        $rules = $rules | Where-Object { $_.Type -eq $Type }
    }

    Write-Verbose "Returning filtered rules"
    return $rules
}