#Requires -Modules @{ ModuleName="MicrosoftTeams"; ModuleVersion="6.4.0" }
#Requires -Modules @{ ModuleName="TeamsTools"; ModuleVersion="1.0.0" }#
#Requires -Modules @{ ModuleName="TeamsToolsReset"; ModuleVersion="1.0.0" }

# TeamsVirtualTopology
New-TeamsVirtualTopology -domain "sandbox.shanehoey.dev"

# TeamsNetworkRegion
Add-TeamsVirtualNetworkRegion -NetworkRegionID "APAC" 
Add-TeamsVirtualNetworkRegion -NetworkRegionID "AMERICAS"
Add-TeamsVirtualNetworkRegion -NetworkRegionID "EMEA"

# TeamsVirtualNetworkSite
Add-TeamsVirtualNetworkSite -NetworkSiteID "Aus02" -NetworkRegionID "Apac" -Description "Australia - Sydney"
Add-TeamsVirtualNetworkSite -NetworkSiteID "Aus03" -NetworkRegionID "Apac" -Description "Australia - Melbourne"
Add-TeamsVirtualNetworkSite -NetworkSiteID "Aus07" -NetworkRegionID "Apac" -Description "Australia - Brisbane"
Add-TeamsVirtualNetworkSite -NetworkSiteID "Aus08" -NetworkRegionID "Apac" -Description "Australia - Western Australia"

# TeamsVirtualNetworkSubnet
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.2.0   -Mask 25 -NetworkSiteID "Aus02"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.2.128 -Mask 25 -NetworkSiteID "Aus02"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.3.0   -Mask 25 -NetworkSiteID "Aus03"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.3.128 -Mask 25 -NetworkSiteID "Aus03"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.7.0   -Mask 25 -NetworkSiteID "Aus07"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.7.128 -Mask 25 -NetworkSiteID "Aus07"
Add-TeamsVirtualNetworkSubnet -SubnetId 172.16.8.0   -Mask 26 -NetworkSiteID "Aus08"

# TeamsVirtualTrustedIPAddress
Add-TeamsVirtualTrustedIPAddress -IpAddress "198.51.100.0" -Mask 29
Add-TeamsVirtualTrustedIPAddress -IpAddress "203.0.113.0"  -Mask 27
Add-TeamsVirtualTrustedIPAddress -IpAddress "192.0.2.0"    -Mask 28
Add-TeamsVirtualTrustedIPAddress -IpAddress (Invoke-WebRequest -UseBasicParsing api.ipify.org ).Content.Trim() -Mask 32

# TeamsVirtualPSTNGateway
Add-TeamsVirtualPSTNGateway -Identity "sbc02.sandbox.shanehoey.dev" -SipSignalingPort 5062 -MaxConcurrentSessions 10 -FailoverResponseCodes "508,503,504,500" -MediaBypass $false
Add-TeamsVirtualPSTNGateway -Identity "sbc03.sandbox.shanehoey.dev" -SipSignalingPort 5063 -MaxConcurrentSessions 10 -FailoverResponseCodes "508,503,504,500" -MediaBypass $false
Add-TeamsVirtualPSTNGateway -Identity "sbc07.sandbox.shanehoey.dev" -SipSignalingPort 5067 -MaxConcurrentSessions 10 -FailoverResponseCodes "508,503,504,500" -MediaBypass $false
Add-TeamsVirtualPSTNGateway -Identity "sbc08.sandbox.shanehoey.dev" -SipSignalingPort 5068 -MaxConcurrentSessions 10 -FailoverResponseCodes "508,503,504,500" -MediaBypass $false

# TeamsVirtualPSTNUsage

Add-TeamsVirtualPstnUsage -PstnUsage "Aus02-Internal-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus02-National-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus02-International-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus03-Internal-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus03-National-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus03-International-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus07-Internal-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus07-National-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus07-International-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus08-Internal-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus08-National-PU1"
Add-TeamsVirtualPstnUsage -PstnUsage "Aus08-International-PU1"


# TeamsVirtualVoiceRoute
$emergency = get-teamsDefaultVoiceRoutes -CountryCode "AU" -type "Emergency"
$internal = get-teamsDefaultVoiceRoutes -CountryCode "AU" -type "Internal"
$national = get-teamsDefaultVoiceRoutes  -CountryCode "AU" -type "National"
$international = get-teamsDefaultVoiceRoutes  -CountryCode "AU" -type "International"


