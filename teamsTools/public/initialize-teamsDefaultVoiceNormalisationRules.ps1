function initialize-teamsDefaultVoiceNormalisationRules {

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
