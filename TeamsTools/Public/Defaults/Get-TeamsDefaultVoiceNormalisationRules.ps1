Function Get-TeamsDefaultVoiceNormalisationRules {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [string]$CountryCode,
        [string]$CountryName,
        [string]$Type
    )

    if ($PSCmdlet -and -not $PSCmdlet.ShouldProcess('DefaultVoiceNormalisationRules','Retrieve default voice normalization rules')) {
        Write-Verbose "Skipping retrieval of default voice normalization rules because ShouldProcess returned false."
        return
    }

    Write-Verbose "Initializing default voice normalization rules"
    $rules = Initialize-TeamsDefaultVoiceNormalisationRules

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