Add-TeamsVirtualVoiceRoute  -Identity "Aus02-Internal-VR1" -PstnUsageList "Aus02-Internal-PU1" -pstngatewayList "sbc02.sandbox.shanehoey.dev"  -NumberPattern $internal.Pattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "Aus02-National-VR1"-PstnUsageList "Aus02-National-PU1"-pstngatewayList "sbc02.sandbox.shanehoey.dev" -NumberPattern $national.Pattern -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "Aus02-International-VR1" -PstnUsageList "Aus02-International-PU1" -pstngatewayList "sbc02.sandbox.shanehoey.dev" -NumberPattern $international.Pattern  -Priority 10000

Add-TeamsVirtualVoiceRoute  -Identity "Aus03-Internal-VR1" -PstnUsageList "Aus03-Internal-PU1" -pstngatewayList "sbc03.sandbox.shanehoey.dev"  -NumberPattern $internal.Pattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "Aus03-National-VR1"-PstnUsageList "Aus03-National-PU1"-pstngatewayList "sbc03.sandbox.shanehoey.dev" -NumberPattern $national.Pattern -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "Aus03-International-VR1" -PstnUsageList "Aus03-International-PU1" -pstngatewayList "sbc03.sandbox.shanehoey.dev" -NumberPattern $international.Pattern  -Priority 10000

Add-TeamsVirtualVoiceRoute  -Identity "Aus07-Internal-VR1" -PstnUsageList "Aus07-Internal-PU1" -pstngatewayList "sbc07.sandbox.shanehoey.dev"  -NumberPattern $internal.Pattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "Aus07-National-VR1"-PstnUsageList "Aus07-National-PU1"-pstngatewayList "sbc07.sandbox.shanehoey.dev" -NumberPattern $national.Pattern -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "Aus07-International-VR1" -PstnUsageList "Aus07-International-PU1" -pstngatewayList "sbc07.sandbox.shanehoey.dev" -NumberPattern $international.Pattern  -Priority 10000

Add-TeamsVirtualVoiceRoute  -Identity "Aus08-Internal-VR1" -PstnUsageList "Aus08-Internal-PU1" -pstngatewayList "sbc08.sandbox.shanehoey.dev"  -NumberPattern $internal.Pattern  -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "Aus08-National-VR1"-PstnUsageList "Aus08-National-PU1"-pstngatewayList "sbc08.sandbox.shanehoey.dev" -NumberPattern $national.Pattern -Priority 10000
Add-TeamsVirtualVoiceRoute  -Identity "Aus08-International-VR1" -PstnUsageList "Aus08-International-PU1" -pstngatewayList "sbc08.sandbox.shanehoey.dev" -NumberPattern $international.Pattern -Priority 10000


# TeamsVirtualVoiceRoutingPolicy
Add-TeamsVirtualVoiceRoutingPolicy -identity "Aus07-National" -PstnUsageList "Aus07-Internal-PU1", "Aus07-National-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "Aus07-International" -PstnUsageList "Aus07-Internal-PU1", "Aus07-National-PU1", "Aus07-International-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "Aus02-National" -PstnUsageList "Aus02-Internal-PU1", "Aus02-National-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "Aus02-International" -PstnUsageList "Aus02-Internal-PU1", "Aus02-National-PU1", "Aus02-International-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "Aus03-National" -PstnUsageList "Aus03-Internal-PU1", "Aus03-National-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "Aus03-International" -PstnUsageList "Aus03-Internal-PU1", "Aus03-National-PU1", "Aus03-International-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "Aus08-National" -PstnUsageList "Aus08-Internal-PU1", "Aus08-National-PU1"
Add-TeamsVirtualVoiceRoutingPolicy -identity "Aus08-International" -PstnUsageList "Aus08-Internal-PU1", "Aus08-National-PU1", "Aus08-International-PU1"

# TeamsVirtualDialPlan
Add-TeamsVirtualDialPlan -identity "Aus02-DP1"
Add-TeamsVirtualDialPlan -identity "Aus03-DP1"
Add-TeamsVirtualDialPlan -identity "Aus07-DP1"
Add-TeamsVirtualDialPlan -identity "Aus08-DP1"

# TeamsVirtualVoiceNormalisation
$emergency = get-teamsDefaultVoiceNormalisationRules -CountryCode "AU" -type "Emergency"
$internal = get-teamsDefaultVoiceNormalisationRules -CountryCode "AU" -Type  "Internal"
$local = get-teamsDefaultVoiceNormalisationRules  -CountryCode "AU" -Type  "Local"
$national = get-teamsDefaultVoiceNormalisationRules  -CountryCode "AU" -Type  "National"
$service = get-teamsDefaultVoiceNormalisationRules  -CountryCode "AU" -Type  "Service"
$international = get-teamsDefaultVoiceNormalisationRules  -CountryCode "AU" -Type  "International"

