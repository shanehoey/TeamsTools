
function initialize-teamsDefaultVoiceRoutes {
    $routes = @()
    $routes += [voiceRoute]::new("Default", "Default", "Emergency", "^$")
    $routes += [voiceRoute]::new("Default", "Default", "Internal", "^$")
    $routes += [voiceRoute]::new("Default", "Default", "National", "^$")
    $routes += [voiceRoute]::new("Default", "Default", "International", "^$")

    $routes += [voiceRoute]::new("Australia", "AU", "Emergency", "^\+61000$")
    $routes += [voiceRoute]::new("Australia", "AU", "Internal", "^$")
    $routes += [voiceRoute]::new("Australia", "AU", "National", "\+61\d{3,10}$")
    $routes += [voiceRoute]::new("Australia", "AU", "International", "\+(?!61)\d{10,15}$")

    $routes += [voiceRoute]::new("Argentina", "AR", "Emergency", "^\+54991$")
    $routes += [voiceRoute]::new("Argentina", "AR", "Internal", "^$")
    $routes += [voiceRoute]::new("Argentina", "AR", "National", "\+54\d{3,10}$")
    $routes += [voiceRoute]::new("Argentina", "AR", "International", "\+(?!54)\d{10,15}$")

    $routes += [voiceRoute]::new("Brazil", "BR", "Emergency", "^\+55(19[023])$")
    $routes += [voiceRoute]::new("Brazil", "BR", "Internal", "^$")
    $routes += [voiceRoute]::new("Brazil", "BR", "National", "\+55\d{3,11}$")
    $routes += [voiceRoute]::new("Brazil", "BR", "International", "\+(?!55)\d{10,15}$")

    $routes += [voiceRoute]::new("Canada", "CA", "Emergency", "^\+1(911|811)$")
    $routes += [voiceRoute]::new("Canada", "CA", "Internal", "^$")
    $routes += [voiceRoute]::new("Canada", "CA", "National", "\+1\d{3,10}$")
    $routes += [voiceRoute]::new("Canada", "CA", "International", "\+(?!1)\d{10,15}$")

    $routes += [voiceRoute]::new("Chile", "CL", "Emergency", "^\+56(13\d)$")
    $routes += [voiceRoute]::new("Chile", "CL", "Internal", "^$")
    $routes += [voiceRoute]::new("Chile", "CL", "National", "\+56\d{8,9}$")
    $routes += [voiceRoute]::new("Chile", "CL", "International", "\+(?!56)\d{10,15}$")

    $routes += [voiceRoute]::new("Colombia", "CO", "Emergency", "^\+57(123)$")
    $routes += [voiceRoute]::new("Colombia", "CO", "Internal", "^$")
    $routes += [voiceRoute]::new("Colombia", "CO", "National", "\+57\d{3,10}$")
    $routes += [voiceRoute]::new("Colombia", "CO", "International", "\+(?!57)\d{10,15}$")

    $routes += [voiceRoute]::new("United Kingdom", "GB", "Emergency", "^\+44(112|999)$")
    $routes += [voiceRoute]::new("United Kingdom", "GB", "Internal", "^$")
    $routes += [voiceRoute]::new("United Kingdom", "GB", "National", "\+44\d{3,10}$")
    $routes += [voiceRoute]::new("United Kingdom", "GB", "International", "\+(?!44)\d{10,15}$")

    $routes += [voiceRoute]::new("Mozambique", "MZ", "Emergency", "^\+25(11[79]|198)$")
    $routes += [voiceRoute]::new("Mozambique", "MZ", "Internal", "^$")
    $routes += [voiceRoute]::new("Mozambique", "MZ", "National", "\+61\d{3,10}$")
    $routes += [voiceRoute]::new("Mozambique", "MZ", "International", "\+61\d{3,10}$")

    $routes += [voiceRoute]::new("Singapore", "SG", "Emergency", "^\+65(999|995)$")
    $routes += [voiceRoute]::new("Singapore", "SG", "Internal", "^$")
    $routes += [voiceRoute]::new("Singapore", "SG", "National", "\+65\d{3,12}$")
    $routes += [voiceRoute]::new("Singapore", "SG", "International", "\+65\d{3,15}$")

    $routes += [voiceRoute]::new("United States", "US", "Emergency", "^\+1911$")
    $routes += [voiceRoute]::new("United States", "US", "Internal", "^$")
    $routes += [voiceRoute]::new("United States", "US", "National", "\+1\d{3,10}$")
    $routes += [voiceRoute]::new("United States", "US", "International", "\+(?!1)\d{10,15}$")

    $routes += [voiceRoute]::new("South Africa", "ZA", "Emergency", "^\+27101(11|77)$")
    $routes += [voiceRoute]::new("South Africa", "ZA", "Internal", "^$")
    $routes += [voiceRoute]::new("South Africa", "ZA", "National", "\+27\d{3,10}$")
    $routes += [voiceRoute]::new("South Africa", "ZA", "International", "\+(?!27)\d{10,15}$")

    $routes += [voiceRoute]::new("Hong Kong", "HK", "Emergency", "^\+852(999|112)$")
    $routes += [voiceRoute]::new("Hong Kong", "HK", "Internal", "^$")
    $routes += [voiceRoute]::new("Hong Kong", "HK", "National", "\+852\d{3,10}$")
    $routes += [voiceRoute]::new("Hong Kong", "HK", "International", "\+(?!852)\d{10,15}$")

    $routes += [voiceRoute]::new("Germany", "DE", "Emergency", "^\+49112$")
    $routes += [voiceRoute]::new("Germany", "DE", "Internal", "^$")
    $routes += [voiceRoute]::new("Germany", "DE", "National", "\+49\d{3,10}$")
    $routes += [voiceRoute]::new("Germany", "DE", "International", "\+(?!49)\d{10,15}$")

    $routes += [voiceRoute]::new("India", "IN", "Emergency", "^\+911$")
    $routes += [voiceRoute]::new("India", "IN", "Internal", "^$")
    $routes += [voiceRoute]::new("India", "IN", "National", "\+91\d{3,10}$")
    $routes += [voiceRoute]::new("India", "IN", "International", "\+(?!91)\d{10,15}$")

    $routes += [voiceRoute]::new("Ireland", "IE", "Emergency", "^\+353112$")
    $routes += [voiceRoute]::new("Ireland", "IE", "Internal", "^$")
    $routes += [voiceRoute]::new("Ireland", "IE", "National", "\+353\d{3,10}$")
    $routes += [voiceRoute]::new("Ireland", "IE", "International", "\+(?!353)\d{10,15}$")

    $routes += [voiceRoute]::new("Italy", "IT", "Emergency", "^\+39112$")
    $routes += [voiceRoute]::new("Italy", "IT", "Internal", "^$")
    $routes += [voiceRoute]::new("Italy", "IT", "National", "\+39\d{3,10}$")
    $routes += [voiceRoute]::new("Italy", "IT", "International", "\+(?!39)\d{10,15}$")

    $routes += [voiceRoute]::new("Japan", "JP", "Emergency", "^\+81119$")
    $routes += [voiceRoute]::new("Japan", "JP", "Internal", "^$")
    $routes += [voiceRoute]::new("Japan", "JP", "National", "\+81\d{3,10}$")
    $routes += [voiceRoute]::new("Japan", "JP", "International", "\+(?!81)\d{10,15}$")

    $routes += [voiceRoute]::new("Mexico", "MX", "Emergency", "^\+52112$")
    $routes += [voiceRoute]::new("Mexico", "MX", "Internal", "^$")
    $routes += [voiceRoute]::new("Mexico", "MX", "National", "\+52\d{3,10}$")
    $routes += [voiceRoute]::new("Mexico", "MX", "International", "\+(?!52)\d{10,15}$")

    $routes += [voiceRoute]::new("New Zealand", "NZ", "Emergency", "^\+64111$")
    $routes += [voiceRoute]::new("New Zealand", "NZ", "Internal", "^$")
    $routes += [voiceRoute]::new("New Zealand", "NZ", "National", "\+64\d{3,10}$")
    $routes += [voiceRoute]::new("New Zealand", "NZ", "International", "\+(?!64)\d{10,15}$")

    $routes += [voiceRoute]::new("Phillipines", "PH", "Emergency", "^\+63(911|143|8888|155|163|1343|1342|136)$")
    $routes += [voiceRoute]::new("Phillipines", "PH", "Internal", "^$")
    $routes += [voiceRoute]::new("Phillipines", "PH", "National", "\+63\d{3,10}$")
    $routes += [voiceRoute]::new("Phillipines", "PH", "International", "\+(?!63)\d{10,15}$")

    $routes += [voiceRoute]::new("Israel", "IL", "Emergency", "^\+972112$")
    $routes += [voiceRoute]::new("Israel", "IL", "Internal", "^$")
    $routes += [voiceRoute]::new("Israel", "IL", "National", "\+972\d{3,10}$")
    $routes += [voiceRoute]::new("Israel", "IL", "International", "\+(?!972)\d{10,15}$")

    $routes += [voiceRoute]::new("South Korea", "KR", "Emergency", "^\+82112$")
    $routes += [voiceRoute]::new("South Korea", "KR", "Internal", "^$")
    $routes += [voiceRoute]::new("South Korea", "KR", "National", "\+82\d{3,10}$")
    $routes += [voiceRoute]::new("South Korea", "KR", "International", "\+(?!82)\d{10,15}$")

    $routes += [voiceRoute]::new("Taiwan", "TW", "Emergency", "^\+886112$")
    $routes += [voiceRoute]::new("Taiwan", "TW", "Internal", "^$")
    $routes += [voiceRoute]::new("Taiwan", "TW", "National", "\+886\d{3,10}$")
    $routes += [voiceRoute]::new("Taiwan", "TW", "International", "\+(?!886)\d{10,15}$")

    $routes += [voiceRoute]::new("Thailand", "TH", "Emergency", "^\+66112$")
    $routes += [voiceRoute]::new("Thailand", "TH", "Internal", "^$")
    $routes += [voiceRoute]::new("Thailand", "TH", "National", "\+66\d{3,10}$")
    $routes += [voiceRoute]::new("Thailand", "TH", "International", "\+(?!66)\d{10,15}$")

    $routes += [voiceRoute]::new("Vietnam", "VN", "Emergency", "^\+84112$")
    $routes += [voiceRoute]::new("Vietnam", "VN", "Internal", "^$")
    $routes += [voiceRoute]::new("Vietnam", "VN", "National", "\+84\d{3,10}$")
    $routes += [voiceRoute]::new("Vietnam", "VN", "International", "\+(?!84)\d{10,15}$")

    return $routes
}

