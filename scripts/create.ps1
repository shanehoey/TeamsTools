try {
    get-cstenant | Select-Object Sipdomain
}
catch {
    Connect-MicrosoftTeams -UseDeviceAuthentication
}

Import-Module  -Name .\teamstools\ -Verbose -Force

# TeamsVirtualTopology
New-TeamsVirtualTopology -domain "sandbox.audicodes.dev"

# TeamsNetworkRegion
Add-TeamsVirtualNetworkRegion -NetworkRegionID "APAC" 
Add-TeamsVirtualNetworkRegion -NetworkRegionID "AMERICAS"
Add-TeamsVirtualNetworkRegion -NetworkRegionID "EMEA"


# TeamsVirtualNetworkSite
Add-TeamsVirtualNetworkSite -NetworkSiteID "AUBNE" -NetworkRegionID "APAC" -Description "Australia Brisbane"
Add-TeamsVirtualNetworkSite -NetworkSiteID "AUOOL" -NetworkRegionID "APAC" -Description "Australia Gold Coast"
Add-TeamsVirtualNetworkSite -NetworkSiteID "AUSYD" -NetworkRegionID "APAC" -Description "Australia Sydney"
Add-TeamsVirtualNetworkSite -NetworkSiteID "AUMEL" -NetworkRegionID "APAC" -Description "Australia Melbourne"


# TeamsVirtualNetworkSubnet
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.8.0 -Mask 24 -NetworkSiteID "AUBNE"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.9.0 -Mask 24 -NetworkSiteID "AUBNE"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.35.0 -Mask 24 -NetworkSiteID "AUOOL"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.17.1.0 -Mask 25 -NetworkSiteID "AUSYD"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.17.1.128 -Mask 25 -NetworkSiteID "AUSYD"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.17.2.0 -Mask 25 -NetworkSiteID "AUMEL"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.17.2.128 -Mask 25 -NetworkSiteID "AUMEL"


# TeamsVirtualTrustedIPAddress
Add-TeamsVirtualTrustedIPAddress -IpAddress "198.51.100.0" -Mask 29
Add-TeamsVirtualTrustedIPAddress -IpAddress "203.0.113.0" -Mask 27
Add-TeamsVirtualTrustedIPAddress -IpAddress "192.0.2.0" -Mask 28


# TeamsVirtualPSTNGateway
Add-TeamsVirtualPSTNGateway -Identity "sbc-syd.sandbox.shanehoey.dev" -SipSignalingPort 5062 -MaxConcurrentSessions 10 -FailoverResponseCodes "508,503,504,500" -MediaBypass $true
Add-TeamsVirtualPSTNGateway -Identity "sbc-mel.sandbox.shanehoey.dev" -SipSignalingPort 5063 -MaxConcurrentSessions 10 -FailoverResponseCodes "508,503,504,500" -MediaBypass $true
Add-TeamsVirtualPSTNGateway -Identity "sbc-bne.sandbox.shanehoey.dev" -SipSignalingPort 5067 -MaxConcurrentSessions 10 -FailoverResponseCodes "508,503,504,500" -MediaBypass $true -GatewaySiteId "AUBNE"
Add-TeamsVirtualPSTNGateway -Identity "sbc-ool.sandbox.shanehoey.dev" -SipSignalingPort 5067 -MaxConcurrentSessions 10 -FailoverResponseCodes "508,503,504,500" -MediaBypass $true -GatewaySiteId "AUOOL" -BypassMode "Always" -ProxySbc "sbc-bne.sandbox.shanehoey.dev"


# TeamsVirtualPSTNUsage
Add-TeamsVirtualPstnUsage -PstnUsage "AUBNE-Internal-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUBNE-National-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUBNE-International-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUOOL-Internal-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUOOL-National-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUOOL-International-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUSYD-Internal-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUSYD-National-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUSYD-International-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUMEL-Internal-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUMEL-National-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "AUMEL-International-PU1"

