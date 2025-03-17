# DOC Documentation initialize-teamsDefaultVoiceRoutes
# IMPROVEMENT Add support for SupportsShouldProcess

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