# Function to get the rules based on name and type
function Get-TeamsDefaultVoiceRoutes {
    param (
        [string]$Name,
        [string]$Type
    )

    $rules = initialize-teamsDefaultVoiceRoutes

    $filteredRules = $rules | Where-Object { $_.Name -eq $Name -and $_.Type -eq $Type }

    return $filteredRules
}

# Example usage
# $defaultEmergencyRules = Get-TeamsDefaults -Name 'Default' -Type 'Emergency'
# $defaultEmergencyRules | Format-Table -AutoSize


function Initialize-TeamsDefaultVoiceNormalisationRules {
    $rules = @()

    $rules += [VoiceNormalisationRule]::new('Default', 'global', 'Emergency', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Default', 'global', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Default', 'global', 'National', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Default', 'global', 'International', '^$', '$1')

    $rules += [VoiceNormalisationRule]::new('Australia', 'AU', 'Emergency', '^(000)$', '+61$1')
    $rules += [VoiceNormalisationRule]::new('Australia', 'AU', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Australia', 'AU', 'Local', '^(612|02|2)?(\d{8})$', '+612$2', '02')
    $rules += [VoiceNormalisationRule]::new('Australia', 'AU', 'Local', '^(613|03|3)?(\d{8})$', '+613$2', '03')
    $rules += [VoiceNormalisationRule]::new('Australia', 'AU', 'Local', '^(617|07|7)?(\d{8})$', '+617$2', '07')
    $rules += [VoiceNormalisationRule]::new('Australia', 'AU', 'Local', '^(618|08|8)?(\d{8})$', '+618$2', '08')
    $rules += [VoiceNormalisationRule]::new('Australia', 'AU', 'National', '^(61|0)?(\d{9})$', '+61$2')
    $rules += [VoiceNormalisationRule]::new('Australia', 'AU', 'Service', '^((1[38](00)?((\d{6})|(\d{4})))|122[12345]|12[45])$', '+61$1')
    $rules += [VoiceNormalisationRule]::new('Australia', 'AU', 'International', '^0011((?!61)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('Brazil', 'BR', 'Emergency', '^(19[023])$', '+55$1')
    $rules += [VoiceNormalisationRule]::new('Brazil', 'BR', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Brazil', 'BR', 'National', '^(55|0)?(\d{10})$', '+55$2')
    $rules += [VoiceNormalisationRule]::new('Brazil', 'BR', 'International', '^00((?!55)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('Canada', 'CA', 'Emergency', '^(911|811)$', '+1$1')
    $rules += [VoiceNormalisationRule]::new('Canada', 'CA', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Canada', 'CA', 'National', '^(1)?(\d{10})$', '+1$2')
    $rules += [VoiceNormalisationRule]::new('Canada', 'CA', 'International', '^011((?!1)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('Chile', 'CL', 'Emergency', '^(13\d)$', '+56$1')
    $rules += [VoiceNormalisationRule]::new('Chile', 'CL', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Chile', 'CL', 'National', '^(\d{3,9})$', '+56$2')
    $rules += [VoiceNormalisationRule]::new('Chile', 'CL', 'International', '^0((?!56)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('Colombia', 'CO', 'Emergency', '^(123)$', '+57$1')
    $rules += [VoiceNormalisationRule]::new('Colombia', 'CO', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Colombia', 'CO', 'National', '^(57|0)?(\d{3,12})$', '+57$2')
    $rules += [VoiceNormalisationRule]::new('Colombia', 'CO', 'International', '^00((?!57)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('United Kingdom', 'GB', 'Emergency', '^(112|999)$', '+44$1')
    $rules += [VoiceNormalisationRule]::new('United Kingdom', 'GB', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('United Kingdom', 'GB', 'National', '^(44|0)?(\d{10})$', '+44$2')
    $rules += [VoiceNormalisationRule]::new('United Kingdom', 'GB', 'International', '^00((?!44)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('Mozambique', 'MZ', 'Emergency', '^(11[79]|198)$', '+25$1')
    $rules += [VoiceNormalisationRule]::new('Mozambique', 'MZ', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Mozambique', 'MZ', 'National', '^(25|0)?(\d{10})$', '+25$2')
    $rules += [VoiceNormalisationRule]::new('Mozambique', 'MZ', 'International', '^00((?!25)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('Phillipines', 'PH', 'Emergency', '^(911|143|8888|1555|163|1343|1342|136)$', '+63$1')
    $rules += [VoiceNormalisationRule]::new('Phillipines', 'PH', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Phillipines', 'PH', 'Local', '^(632|02|2)?(\d{8})$', '+632$2', '02')
    $rules += [VoiceNormalisationRule]::new('Phillipines', 'PH', 'National', '^(63|0)?(\d{9})$', '+63$2')
    $rules += [VoiceNormalisationRule]::new('Phillipines', 'PH', 'International', '^00((?!63)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('Singapore', 'SG', 'Emergency', '^(999|995)$', '+65$1')
    $rules += [VoiceNormalisationRule]::new('Singapore', 'SG', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('Singapore', 'SG', 'National', '^(65|0)?(\d{10})$', '+65$2')
    $rules += [VoiceNormalisationRule]::new('Singapore', 'SG', 'International', '^00((?!65)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('United States', 'US', 'Emergency', '^(911)$', '+1$1')
    $rules += [VoiceNormalisationRule]::new('United States', 'US', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('United States', 'US', 'National', '^(1)?(\d{10,15})$', '+1$2')
    $rules += [VoiceNormalisationRule]::new('United States', 'US', 'International', '^011((?!1)(\d{10,15}))$', '+$1')

    $rules += [VoiceNormalisationRule]::new('South Africa', 'ZA', 'Emergency', '^(0101|101)(11|77)$', '+27101$2')
    $rules += [VoiceNormalisationRule]::new('South Africa', 'ZA', 'Internal', '^$', '$1')
    $rules += [VoiceNormalisationRule]::new('South Africa', 'ZA', 'National', '^(27|0|00)?(\d{3,10})$', '+27$2')
    $rules += [VoiceNormalisationRule]::new('South Africa', 'ZA', 'International', '^00((?!27)(\d{10,15}))$', '+$1')

    return $rules
}

# Function to get the rules based on name and type
function Get-TeamsDefaultVoiceNormalisationRules {
    param (
        [string]$Name,
        [string]$Type
    )

    $rules = Initialize-VoiceNormalisationRules

    $filteredRules = $rules | Where-Object { $_.Name -eq $Name -and $_.Type -eq $Type }

    return $filteredRules
}

# Example usage
# $defaultEmergencyRules = Get-TeamsDefaults -Name 'Default' -Type 'Emergency'
# $defaultEmergencyRules | Format-Table -AutoSize