# TeamsVirtualVoiceRoute
$VoiceRoutes = ([xml](invoke-webrequest https://gist.githubusercontent.com/shanehoey/68c3f24ea4301d84220891f830b73b63/raw/6b61c95566b42a6a842ab6f815a705380521e281/defaults.xml).content).defaults.voiceroute

Add-TeamsVirtualVoiceRoute  -Identity "AUBNE-Internal-VR1" -PstnUsageList "AUBNE-Internal-PU1" -pstngatewayList "sbc-bne.sandbox.shanehoey.dev"  -NumberPattern $VoiceRoutes.AU.Internal.NumberPattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUBNE-National-VR1"-PstnUsageList "AUBNE-National-PU1"-pstngatewayList "sbc-bne.sandbox.shanehoey.dev" -NumberPattern $VoiceRoutes.AU.National.NumberPattern -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUBNE-International-VR1" -PstnUsageList "AUBNE-International-PU1" -pstngatewayList "sbc-bne.sandbox.shanehoey.dev" -NumberPattern $VoiceRoutes.AU.International.NumberPattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUOOL-Internal-VR1" -PstnUsageList "AUOOL-Internal-PU1" -pstngatewayList "sbc-ool.sandbox.shanehoey.dev"  -NumberPattern $VoiceRoutes.AU.Internal.NumberPattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUOOL-National-VR1"-PstnUsageList "AUOOL-National-PU1"-pstngatewayList "sbc-ool.sandbox.shanehoey.dev" -NumberPattern $VoiceRoutes.AU.National.NumberPattern -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUOOL-International-VR1" -PstnUsageList "AUOOL-International-PU1" -pstngatewayList "sbc-ool.sandbox.shanehoey.dev" -NumberPattern $VoiceRoutes.AU.International.NumberPattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUSYD-Internal-VR1" -PstnUsageList "AUSYD-Internal-PU1" -pstngatewayList "sbc-syd.sandbox.shanehoey.dev"  -NumberPattern $VoiceRoutes.AU.Internal.NumberPattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUSYD-National-VR1"-PstnUsageList "AUSYD-National-PU1"-pstngatewayList "sbc-syd.sandbox.shanehoey.dev" -NumberPattern $VoiceRoutes.AU.National.NumberPattern -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUSYD-International-VR1" -PstnUsageList "AUSYD-International-PU1" -pstngatewayList "sbc-syd.sandbox.shanehoey.dev" -NumberPattern $VoiceRoutes.AU.International.NumberPattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUMEL-Internal-VR1" -PstnUsageList "AUMEL-Internal-PU1" -pstngatewayList "sbc-mel.sandbox.shanehoey.dev"  -NumberPattern $VoiceRoutes.AU.Internal.NumberPattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUMEL-National-VR1"-PstnUsageList "AUMEL-National-PU1"-pstngatewayList "sbc-mel.sandbox.shanehoey.dev" -NumberPattern $VoiceRoutes.AU.National.NumberPattern -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "AUMEL-International-VR1" -PstnUsageList "AUMEL-International-PU1" -pstngatewayList "sbc-mel.sandbox.shanehoey.dev" -NumberPattern $VoiceRoutes.AU.International.NumberPattern  -Priority 10000


# TeamsVirtualVoiceRoutingPolicy
Add-TeamsVirtualVoiceRoutingPolicy -identity "AUBNE-National" -PstnUsageList "AUBNE-Internal-PU1", "AUBNE-National-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "AUBNE-International" -PstnUsageList "AUBNE-Internal-PU1", "AUBNE-National-PU1", "AUBNE-International-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "AUOOL-National" -PstnUsageList "AUOOL-Internal-PU1", "AUOOL-National-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "AUOOL-International" -PstnUsageList "AUOOL-Internal-PU1", "AUOOL-National-PU1", "AUOOL-International-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "AUSYD-National" -PstnUsageList "AUSYD-Internal-PU1", "AUSYD-National-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "AUSYD-International" -PstnUsageList "AUSYD-Internal-PU1", "AUSYD-National-PU1", "AUSYD-International-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "AUMEL-National" -PstnUsageList "AUMEL-Internal-PU1", "AUMEL-National-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "AUMEL-International" -PstnUsageList "AUMEL-Internal-PU1", "AUMEL-National-PU1", "AUMEL-International-PU1"


# TeamsVirtualDialPlan
Add-TeamsVirtualDialPlan -identity "AU02-DP1"
Add-TeamsVirtualDialPlan -identity "AU03-DP1"
Add-TeamsVirtualDialPlan -identity "AU07-DP1"
Add-TeamsVirtualDialPlan -identity "AU08-DP1"

# TeamsVirtualVoiceNormalisation
$VoiceNormalisation = ([xml](invoke-webrequest https://gist.githubusercontent.com/shanehoey/68c3f24ea4301d84220891f830b73b63/raw/6b61c95566b42a6a842ab6f815a705380521e281/defaults.xml).content).defaults.VoiceNormalisation
Add-TeamsVirtualVoiceNormalisation -parent "AU02-DP1" -name "Emergency" -Pattern $VoiceNormalisation.AU.Emergency.Pattern -Translation $VoiceNormalisation.AU.Emergency.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU02-DP1" -name "FakePSTN" -Pattern '^(9\d{3})$' -Translation '+6177010$1'
Add-TeamsVirtualVoiceNormalisation -parent "AU02-DP1" -name "Local" -Pattern $VoiceNormalisation.AU.Local[0].Pattern  -Translation $VoiceNormalisation.AU.Local[0].Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU02-DP1" -name "National" -Pattern $VoiceNormalisation.AU.National.Pattern -Translation $VoiceNormalisation.AU.National.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU02-DP1" -name "Service" -Pattern $VoiceNormalisation.AU.Service.Pattern  -Translation $VoiceNormalisation.AU.Service.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU02-DP1" -name "International" -Pattern $VoiceNormalisation.AU.International.Pattern -Translation $VoiceNormalisation.AU.International.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU03-DP1" -name "Emergency" -Pattern $VoiceNormalisation.AU.Emergency.Pattern -Translation $VoiceNormalisation.AU.Emergency.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU03-DP1" -name "FakePSTN" -Pattern '^(9\d{3})$' -Translation '+6177010$1'
Add-TeamsVirtualVoiceNormalisation -parent "AU03-DP1" -name "Local" -Pattern $VoiceNormalisation.AU.Local[1].Pattern  -Translation $VoiceNormalisation.AU.Local[1].Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU03-DP1" -name "National" -Pattern $VoiceNormalisation.AU.National.Pattern -Translation $VoiceNormalisation.AU.National.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU03-DP1" -name "Service" -Pattern $VoiceNormalisation.AU.Service.Pattern  -Translation $VoiceNormalisation.AU.Service.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU03-DP1" -name "International" -Pattern $VoiceNormalisation.AU.International.Pattern -Translation $VoiceNormalisation.AU.International.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU07-DP1" -name "Emergency" -Pattern $VoiceNormalisation.AU.Emergency.Pattern -Translation $VoiceNormalisation.AU.Emergency.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU07-DP1" -name "FakePSTN" -Pattern '^(9\d{3})$' -Translation '+6177010$1'
Add-TeamsVirtualVoiceNormalisation -parent "AU07-DP1" -name "Local" -Pattern $VoiceNormalisation.AU.Local[2].Pattern  -Translation $VoiceNormalisation.AU.Local[2].Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU07-DP1" -name "National" -Pattern $VoiceNormalisation.AU.National.Pattern -Translation $VoiceNormalisation.AU.National.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU07-DP1" -name "Service" -Pattern $VoiceNormalisation.AU.Service.Pattern  -Translation $VoiceNormalisation.AU.Service.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU07-DP1" -name "International" -Pattern $VoiceNormalisation.AU.International.Pattern -Translation $VoiceNormalisation.AU.International.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU08-DP1" -name "Emergency" -Pattern $VoiceNormalisation.AU.Emergency.Pattern -Translation $VoiceNormalisation.AU.Emergency.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU08-DP1" -name "FakePSTN" -Pattern '^(9\d{3})$' -Translation '+6177010$1'
Add-TeamsVirtualVoiceNormalisation -parent "AU08-DP1" -name "Local" -Pattern $VoiceNormalisation.AU.Local[3].Pattern  -Translation $VoiceNormalisation.AU.Local[3].Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU08-DP1" -name "National" -Pattern $VoiceNormalisation.AU.National.Pattern -Translation $VoiceNormalisation.AU.National.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU08-DP1" -name "Service" -Pattern $VoiceNormalisation.AU.Service.Pattern  -Translation $VoiceNormalisation.AU.Service.Translation
Add-TeamsVirtualVoiceNormalisation -parent "AU08-DP1" -name "International" -Pattern $VoiceNormalisation.AU.International.Pattern -Translation $VoiceNormalisation.AU.International.Translation

# TeamsVirtualEmergencyCallRoutingPolicy
# TeamsVirtualEmergencyCallingPolicy
# TeamsVirtualPhonePolicy
# TeamsVirtualCallingLineIdentity
# TeamsPhonePolicy
# TeamsCallingLineIdentity
# TeamsCallingPolicy
# TeamsCallParkPolicy
# TeamsCallHoldPolicy
# TeamsMobilityPolicy
# TeamsVoiceMailPolicy

# TeamsVirtualSurvivableBranchAppliance
Add-TeamsVirtualSurvivableBranchAppliance -identity "sba.sandbox.shanehoey.dev"

# TeamsVirtualSurvivableBranchAppliancePolicy
Add-TeamsVirtualSurvivableBranchAppliancePolicy -Identity "SBA" -BranchApplianceFqdns "sba.sandbox.shanehoey.dev" 


# TeamsVirtualUser
#bne
Add-TeamsVirtualUser -identity "adelev@sandbox.shanehoey.dev" -TelephoneNumber "+61770107701" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUBNE-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "leeg@sandbox.shanehoey.dev" -TelephoneNumber "+61770107702" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUBNE-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "alexw@sandbox.shanehoey.dev"  -TelephoneNumber "+61770107703" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUBNE-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "alland@sandbox.shanehoey.dev" -TelephoneNumber "+61770107704" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUBNE-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "christiec@sandbox.shanehoey.dev" -TelephoneNumber "+61770107705" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUBNE-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "isaiahl@sandbox.shanehoey.dev" -TelephoneNumber "+61770107706" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUBNE-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "lidiah@sandbox.shanehoey.dev" -TelephoneNumber "+61770107707" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUBNE-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
#syd
Add-TeamsVirtualUser -identity "debrab@sandbox.shanehoey.dev" -TelephoneNumber "+61270102201" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUSYD-International" -Dialplan "AU02-DP1" -EnterpriseVoiceEnabled $TRUE
Add-TeamsVirtualUser -identity "diegos@sandbox.shanehoey.dev" -TelephoneNumber "+61270102202" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUSYD-International" -Dialplan "AU02-DP1" -EnterpriseVoiceEnabled $TRUE
Add-TeamsVirtualUser -identity "gradya@sandbox.shanehoey.dev" -TelephoneNumber "+61270102203" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUSYD-International" -Dialplan "AU02-DP1" -EnterpriseVoiceEnabled $TRUE
Add-TeamsVirtualUser -identity "irvins@sandbox.shanehoey.dev" -TelephoneNumber "+61270102204" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUSYD-International" -Dialplan "AU02-DP1" -EnterpriseVoiceEnabled $TRUE
#mel
Add-TeamsVirtualUser -identity "pattif@sandbox.shanehoey.dev" -TelephoneNumber "+61370103301" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUMEL-International" -Dialplan "AU03-DP1" -EnterpriseVoiceEnabled $TRUE
Add-TeamsVirtualUser -identity "nestorw@sandbox.shanehoey.dev" -TelephoneNumber "+61370103302" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUMEL-International" -Dialplan "AU03-DP1" -EnterpriseVoiceEnabled $TRUE
Add-TeamsVirtualUser -identity "pradeepg@sandbox.shanehoey.dev" -TelephoneNumber "+61370103303" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUMEL-International" -Dialplan "AU03-DP1" -EnterpriseVoiceEnabled $TRUE
Add-TeamsVirtualUser -identity "lynner@sandbox.shanehoey.dev" -TelephoneNumber "+61370103304" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUMEL-International" -Dialplan "AU03-DP1" -EnterpriseVoiceEnabled $TRUE 
#ool
Add-TeamsVirtualUser -identity "meganb@sandbox.shanehoey.dev" -TelephoneNumber "+61755505501" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUOOL-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "johannal@sandbox.shanehoey.dev" -TelephoneNumber "+61755505502" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUOOL-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "jonis@sandbox.shanehoey.dev" -TelephoneNumber "+61755505503" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUOOL-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "miriamg@sandbox.shanehoey.dev" -TelephoneNumber "+61755505504" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "AUOOL-International" -Dialplan "AU07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"


# TeamsVirtualDevice
# TeamsMeetingRoom

## Invoke changes
Get-TeamsVirtualNetworkRegion | Invoke-TeamsNetworkRegion -confirm:$false -verbose
Get-TeamsVirtualNetworkSite | Invoke-TeamsNetworkSite -confirm:$false -verbose
Get-TeamsVirtualNetworkSubnet | Invoke-TeamsNetworkSubnet -confirm:$false -verbose
Get-TeamsVirtualTrustedIPAddress | Invoke-TeamsTrustedIPAddress -confirm:$false -verbose
Get-TeamsVirtualPSTNGateway | Invoke-TeamsPstnGateway -confirm:$false -verbose
Get-TeamsVirtualPstnUsage | Invoke-TeamsPstnUsage -confirm:$false -verbose
Get-TeamsVirtualVoiceRoute | Invoke-TeamsVoiceRoute -confirm:$false -verbose
Get-teamsVirtualVoiceRoutingPolicy | Invoke-TeamsVoiceRoutingPolicy -confirm:$false -verbose
Invoke-TeamsDialPlan -VirtualDialPlan (Get-TeamsVirtualDialPlan) -VirtualVoiceNormalisation (Get-TeamsVirtualVoiceNormalisation) -confirm:$false -verbose
Get-TeamsVirtualSurvivableBranchAppliance | Invoke-TeamsSurvivableBranchAppliance -confirm:$false -verbose
Get-TeamsVirtualSurvivableBranchAppliancePolicy | Invoke-TeamsSurvivableBranchAppliancePolicy -confirm:$false -verbose
Get-TeamsVirtualUser | Invoke-TeamsUser -confirm:$false -verbose
