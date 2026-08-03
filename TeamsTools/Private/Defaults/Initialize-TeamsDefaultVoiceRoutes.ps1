# DOC Documentation initialize-teamsDefaultVoiceRoutes
# IMPROVEMENT Add support for SupportsShouldProcess

Function Initialize-TeamsDefaultVoiceRoutes {

    $routes = @()

    $routes += [DefaultVoiceRoute]::new("global", "global", "Emergency", "^$")
    $routes += [DefaultVoiceRoute]::new("global", "global", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("global", "global", "National", "^$")
    $routes += [DefaultVoiceRoute]::new("global", "global", "International", "^$")

    $routes += [DefaultVoiceRoute]::new("AR", "Argentina", "Emergency", "^\+54991$")
    $routes += [DefaultVoiceRoute]::new("AR", "Argentina", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("AR", "Argentina", "National", "\+54\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("AR", "Argentina", "International", "\+(?!54)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("AU", "Australia", "Emergency", "^\+61000$")
    $routes += [DefaultVoiceRoute]::new("AU", "Australia", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("AU", "Australia", "National", "\+61\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("AU", "Australia", "International", "\+(?!61)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("BR", "Brazil", "Emergency", "^\+55(19[023])$")
    $routes += [DefaultVoiceRoute]::new("BR", "Brazil", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("BR", "Brazil", "National", "\+55\d{3,11}$")
    $routes += [DefaultVoiceRoute]::new("BR", "Brazil", "International", "\+(?!55)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("CA", "Canada", "Emergency", "^\+1(911|811)$")
    $routes += [DefaultVoiceRoute]::new("CA", "Canada", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("CA", "Canada", "National", "\+1\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("CA", "Canada", "International", "\+(?!1)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("CL", "Chile", "Emergency", "^\+56(13\d)$")
    $routes += [DefaultVoiceRoute]::new("CL", "Chile", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("CL", "Chile", "National", "\+56\d{8,9}$")
    $routes += [DefaultVoiceRoute]::new("CL", "Chile", "International", "\+(?!56)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("CO", "Colombia", "Emergency", "^\+57(123)$")
    $routes += [DefaultVoiceRoute]::new("CO", "Colombia", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("CO", "Colombia", "National", "\+57\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("CO", "Colombia", "International", "\+(?!57)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("DE", "Germany", "Emergency", "^\+49112$")
    $routes += [DefaultVoiceRoute]::new("DE", "Germany", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("DE", "Germany", "National", "\+49\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("DE", "Germany", "International", "\+(?!49)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("ES", "Spain", "Emergency", "^\+34112$")
    $routes += [DefaultVoiceRoute]::new("ES", "Spain", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("ES", "Spain", "National", "\+34\d{3,9}$")
    $routes += [DefaultVoiceRoute]::new("ES", "Spain", "International", "\+(?!34)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("FR", "France", "Emergency", "^\+33112$")
    $routes += [DefaultVoiceRoute]::new("FR", "France", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("FR", "France", "National", "\+33\d{3,9}$")
    $routes += [DefaultVoiceRoute]::new("FR", "France", "International", "\+(?!33)\d{10,15}$")
  
    $routes += [DefaultVoiceRoute]::new("HK", "Hong Kong", "Emergency", "^\+852(999|112)$")
    $routes += [DefaultVoiceRoute]::new("HK", "Hong Kong", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("HK", "Hong Kong", "National", "\+852\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("HK", "Hong Kong", "International", "\+(?!852)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("ID", "Indonesia", "Emergency", "^\+62112$")
    $routes += [DefaultVoiceRoute]::new("ID", "Indonesia", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("ID", "Indonesia", "National", "\+62\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("ID", "Indonesia", "International", "\+(?!62)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("IE", "Ireland", "Emergency", "^\+353112$")
    $routes += [DefaultVoiceRoute]::new("IE", "Ireland", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("IE", "Ireland", "National", "\+353\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("IE", "Ireland", "International", "\+(?!353)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("IL", "Israel", "Emergency", "^\+972112$")
    $routes += [DefaultVoiceRoute]::new("IL", "Israel", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("IL", "Israel", "National", "\+972\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("IL", "Israel", "International", "\+(?!972)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("IN", "India", "Emergency", "^\+911$")
    $routes += [DefaultVoiceRoute]::new("IN", "India", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("IN", "India", "National", "\+91\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("IN", "India", "International", "\+(?!91)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("IT", "Italy", "Emergency", "^\+39112$")
    $routes += [DefaultVoiceRoute]::new("IT", "Italy", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("IT", "Italy", "National", "\+39\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("IT", "Italy", "International", "\+(?!39)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("JP", "Japan", "Emergency", "^\+81119$")
    $routes += [DefaultVoiceRoute]::new("JP", "Japan", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("JP", "Japan", "National", "\+81\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("JP", "Japan", "International", "\+(?!81)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("KR", "South Korea", "Emergency", "^\+82112$")
    $routes += [DefaultVoiceRoute]::new("KR", "South Korea", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("KR", "South Korea", "National", "\+82\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("KR", "South Korea", "International", "\+(?!82)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("MX", "Mexico", "Emergency", "^\+52112$")
    $routes += [DefaultVoiceRoute]::new("MX", "Mexico", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("MX", "Mexico", "National", "\+52\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("MX", "Mexico", "International", "\+(?!52)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("MY", "Malaysia", "Emergency", "^\+60(999|112)$")
    $routes += [DefaultVoiceRoute]::new("MY", "Malaysia", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("MY", "Malaysia", "National", "\+60\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("MY", "Malaysia", "International", "\+(?!60)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("MZ", "Mozambique", "Emergency", "^\+25(11[79]|198)$")
    $routes += [DefaultVoiceRoute]::new("MZ", "Mozambique", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("MZ", "Mozambique", "National", "\+61\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("MZ", "Mozambique", "International", "\+61\d{3,10}$")

    $routes += [DefaultVoiceRoute]::new("NZ", "New Zealand", "Emergency", "^\+64111$")
    $routes += [DefaultVoiceRoute]::new("NZ", "New Zealand", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("NZ", "New Zealand", "National", "\+64\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("NZ", "New Zealand", "International", "\+(?!64)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("PH", "Phillipines", "Emergency", "^\+63(911|143|8888|155|163|1343|1342|136)$")
    $routes += [DefaultVoiceRoute]::new("PH", "Phillipines", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("PH", "Phillipines", "National", "\+63\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("PH", "Phillipines", "International", "\+(?!63)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("SA", "Saudi Arabia", "Emergency", "^\+966(999|997)$")
    $routes += [DefaultVoiceRoute]::new("SA", "Saudi Arabia", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("SA", "Saudi Arabia", "National", "\+966\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("SA", "Saudi Arabia", "International", "\+(?!966)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("SG", "Singapore", "Emergency", "^\+65(999|995)$")
    $routes += [DefaultVoiceRoute]::new("SG", "Singapore", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("SG", "Singapore", "National", "\+65\d{3,12}$")
    $routes += [DefaultVoiceRoute]::new("SG", "Singapore", "International", "\+65\d{3,15}$")

    $routes += [DefaultVoiceRoute]::new("TH", "Thailand", "Emergency", "^\+66112$")
    $routes += [DefaultVoiceRoute]::new("TH", "Thailand", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("TH", "Thailand", "National", "\+66\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("TH", "Thailand", "International", "\+(?!66)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("TW", "Taiwan", "Emergency", "^\+886112$")
    $routes += [DefaultVoiceRoute]::new("TW", "Taiwan", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("TW", "Taiwan", "National", "\+886\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("TW", "Taiwan", "International", "\+(?!886)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("UK", "United Kingdom", "Emergency", "^\+44(112|999)$")
    $routes += [DefaultVoiceRoute]::new("UK", "United Kingdom", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("UK", "United Kingdom", "National", "\+44\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("UK", "United Kingdom", "International", "\+(?!44)\d{10,15}$")
 
    $routes += [DefaultVoiceRoute]::new("US", "United States", "Emergency", "^\+1911$")
    $routes += [DefaultVoiceRoute]::new("US", "United States", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("US", "United States", "National", "\+1\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("US", "United States", "International", "\+(?!1)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("VN", "Vietnam", "Emergency", "^\+84112$")
    $routes += [DefaultVoiceRoute]::new("VN", "Vietnam", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("VN", "Vietnam", "National", "\+84\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("VN", "Vietnam", "International", "\+(?!84)\d{10,15}$")

    $routes += [DefaultVoiceRoute]::new("ZA", "South Africa", "Emergency", "^\+27101(11|77)$")
    $routes += [DefaultVoiceRoute]::new("ZA", "South Africa", "Internal", "^$")
    $routes += [DefaultVoiceRoute]::new("ZA", "South Africa", "National", "\+27\d{3,10}$")
    $routes += [DefaultVoiceRoute]::new("ZA", "South Africa", "International", "\+(?!27)\d{10,15}$")

    return $routes

}