Add-TeamsVirtualVoiceNormalisation -parent "Aus02-DP1" -name "Emergency" -Pattern $Emergency.Pattern -Translation $Emergency.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus02-DP1" -name "Internal" -Pattern $Internal.Pattern -Translation $Internal.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus02-DP1" -name "FakePSTN" -Pattern '^(9\d{3})$' -Translation '+6177010$1'
Add-TeamsVirtualVoiceNormalisation -parent "Aus02-DP1" -name "Local" -Pattern $Local[0].Pattern  -Translation $Local[0].Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus02-DP1" -name "National" -Pattern $National.Pattern -Translation $National.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus02-DP1" -name "Service" -Pattern $Service.Pattern  -Translation $Service.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus02-DP1" -name "International" -Pattern $International.Pattern -Translation $International.Translation

Add-TeamsVirtualVoiceNormalisation -parent "Aus03-DP1" -name "Emergency" -Pattern $Emergency.Pattern -Translation $Emergency.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus03-DP1" -name "Internal" -Pattern $Internal.Pattern -Translation $Internal.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus03-DP1" -name "FakePSTN" -Pattern '^(9\d{3})$' -Translation '+6177010$1'
Add-TeamsVirtualVoiceNormalisation -parent "Aus03-DP1" -name "Local" -Pattern $Local[1].Pattern  -Translation $Local[1].Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus03-DP1" -name "National" -Pattern $National.Pattern -Translation $National.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus03-DP1" -name "Service" -Pattern $Service.Pattern  -Translation $Service.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus03-DP1" -name "International" -Pattern $International.Pattern -Translation $International.Translation

Add-TeamsVirtualVoiceNormalisation -parent "Aus07-DP1" -name "Emergency" -Pattern $Emergency.Pattern -Translation $Emergency.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus07-DP1" -name "Internal" -Pattern $Internal.Pattern -Translation $Internal.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus07-DP1" -name "FakePSTN" -Pattern '^(9\d{3})$' -Translation '+6177010$1'
Add-TeamsVirtualVoiceNormalisation -parent "Aus07-DP1" -name "Local" -Pattern $Local[2].Pattern  -Translation $Local[2].Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus07-DP1" -name "National" -Pattern $National.Pattern -Translation $National.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus07-DP1" -name "Service" -Pattern $Service.Pattern  -Translation $Service.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus07-DP1" -name "International" -Pattern $International.Pattern -Translation $International.Translation

Add-TeamsVirtualVoiceNormalisation -parent "Aus08-DP1" -name "Emergency" -Pattern $Emergency.Pattern -Translation $Emergency.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus08-DP1" -name "Internal" -Pattern $Internal.Pattern -Translation $Internal.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus08-DP1" -name "FakePSTN" -Pattern '^(9\d{3})$' -Translation '+6177010$1'
Add-TeamsVirtualVoiceNormalisation -parent "Aus08-DP1" -name "Local" -Pattern $Local[3].Pattern  -Translation $Local[3].Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus08-DP1" -name "National" -Pattern $National.Pattern -Translation $National.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus08-DP1" -name "Service" -Pattern $Service.Pattern  -Translation $Service.Translation
Add-TeamsVirtualVoiceNormalisation -parent "Aus08-DP1" -name "International" -Pattern $International.Pattern -Translation $International.Translation

#TODO TeamsVirtualEmergencyCallRoutingPolicy
#TODO TeamsVirtualEmergencyCallingPolicy
#TODO TeamsVirtualPhonePolicy
#TODO TeamsVirtualCallingLineIdentity
#TODO TeamsPhonePolicy
#TODO TeamsCallingLineIdentity
#TODO TeamsCallingPolicy
#TODO TeamsCallParkPolicy
#TODO TeamsCallHoldPolicy
#TODO TeamsMobilityPolicy
#TODO TeamsVoiceMailPolicy

# TeamsVirtualSurvivableBranchAppliance
Add-TeamsVirtualSurvivableBranchAppliance -identity "sba.sandbox.shanehoey.dev"

# TeamsVirtualSurvivableBranchAppliancePolicy
Add-TeamsVirtualSurvivableBranchAppliancePolicy -Identity "SBA" -BranchApplianceFqdns "sba.sandbox.shanehoey.dev" 


