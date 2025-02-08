
function initialize-teamsDefaultVoiceRoutes {
    $routes = @()
    $routes += [defaultVoiceRoute]::new("global", "global", "Emergency", "^$")
    $routes += [defaultVoiceRoute]::new("global", "global", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("global", "global", "National", "^$")
    $routes += [defaultVoiceRoute]::new("global", "global", "International", "^$")

    $routes += [defaultVoiceRoute]::new("AU", "Australia", "Emergency", "^\+61000$")
    $routes += [defaultVoiceRoute]::new("AU", "Australia", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("AU", "Australia", "National", "\+61\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("AU", "Australia", "International", "\+(?!61)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("AR", "Argentina", "Emergency", "^\+54991$")
    $routes += [defaultVoiceRoute]::new("AR", "Argentina", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("AR", "Argentina", "National", "\+54\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("AR", "Argentina", "International", "\+(?!54)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("BR", "Brazil", "Emergency", "^\+55(19[023])$")
    $routes += [defaultVoiceRoute]::new("BR", "Brazil", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("BR", "Brazil", "National", "\+55\d{3,11}$")
    $routes += [defaultVoiceRoute]::new("BR", "Brazil", "International", "\+(?!55)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("CA", "Canada", "Emergency", "^\+1(911|811)$")
    $routes += [defaultVoiceRoute]::new("CA", "Canada", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("CA", "Canada", "National", "\+1\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("CA", "Canada", "International", "\+(?!1)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("CL", "Chile", "Emergency", "^\+56(13\d)$")
    $routes += [defaultVoiceRoute]::new("CL", "Chile", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("CL", "Chile", "National", "\+56\d{8,9}$")
    $routes += [defaultVoiceRoute]::new("CL", "Chile", "International", "\+(?!56)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("CO", "Colombia", "Emergency", "^\+57(123)$")
    $routes += [defaultVoiceRoute]::new("CO", "Colombia", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("CO", "Colombia", "National", "\+57\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("CO", "Colombia", "International", "\+(?!57)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("GB", "United Kingdom", "Emergency", "^\+44(112|999)$")
    $routes += [defaultVoiceRoute]::new("GB", "United Kingdom", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("GB", "United Kingdom", "National", "\+44\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("GB", "United Kingdom", "International", "\+(?!44)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("MZ", "Mozambique", "Emergency", "^\+25(11[79]|198)$")
    $routes += [defaultVoiceRoute]::new("MZ", "Mozambique", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("MZ", "Mozambique", "National", "\+61\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("MZ", "Mozambique", "International", "\+61\d{3,10}$")

    $routes += [defaultVoiceRoute]::new("SG", "Singapore", "Emergency", "^\+65(999|995)$")
    $routes += [defaultVoiceRoute]::new("SG", "Singapore", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("SG", "Singapore", "National", "\+65\d{3,12}$")
    $routes += [defaultVoiceRoute]::new("SG", "Singapore", "International", "\+65\d{3,15}$")

    $routes += [defaultVoiceRoute]::new("US", "United States", "Emergency", "^\+1911$")
    $routes += [defaultVoiceRoute]::new("US", "United States", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("US", "United States", "National", "\+1\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("US", "United States", "International", "\+(?!1)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("ZA", "South Africa", "Emergency", "^\+27101(11|77)$")
    $routes += [defaultVoiceRoute]::new("ZA", "South Africa", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("ZA", "South Africa", "National", "\+27\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("ZA", "South Africa", "International", "\+(?!27)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("HK", "Hong Kong", "Emergency", "^\+852(999|112)$")
    $routes += [defaultVoiceRoute]::new("HK", "Hong Kong", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("HK", "Hong Kong", "National", "\+852\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("HK", "Hong Kong", "International", "\+(?!852)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("DE", "Germany", "Emergency", "^\+49112$")
    $routes += [defaultVoiceRoute]::new("DE", "Germany", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("DE", "Germany", "National", "\+49\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("DE", "Germany", "International", "\+(?!49)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("IN", "India", "Emergency", "^\+911$")
    $routes += [defaultVoiceRoute]::new("IN", "India", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("IN", "India", "National", "\+91\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("IN", "India", "International", "\+(?!91)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("IE", "Ireland", "Emergency", "^\+353112$")
    $routes += [defaultVoiceRoute]::new("IE", "Ireland", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("IE", "Ireland", "National", "\+353\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("IE", "Ireland", "International", "\+(?!353)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("IT", "Italy", "Emergency", "^\+39112$")
    $routes += [defaultVoiceRoute]::new("IT", "Italy", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("IT", "Italy", "National", "\+39\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("IT", "Italy", "International", "\+(?!39)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("JP", "Japan", "Emergency", "^\+81119$")
    $routes += [defaultVoiceRoute]::new("JP", "Japan", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("JP", "Japan", "National", "\+81\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("JP", "Japan", "International", "\+(?!81)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("MX", "Mexico", "Emergency", "^\+52112$")
    $routes += [defaultVoiceRoute]::new("MX", "Mexico", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("MX", "Mexico", "National", "\+52\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("MX", "Mexico", "International", "\+(?!52)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("NZ", "New Zealand", "Emergency", "^\+64111$")
    $routes += [defaultVoiceRoute]::new("NZ", "New Zealand", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("NZ", "New Zealand", "National", "\+64\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("NZ", "New Zealand", "International", "\+(?!64)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("PH", "Phillipines", "Emergency", "^\+63(911|143|8888|155|163|1343|1342|136)$")
    $routes += [defaultVoiceRoute]::new("PH", "Phillipines", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("PH", "Phillipines", "National", "\+63\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("PH", "Phillipines", "International", "\+(?!63)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("IL", "Israel", "Emergency", "^\+972112$")
    $routes += [defaultVoiceRoute]::new("IL", "Israel", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("IL", "Israel", "National", "\+972\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("IL", "Israel", "International", "\+(?!972)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("KR", "South Korea", "Emergency", "^\+82112$")
    $routes += [defaultVoiceRoute]::new("KR", "South Korea", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("KR", "South Korea", "National", "\+82\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("KR", "South Korea", "International", "\+(?!82)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("TW", "Taiwan", "Emergency", "^\+886112$")
    $routes += [defaultVoiceRoute]::new("TW", "Taiwan", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("TW", "Taiwan", "National", "\+886\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("TW", "Taiwan", "International", "\+(?!886)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("TH", "Thailand", "Emergency", "^\+66112$")
    $routes += [defaultVoiceRoute]::new("TH", "Thailand", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("TH", "Thailand", "National", "\+66\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("TH", "Thailand", "International", "\+(?!66)\d{10,15}$")

    $routes += [defaultVoiceRoute]::new("VN", "Vietnam", "Emergency", "^\+84112$")
    $routes += [defaultVoiceRoute]::new("VN", "Vietnam", "Internal", "^$")
    $routes += [defaultVoiceRoute]::new("VN", "Vietnam", "National", "\+84\d{3,10}$")
    $routes += [defaultVoiceRoute]::new("VN", "Vietnam", "International", "\+(?!84)\d{10,15}$")

    return $routes
}

# Function to get the rules based on name and type
function Get-TeamsDefaultVoiceRoutes {
    [CmdletBinding(DefaultParameterSetName = 'ByCountryCode')]
    param (
        [Parameter(ParameterSetName = 'ByDisplayName', Mandatory = $true)]
        [string]$displayName,

        [Parameter(ParameterSetName = 'ByCountryCode', Mandatory = $true)]
        [string]$countryCode,

        [Parameter(Mandatory = $false)]
        [ValidateSet("Emergency", "Internal", "Local", "National", "Service", "International")]
        [string]$Type
    )

    $rules = initialize-teamsDefaultVoiceRoutes

    switch ($PSCmdlet.ParameterSetName) {
        'ByDisplayName' {
            if ($null -eq $Type) {
                $filteredRules = $rules | Where-Object { $_.displayName -eq $displayName }
            } else {
                $filteredRules = $rules | Where-Object { $_.displayName -eq $displayName -and $_.Type -eq $Type }
            }
        }
        'ByCountryCode' {
            if ($null -eq $Type) {
                $filteredRules = $rules | Where-Object { $_.countryCode -eq $countryCode }
            } else {
                $filteredRules = $rules | Where-Object { $_.countryCode -eq $countryCode -and $_.Type -eq $Type }
            }
        }
    }

    return $filteredRules
}

# Example usage
# $defaultEmergencyRules = Get-TeamsDefaults -Name 'Default' -Type 'Emergency'
# $defaultEmergencyRules | Format-Table -AutoSize


function Initialize-TeamsDefaultVoiceNormalisationRules {

    $rules = @()

    $rules += [defaultVoiceNormalisationRule]::new('global', 'global', 'Emergency', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('global', 'global', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('global', 'global', 'National', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('global', 'global', 'International', '^$', '$1')

    $rules += [defaultVoiceNormalisationRule]::new('AU', 'Australia', 'Emergency', '^(000)$', '+61$1')
    $rules += [defaultVoiceNormalisationRule]::new('AU', 'Australia', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('AU', 'Australia', 'Local', '^(612|02|2)?(\d{8})$', '+612$2', '02')
    $rules += [defaultVoiceNormalisationRule]::new('AU', 'Australia', 'Local', '^(613|03|3)?(\d{8})$', '+613$2', '03')
    $rules += [defaultVoiceNormalisationRule]::new('AU', 'Australia', 'Local', '^(617|07|7)?(\d{8})$', '+617$2', '07')
    $rules += [defaultVoiceNormalisationRule]::new('AU', 'Australia', 'Local', '^(618|08|8)?(\d{8})$', '+618$2', '08')
    $rules += [defaultVoiceNormalisationRule]::new('AU', 'Australia', 'National', '^(61|0)?(\d{9})$', '+61$2')
    $rules += [defaultVoiceNormalisationRule]::new('AU', 'Australia', 'Service', '^((1[38](00)?((\d{6})|(\d{4})))|122[12345]|12[45])$', '+61$1')
    $rules += [defaultVoiceNormalisationRule]::new('AU', 'Australia', 'International', '^0011((?!61)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('BR', 'Brazil', 'Emergency', '^(19[023])$', '+55$1')
    $rules += [defaultVoiceNormalisationRule]::new('BR', 'Brazil', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('BR', 'Brazil', 'National', '^(55|0)?(\d{10})$', '+55$2')
    $rules += [defaultVoiceNormalisationRule]::new('BR', 'Brazil', 'International', '^00((?!55)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('CA', 'Canada', 'Emergency', '^(911|811)$', '+1$1')
    $rules += [defaultVoiceNormalisationRule]::new('CA', 'Canada', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('CA', 'Canada', 'National', '^(1)?(\d{10})$', '+1$2')
    $rules += [defaultVoiceNormalisationRule]::new('CA', 'Canada', 'International', '^011((?!1)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('CL', 'Chile', 'Emergency', '^(13\d)$', '+56$1')
    $rules += [defaultVoiceNormalisationRule]::new('CL', 'Chile', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('CL', 'Chile', 'National', '^(\d{3,9})$', '+56$2')
    $rules += [defaultVoiceNormalisationRule]::new('CL', 'Chile', 'International', '^0((?!56)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('CO', 'Colombia', 'Emergency', '^(123)$', '+57$1')
    $rules += [defaultVoiceNormalisationRule]::new('CO', 'Colombia', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('CO', 'Colombia', 'National', '^(57|0)?(\d{3,12})$', '+57$2')
    $rules += [defaultVoiceNormalisationRule]::new('CO', 'Colombia', 'International', '^00((?!57)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('GB', 'United Kingdom', 'Emergency', '^(112|999)$', '+44$1')
    $rules += [defaultVoiceNormalisationRule]::new('GB', 'United Kingdom', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('GB', 'United Kingdom', 'National', '^(44|0)?(\d{10})$', '+44$2')
    $rules += [defaultVoiceNormalisationRule]::new('GB', 'United Kingdom', 'International', '^00((?!44)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('MZ', 'Mozambique', 'Emergency', '^(11[79]|198)$', '+25$1')
    $rules += [defaultVoiceNormalisationRule]::new('MZ', 'Mozambique', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('MZ', 'Mozambique', 'National', '^(25|0)?(\d{10})$', '+25$2')
    $rules += [defaultVoiceNormalisationRule]::new('MZ', 'Mozambique', 'International', '^00((?!25)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('PH', 'Phillipines', 'Emergency', '^(911|143|8888|1555|163|1343|1342|136)$', '+63$1')
    $rules += [defaultVoiceNormalisationRule]::new('PH', 'Phillipines', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('PH', 'Phillipines', 'Local', '^(632|02|2)?(\d{8})$', '+632$2', '02')
    $rules += [defaultVoiceNormalisationRule]::new('PH', 'Phillipines', 'National', '^(63|0)?(\d{9})$', '+63$2')
    $rules += [defaultVoiceNormalisationRule]::new('PH', 'Phillipines', 'International', '^00((?!63)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('SG', 'Singapore', 'Emergency', '^(999|995)$', '+65$1')
    $rules += [defaultVoiceNormalisationRule]::new('SG', 'Singapore', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('SG', 'Singapore', 'National', '^(65|0)?(\d{10})$', '+65$2')
    $rules += [defaultVoiceNormalisationRule]::new('SG', 'Singapore', 'International', '^00((?!65)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('US', 'United States', 'Emergency', '^(911)$', '+1$1')
    $rules += [defaultVoiceNormalisationRule]::new('US', 'United States', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('US', 'United States', 'National', '^(1)?(\d{10,15})$', '+1$2')
    $rules += [defaultVoiceNormalisationRule]::new('US', 'United States', 'International', '^011((?!1)(\d{10,15}))$', '+$1')

    $rules += [defaultVoiceNormalisationRule]::new('ZA', 'South Africa', 'Emergency', '^(0101|101)(11|77)$', '+27101$2')
    $rules += [defaultVoiceNormalisationRule]::new('ZA', 'South Africa', 'Internal', '^$', '$1')
    $rules += [defaultVoiceNormalisationRule]::new('ZA', 'South Africa', 'National', '^(27|0|00)?(\d{3,10})$', '+27$2')
    $rules += [defaultVoiceNormalisationRule]::new('ZA', 'South Africa', 'International', '^00((?!27)(\d{10,15}))$', '+$1')

    return $rules
}

# Function to get the rules based on name and type
function Get-TeamsDefaultVoiceNormalisationRules {
    
        [CmdletBinding(DefaultParameterSetName = 'ByCountryCode')]
        param (

            [Parameter(ParameterSetName = 'ByCountryCode', Mandatory = $true)]
            [string]$countryCode,

            [Parameter(ParameterSetName = 'ByDisplayName', Mandatory = $true)]
            [string]$displayName,
    
            [Parameter(Mandatory = $false)]
            [ValidateSet("Emergency", "Internal", "Local", "National", "Service", "International")]
            [string]$type
        )
    
        $rules = Initialize-TeamsDefaultVoiceNormalisationRules

        switch ($PSCmdlet.ParameterSetName) {
            'ByDisplayName' {
                if ($null -eq $Type) {
                    $filteredRules = $rules | Where-Object { $_.displayName -eq $displayName }
                } else {
                    $filteredRules = $rules | Where-Object { $_.displayName -eq $displayName -and $_.Type -eq $type }
                }
            }
            'ByCountryCode' {
                if ($null -eq $Type) {
                    $filteredRules = $rules | Where-Object { $_.countryCode -eq $countryCode }
                } else {
                    $filteredRules = $rules | Where-Object { $_.countryCode -eq $countryCode -and $_.Type -eq $type }
                }
            }
        }

        return $filteredRules
\}
  
# Example usage
# $defaultEmergencyRules = Get-TeamsDefaults -Name 'Default' -Type 'Emergency'
# $defaultEmergencyRules | Format-Table -AutoSize