# TeamsVirtualUser
#Aus07
Add-TeamsVirtualUser -identity "adelev@sandbox.shanehoey.dev" -TelephoneNumber "+61770107701" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus07-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "alland@sandbox.shanehoey.dev" -TelephoneNumber "+61770107702" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus07-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "christiec@sandbox.shanehoey.dev" -TelephoneNumber "+61770107703" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus07-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "isaiahl@sandbox.shanehoey.dev" -TelephoneNumber "+61770107704" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus07-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "leeg@sandbox.shanehoey.dev" -TelephoneNumber "+61770107705" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus07-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "johannal@sandbox.shanehoey.dev" -TelephoneNumber "+61755505501" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus07-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
Add-TeamsVirtualUser -identity "jonis@sandbox.shanehoey.dev" -TelephoneNumber "+61755505502" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus07-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
#Add-TeamsVirtualUser -identity "miriamg@sandbox.shanehoey.dev" -TelephoneNumber "+61755505503" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus08-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
#Aus02
Add-TeamsVirtualUser -identity "debrab@sandbox.shanehoey.dev" -TelephoneNumber "+61270102201" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus02-International" -Dialplan "Aus02-DP1" -EnterpriseVoiceEnabled $TRUE
Add-TeamsVirtualUser -identity "diegos@sandbox.shanehoey.dev" -TelephoneNumber "+61270102202" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus02-International" -Dialplan "Aus02-DP1" -EnterpriseVoiceEnabled $TRUE
#Add-TeamsVirtualUser -identity "irvins@sandbox.shanehoey.dev" -TelephoneNumber "+61270102203" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus02-International" -Dialplan "Aus02-DP1" -EnterpriseVoiceEnabled $TRUE
#Aus03
Add-TeamsVirtualUser -identity "pattif@sandbox.shanehoey.dev" -TelephoneNumber "+61370103301" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus03-International" -Dialplan "Aus03-DP1" -EnterpriseVoiceEnabled $TRUE
Add-TeamsVirtualUser -identity "nestorw@sandbox.shanehoey.dev" -TelephoneNumber "+61370103302" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus03-International" -Dialplan "Aus03-DP1" -EnterpriseVoiceEnabled $TRUE
#Add-TeamsVirtualUser -identity "pradeepg@sandbox.shanehoey.dev" -TelephoneNumber "+61370103303" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus03-International" -Dialplan "Aus03-DP1" -EnterpriseVoiceEnabled $TRUE
#Aus08
Add-TeamsVirtualUser -identity "lidiah@sandbox.shanehoey.dev" -TelephoneNumber "+61870108801" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus08-International" -Dialplan "Aus08-DP1" -EnterpriseVoiceEnabled $TRUE 
Add-TeamsVirtualUser -identity "lynner@sandbox.shanehoey.dev" -TelephoneNumber "+61870108802" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus08-International" -Dialplan "Aus08-DP1" -EnterpriseVoiceEnabled $TRUE 

#Calling Plan
#Add-TeamsVirtualUser -identity "alexw@sandbox.shanehoey.dev"  -TelephoneNumber "+61770107703" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus07-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
#Add-TeamsVirtualUser -identity "meganb@sandbox.shanehoey.dev" -TelephoneNumber "+61755505501" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus08-International" -Dialplan "Aus07-DP1" -EnterpriseVoiceEnabled $TRUE -SurvivableBranchAppliancePolicy "SBA"
#Add-TeamsVirtualUser -identity "gradya@sandbox.shanehoey.dev" -TelephoneNumber "+61270102203" -telephoneNumberType "DirectRouting" -usagelocation "AU" -VoiceRoutingPolicy "Aus02-International" -Dialplan "Aus02-DP1" -EnterpriseVoiceEnabled $TRUE

# TODO TeamsVirtualDevice
# TODO TeamsMeetingRoom


# Upload Telephone Numbers
# TODO -TeamsVirtualTelephoneNumber as per bellow 

New-CsOnlineDirectRoutingTelephoneNumberUploadOrder -StartingNumber "+61270102201" -EndingNumber "+61270102209"
New-CsOnlineDirectRoutingTelephoneNumberUploadOrder -StartingNumber "+61370103301" -EndingNumber "+61370103309"
New-CsOnlineDirectRoutingTelephoneNumberUploadOrder -StartingNumber "+61770107700" -EndingNumber "+61770107799"
New-CsOnlineDirectRoutingTelephoneNumberUploadOrder -StartingNumber "+61755505500" -EndingNumber "+61755505509"
New-CsOnlineDirectRoutingTelephoneNumberUploadOrder -StartingNumber "+61870108801" -EndingNumber "+61870108809"

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




