# TeamsTools
# https://github.com/shanehoey/TeamsTools

<#
    Copyright (c) 2016-2025 Shane Hoey

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#>



enum Source {
    Virtual = 1
    Tenant = 2
    Unspecified =99
}

class VirtualNetworkRegion {
    
    # CentralSite
    # Description
    # Identity
    # NetworkRegionID

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.]{1,32}$")]
    [String]$NetworkRegionId
    
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source
    
    [AllowNull()]
    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description

    VirtualNetworkRegion([String]$NetworkRegionId) {
        $this.NetworkRegionId = $NetworkRegionId
        $this.Source = "Unspecified"
    }

}

class VirtualNetworkSite {

   # Description
   # EmergencyCallingPolicy
   # EmergencyCallRoutingPolicy
   # EnableLocationBasedRouting
   # Identity
   # LocationPolicyID
   # NetworkRegionID
   # NetworkRoamingPolicy
   # NetworkSiteID
   # OnlineVoiceRoutingPolicy
   # PhoneNumbers
   # SiteAddress

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.]{1,32}$")]
    [String]$NetworkSiteId

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.]{1,32}$")]
    [String]$NetworkRegionId

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description

    VirtualNetworkSite([String]$NetworkSiteId, [String]$NetworkRegionId) {
        $this.NetworkSiteId = $NetworkSiteId
        $this.NetworkRegionId = $NetworkRegionId
        $this.Source = "Unspecified"
    }

    VirtualNetworkSite([String]$NetworkSiteId, [String]$NetworkRegionId, [Source]$Source) {
        $this.NetworkSiteId = $NetworkSiteId
        $this.NetworkRegionId = $NetworkRegionId
        $this.Source = $Source
    } 
}
  
class VirtualNetworkSubnet {

    # Description
    # Identity
    # MaskBits
    # NetworkSiteID
    # SubnetID


    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.]{1,32}$")]
    [String]$NetworkSiteId

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")]
    [String]$SubnetId

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(([0-9]|[1-2][0-9]|3[0-2]))$")]
    [String]$Mask

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source
    
    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description

    VirtualNetworkSubnet([String]$NetworkSiteID, [String]$SubnetId, [String]$Mask) {
        $this.NetworkSiteID = $NetworkSiteID
        $this.SubnetId = $SubnetId
        $this.Mask = $Mask
        $this.Source = "Unspecified"
    }

    VirtualNetworkSubnet([String]$NetworkSiteID, [String]$SubnetId, [String]$Mask, [Source]$Source) {
        $this.NetworkSiteID = $NetworkSiteID
        $this.SubnetId = $SubnetId
        $this.Mask = $Mask
        $this.Source = $Source
    } 
}

class VirtualTrustedIpAddress {
    
    # Description
    # Identity
    # IPAddress
    # MaskBits

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$")]
    [String]$IpAddress

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(([0-9]|[1-2][0-9]|3[0-2]))$")]
    [String]$Mask

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description
    
    VirtualTrustedIPAddress([String]$IpAddress) {
        $this.IpAddress = $IpAddress.split("/")[0]
        $this.Mask = $IpAddress.split("/")[1]
        $this.Source = "Unspecified"
    }

    VirtualTrustedIpAddress([String]$IpAddress, [String]$Mask) {
        $this.IpAddress = $IpAddress
        $this.Mask = $Mask
        $this.Source = "Unspecified"
    }

    VirtualTrustedIpAddress([String]$IpAddress, [String]$Mask, [Source]$Source) {
        $this.IpAddress = $IpAddress
        $this.Mask = $Mask
        $this.Source = $Source
    } 
}

class VirtualPstnGateway {

    # BypassMode
    # Description
    # Enabled
    # FailoverResponseCodes
    # FailoverTimeSeconds
    # ForwardCallHistory
    # ForwardPai
    # Fqdn
    # GatewayLbrEnabledUserOverride
    # GatewaySiteId
    # GatewaySiteLbrEnabled
    # Identity
    # InboundPstnNumberTranslationRules
    # InboundTeamsNumberTranslationRules
    # MaxConcurrentSessions
    # MediaBypass
    # MediaRelayRoutingLocationOverride
    # OutboundPstnNumberTranslationRules
    # OutboundTeamsNumberTranslationRules
    # OutbundTeamsNumberTranslationRules
    # PidfLoSupported
    # ProxySbc
    # SendSipOptions
    # SipSignalingPort

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(?!-)(?:[A-Za-z0-9-]{1,63}\.){1,126}(?:[A-Za-z]{2,63})$")]
    [String]$Identity

    [ValidatePattern("\b(?:[1-9]\d{0,3}|[1-5]\d{4}|6[0-4]\d{3}|65[0-4]\d{2}|655[0-2]\d|6553[0-5])\b")]
    [int] $SipSignalingPort

    [int] $MaxConcurrentSessions
    
    [Boolean] $SendSipOptions
    
    [Boolean] $ForwardCallHistory
    
    [Boolean] $ForwardPai 
    
    [ValidatePattern("([4-6]\d{2})(?:,([4-6]\d{2}))*")]
    [String] $FailoverResponseCodes
    
    [Int] $FailoverTimeSeconds	
    
    [Boolean] $MediaBypass
    
    [ValidateSet("None", "Always", "OnlyForLocalUsers")]
    [String] $BypassMode
    
    [ValidatePattern("^(?!-)(?:[A-Za-z0-9-]{1,63}\.){1,126}(?:[A-Za-z]{2,63})$")]
    [String] $ProxySbc	
    
    [Boolean] $Enabled	
    
    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    
    [String] $Description	
    
    [Boolean] $GatewayLbrEnabledUserOverride 	
    
    [ValidatePattern("^[a-zA-Z0-9_.]{1,32}$")]
    [String] $GatewaySiteId 	
    
    [Boolean] $GatewaySiteLbrEnabled 	
    
    [String] $InboundPstnNumberTranslationRules 	
    
    [String] $InboundTeamsNumberTranslationRules 	
    
    [String] $MediaRelayRoutingLocationOverride 	
    
    [String] $OutboundPstnNumberTranslationRules 	
    
    [String] $OutboundTeamsNumberTranslationRules
    
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualPstnGateway ([String]$Identity) {
        $this.Identity = $Identity
        $this.BypassMode = "None"
        $this.Enabled = $true
        $this.FailoverResponseCodes = "408,503,504,500"
        $this.FailoverTimeSeconds = 10
        $this.ForwardCallHistory = $true
        $this.ForwardPai = $true
        $this.GatewayLbrEnabledUserOverride = $false
        $this.GatewaySiteLbrEnabled = $false
        $this.MediaBypass = $false
        $this.SendSipOptions = $true
        $this.SipSignalingPort = 5061
        $this.Source = "Unspecified"
    }

    VirtualPstnGateway ([String]$Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.BypassMode = "None"
        $this.Enabled = $true
        $this.FailoverResponseCodes = "408,503,504,500"
        $this.FailoverTimeSeconds = "10"
        $this.ForwardCallHistory = $true
        $this.ForwardPai = $true
        $this.GatewayLbrEnabledUserOverride = $false
        $this.GatewaySiteLbrEnabled = $false
        $this.MediaBypass = $false
        $this.SendSipOptions = $true
        $this.SipSignalingPort = 5061
        $this.Source = $Source
    }
}

class VirtualPstnUsage {
   
    #usage
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String]$PstnUsage

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualPstnUsage([String]$PstnUsage) {
        $this.PstnUsage = $PstnUsage
        $this.Source = "Unspecified"
    }

    VirtualPstnUsage([String]$PstnUsage, [Source]$Source) {
        $this.PstnUsage = $PstnUsage
        $this.Source = $Source
    } 
}

class VirtualVoiceRoute {

    # BridgeSourcePhoneNumber
    # Description
    # Identity
    # Name
    # NumberPattern
    # OnlinePstnGatewayList
    # OnlinePstnUsages
    # Priority

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[ a-zA-Z0-9_.-]{1,32}$")]
    [String] $Identity	

    [ValidateNotNullOrEmpty()]
    [Int] $Priority

    [ValidateNotNullOrEmpty()]
    [String] $NumberPattern	

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[ a-zA-Z0-9_.-]{1,32}$")]
    [System.Collections.Generic.List[String]] $PstnUsageList

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(?!-)(?:[A-Za-z0-9-]{1,63}\.){1,126}(?:[A-Za-z]{2,63})$")]
    [System.Collections.Generic.List[String]] $PstnGatewaylist

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String] $Description

    [ValidatePattern("^\+?[1-9]\d{1,14}$")]
    [String] $BridgeSourcePhoneNumber

    VirtualVoiceRoute([String] $Identity, [String] $NumberPattern, [System.Collections.Generic.List[String]] $PstnUsageList, [System.Collections.Generic.List[String]] $PstnGatewaylist, [Int] $Priority) {
        $this.Identity = $Identity
        $this.NumberPattern = $NumberPattern
        $this.PstnUsageList = $PstnUsageList
        $this.PstnGatewayList = $PstnGatewaylist
        $this.Priority = $Priority
        $This.Source = "Unspecified"
    }

    VirtualVoiceRoute([String] $Identity, [String] $NumberPattern, [System.Collections.Generic.List[String]] $PstnUsageList, [System.Collections.Generic.List[String]] $PstnGatewaylist, [Int] $Priority, [Source]$Source) {
        $this.Identity = $Identity
        $this.NumberPattern = $NumberPattern
        $this.PstnUsageList = $PstnUsageList
        $this.PstnGatewayList = $PstnGatewaylist
        $this.Priority = $Priority
        $This.Source = $Source
    }
}

class VirtualVoiceRoutingPolicy {

    # DataSource       NoteProperty object DataSource=null
    # Description      NoteProperty object Description=null
    # Identity         NoteProperty string Identity=Global
    # Key              NoteProperty Deserialized.System.Management.Automation.PSCustomObject Key=ScopeClass=Global;SchemaId=;AuthorityId=;De…
    # OnlinePstnUsages NoteProperty Deserialized.System.Object[] OnlinePstnUsages=
    # RouteType        NoteProperty string RouteType=BYOT

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[ a-zA-Z0-9_.-]{1,32}$")]
    [String]$Identity

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[ a-zA-Z0-9_.-]{1,32}$")]
    [System.Collections.Generic.List[String]]$PstnUsageList

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String] $Description

    VirtualVoiceRoutingPolicy([String] $Identity, [System.Collections.Generic.List[String]]$PstnUsageList) {
        $this.Identity = $Identity
        $this.PstnUsageList = $PstnUsageList
        $this.Source = "Unspecified"
    }

    VirtualVoiceRoutingPolicy([String] $Identity, [System.Collections.Generic.List[String]]$PstnUsageList, [Source]$Source) {
        $this.Identity = $Identity
        $this.PstnUsageList = $PstnUsageList
        $this.Source = $Source
    }
}

class VirtualVoiceApplicationsPolicy {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[ a-zA-Z0-9_.-]{1,32}$")]
    [String]$Identity
    
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source
    
    [String] $Description

    VirtualVoiceApplicationsPolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualVoiceApplicationsPolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }

}

class VirtualEmergencyNumber {

    [String]$EmergencyDialString 
    
    [ValidatePattern("^\d{1,10}(?:;\d{1,10})*$")]
    [String]$EmergencyDialMask 
    
    [ValidatePattern("^[ a-zA-Z0-9_.-]{1,32}$")]
    [String]$OnlinePstnUsage 
    
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source
}

class VirtualVoicemailPolicy {
    
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String]$Identity

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualVoicemailPolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualVoicemailPolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }
}

class VirtualEmergencyCallingPolicy {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String]$Identity

    [ValidatePattern("^(?:\w+@[\w.-]+)(?:;\w+@[\w.-]+){0,9}$")]
    [String]$NotificationGroup

    [ValidatePattern("^\+?[1-9]\d{1,14}$")]
    [String]$NotificationDialOutNumber 

    [ValidateSet("Disabled","Enabled")]
    [String]$ExternalLocationLookupMode

    [ValidateSet("NotificationOnly","ConferenceMuted","ConferenceUnMuted")]
    [String]$NotificationMode

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{1,350}$")]
    [String]$EnhancedEmergencyServiceDisclaimer 

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description

    [String]$ExtendedNotifications
    
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualEmergencyCallingPolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualEmergencyCallingPolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }
}

class VirtualEmergencyCallRoutingPolicy {
    
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String]$Identity
    
    [bool]$AllowEnhancedEmergencyServices
    
    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description
    
    [VirtualEmergencyNumber]$EmergencyNumbers
    
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualEmergencyCallRoutingPolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualEmergencyCallRoutingPolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }
}    

class VirtualDialPlan {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(?!\.)(?!.*\.$)[a-zA-Z0-9_.-]{1,49}$")]
    [String] $Identity	
    
    [ValidatePattern("^(?!\.)(?!.*\.\(\)$)[a-zA-Z0-9_.-]{1,49}$")]
    [String] $SimpleName	
    
    [ValidatePattern("^[\d#*]{1,4}$")]
    [String] $ExternalAccessPrefix	

    [Boolean] $OptimizeDeviceDialing	

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description
    
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualDialPlan([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualDialPlan([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }
}

class VirtualVoiceNormalisation {
     
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}\/[a-zA-Z0-9_.-]{1,32}$")]
    [String] $Identity

    [ValidateNotNullOrEmpty()]
    [String] $Pattern

    [ValidateNotNullOrEmpty()]
    [String] $Translation

    [Boolean] $isInternalExtension	

    [Int] $Priority	

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualVoiceNormalisation([String] $Identity, [String] $Pattern, [String] $Translation) {
        $this.Identity = $Identity
        $this.Pattern = $Pattern
        $this.Translation = $Translation
        $this.Source = "Unspecified"
    }

    VirtualVoiceNormalisation([String] $Identity, [String] $Pattern, [String] $Translation, [Source]$Source) {
        $this.Identity = $Identity
        $this.Pattern = $Pattern
        $this.Translation = $Translation
        $this.Source = $Source
    }

    VirtualVoiceNormalisation([String] $parent, [String] $name, [String] $Pattern, [String] $Translation) {
        $this.Identity = -join ($parent, "/", $name)
        $this.Pattern = $Pattern
        $this.Translation = $Translation
        $this.Source = "Unspecified"
    }

    VirtualVoiceNormalisation([String] $parent, [String] $name, [String] $Pattern, [String] $Translation, [Source]$Source) {
        $this.Identity = -join ($parent, "/", $name)
        $this.Pattern = $Pattern
        $this.Translation = $Translation
        $this.Source = $Source
    }
}

class VirtualCallHoldPolicy {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String]$Identity

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description

    [String]$AudiofileId

    #[String]$StreamingSourceUrl 
    #[String]$StreamingSourceAuthType 

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualCallHoldPolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualCallHoldPolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }
}

class VirtualCallingPolicy {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String]$Identity

    [boolean]$AllowCallForwardingToPhone

    [boolean]$AllowCallForwardingToUser

    [boolean]$AllowCallGroups

    [ValidateSet("Enabled","Disabled","UserOverride")]
    [String]$AllowCallRedirect

    [boolean]$AllowCloudRecordingForCalls

    [boolean]$AllowDelegation

    [boolean]$AllowPrivateCalling

    [boolean]$AllowSIPDevicesCalling

    [boolean]$AllowTranscriptionForCalling

    [ValidateSet("AlwaysEnabled","AlwaysDisabled","UserOverride")]
    [String]$AllowVoicemail

    [boolean]$AllowWebPSTNCalling

    [ValidateSet("Enabled","Disabled")]
    [String]$AutoAnswerEnabledType

    [ValidateSet("Enabled","Disabled","Unanswered")]
    [String]$BusyOnBusyEnabledType

    [Long]$CallRecordingExpirationDays

    [ValidateSet("DisabledUserOverride","Disabled")]
    [String]$LiveCaptionsEnabledTypeForCalling

    [ValidateSet("Enabled","Disabled","UserOverride")]
    [String]$MusicOnHoldEnabledType

    [String]$PopoutAppPathForIncomingPstnCalls

    [String]$PopoutForIncomingPstnCalls

    [boolean]$PreventTollBypass

    [ValidateSet("Enabled","Disabled","EnabledWithoutIVR")]
    [String]$SpamFilteringEnabledType
    
    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description
    
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualCallingPolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
        $this.AutoAnswerEnabledType = $false
        $this.MusicOnHoldEnabledType = $true
    }

    VirtualCallingPolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $source
        $this.AutoAnswerEnabledType = $false
        $this.MusicOnHoldEnabledType = $true
    }
}

class VirtualCallingIdPolicy {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $Identity	

    [boolean] $BlockIncomingPstnCallerID	

    [ValidateSet("Anonymous","LineUri","Resource")]
    [String] $CallingIDSubstitute

    [ValidatePattern("^[A-Za-z\s\-\(\)\[\]\.,']+$")]
    [String] $CompanyName
    
    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description
    
    [Boolean] $EnableUserOverride
    
    [String] $ResourceAccount

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualCallingIdPolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualCallingIdPolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }
}

class VirtualCallParkPolicy {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String]$Identity

    [Boolean]$AllowCallPark

    [ValidatePattern("^(?:[1-9]\d{1,3}|9999)$")]
    [int]$PickupRangeStart

    [ValidatePattern("^(?:[1-9]\d{1,3}|9999)$")]
    [int]$PickupRangeEnd

    [ValidatePattern("^(?:1[2-7]\d{2}|1800)$")]
    [int]$ParkTimeoutSeconds

    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualCallParkPolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualCallParkPolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }
}

class VirtualMobilityPolicy {
    
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String]$Identity
    
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source
    
    [ValidateSet("WifiOnly","AllNetworks")]
    [String]$IPVideoMobileMode
    
    [ValidateSet("WifiOnly","AllNetworks")]
    [String]$IPAudioMobileMode
    
    [ValidateSet("Teams","Native","UserOverride")]
    [String]$MobileDialerPreference
    
    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description
    
    VirtualTeamsMobilityPolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualTeamsMobilityPolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }
}

class VirtualPhonePolicy {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $Identity	

    [ValidateSet("Enabled","Disabled")]
    [String] $AllowBetterTogether

    [ValidateSet("Enabled","EnabledUserOverride","Disabled")]
    [String] $AllowHomeScreen

    [Boolean] $AllowHotDesking	

    [Int] $HotDeskingIdleTimeoutInMinutes	
    
    [ValidateSet("Enabled","Disabled")]
    [String] $SearchOnCommonAreaPhoneMode	
    
    [ValidateSet("UserSignIn","CommonAreaPhoneSignin","MeetingSignIn")]
    [String] $SignInMode	
    
    [ValidatePattern("^(?!.*[!@#$%^*()=/\[\]{}:;?<>+']).{0,255}$")]
    [String]$Description

    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualPhonePolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.AllowBetterTogether = "Enabled"
        $this.AllowHomeScreen = "EnabledUserOverride"
        $this.Source = "Unspecified"
    }

    VirtualPhonePolicy([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.AllowBetterTogether = "Enabled"
        $this.AllowHomeScreen = "EnabledUserOverride"
        $this.Source = $Source
    }
}

class VirtualUser {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.-@]{1,254}$")]
    [String] $Identity

    [String] $UsageLocation

    [System.Boolean] $EnterpriseVoiceEnabled

    [String] $TelephoneNumber

    [ValidateSet("CallingPlan","DirectRouting","OperatorConnect")]
    [String] $TelephoneNumberType

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $VoiceRoutingPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $VoiceApplicationsPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $VoicemailPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $EmergencyCallingPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $EmergencyCallRoutingPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $CallHoldPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $CallingIDPolicy #Calling

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $CallingLineIdentityPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $CallParkPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $DialPlan

    [ValidateSet("Global","DialoutCPCandPSTNInternational","DialoutCPCDomesticPSTNInternational","DialoutCPCDisabledPSTNInternational","DialoutCPCInternationalPSTNDomestic","DialoutCPCInternationalPSTNDisabled","DialoutCPCandPSTNDomestic","DialoutCPCDomesticPSTNDisabled","DialoutCPCDisabledPSTNDomestic","DialoutCPCandPSTNDisabled","DialoutCPCZoneAPSTNInternational","DialoutCPCZoneAPSTNDomestic","DialoutCPCZoneAPSTNDisabled")]
    [String] $DialOutPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $MobilityPolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $PhonePolicy

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [String] $SurvivableBranchAppliancePolicy


    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source
    
    VirtualUser([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualUser([String] $Identity, [Source]$Source) {
        $this.Identity = $Identity
        $this.Source = $Source
    }
}

class VirtualSurvivableBranchAppliance {

    [ValidateNotNullOrEmpty()]
    [string]$Identity
    [ValidateNotNullOrEmpty()]
    [string]$Site
    [ValidateNotNullOrEmpty()]
    [string]$Description
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source

    VirtualSurvivableBranchAppliance([String]$Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualSurvivableBranchAppliance([String]$Identity,[string]$Site,[string]$Description,[Source]$Source) {
        $this.Identity = $Identity
        $this.Site = $Site
        $this.Description = $Description
        $this.Source = $Source
    }

}

class VirtualSurvivableBranchAppliancePolicy {

    [ValidatePattern("^[a-zA-Z0-9_.-]{1,32}$")]
    [ValidateNotNullOrEmpty()]
    [string]$Identity
    [ValidateNotNullOrEmpty()]
    [System.Collections.Generic.List[string]]$BranchApplianceFqdns
    [ValidateNotNullOrEmpty()]
    [Source] hidden $Source
    
    VirtualSurvivableBranchAppliancePolicy([String] $Identity) {
        $this.Identity = $Identity
        $this.Source = "Unspecified"
    }

    VirtualSurvivableBranchAppliancePolicy([String] $Identity,[System.Collections.Generic.List[string]]$BranchApplianceFqdns,[Source]$Source) {
        $this.Identity = $Identity
        $this.BranchApplianceFqdns = $BranchApplianceFqdns
        $this.Source = $source
    }

}


class VirtualTopology {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(?=.{1,253}\.)[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)*\.([a-zA-Z]{2,})$")]
    [String]$DomainName
    [guid]$TenantID
    [System.Collections.Generic.List[VirtualNetworkRegion]]$NetworkRegion
    [System.Collections.Generic.List[VirtualNetworkSite]]$NetworkSite
    [System.Collections.Generic.List[VirtualNetworkSubnet]]$NetworkSubnet
    [System.Collections.Generic.List[VirtualTrustedIpAddress]]$TrustedIpAddress
    [System.Collections.Generic.List[VirtualPstnGateway]]$PstnGateway
    [System.Collections.Generic.List[VirtualPstnUsage]]$PstnUsage
    [System.Collections.Generic.List[VirtualVoiceRoute]]$VoiceRoute
    [System.Collections.Generic.List[VirtualVoiceRoutingPolicy]]$VoiceRoutingPolicy
    [System.Collections.Generic.List[VirtualVoiceApplicationsPolicy]]$VoiceApplicationsPolicy
    [System.Collections.Generic.List[VirtualVoicemailPolicy]]$VoicemailPolicy
    [System.Collections.Generic.List[VirtualEmergencyNumber]]$EmergencyNumber
    [System.Collections.Generic.List[VirtualEmergencyCallingPolicy]]$EmergencyCallingPolicy
    [System.Collections.Generic.List[VirtualEmergencyCallRoutingPolicy]]$EmergencyCallRoutingPolicy
    [System.Collections.Generic.List[VirtualDialPlan]]$DialPlan
    [System.Collections.Generic.List[VirtualVoiceNormalisation]]$VoiceNormalisation
    [System.Collections.Generic.List[VirtualCallHoldPolicy]]$CallHoldPolicy
    [System.Collections.Generic.List[VirtualCallingPolicy]]$CallingPolicy
    [System.Collections.Generic.List[VirtualCallingIDPolicy]]$CallingIDPolicy
    [System.Collections.Generic.List[VirtualCallParkPolicy]]$CallParkPolicy
    [System.Collections.Generic.List[VirtualMobilityPolicy]]$MobilityPolicy
    [System.Collections.Generic.List[VirtualPhonePolicy]]$PhonePolicy
    [System.Collections.Generic.List[VirtualSurvivableBranchAppliance]]$SurvivableBranchAppliance
    [System.Collections.Generic.List[VirtualSurvivableBranchAppliancePolicy]]$SurvivableBranchAppliancePolicy
    [System.Collections.Generic.List[VirtualUser]]$User
    
    VirtualTopology ([String]$DomainName) {
        $this.DomainName = $DomainName
        $this.TenantID ="00000000-0000-0000-0000-000000000000"
        $this.NetworkRegion = (New-Object System.Collections.Generic.List[VirtualNetworkRegion])
        $this.NetworkSite = New-Object System.Collections.Generic.List[VirtualNetworkSite]
        $this.NetworkSubnet = New-Object System.Collections.Generic.List[VirtualNetworkSubnet]  
        $this.TrustedIpAddress = New-Object System.Collections.Generic.List[VirtualTrustedIpAddress]
        $this.PstnGateway = New-Object System.Collections.Generic.List[VirtualPstnGateway]
        $this.PstnUsage = New-Object System.Collections.Generic.List[VirtualPstnUsage]
        $this.VoiceRoute = New-Object System.Collections.Generic.List[VirtualVoiceRoute]
        $this.VoiceRoutingPolicy = New-Object System.Collections.Generic.List[VirtualVoiceRoutingPolicy]
        $this.VoiceApplicationsPolicy = New-Object System.Collections.Generic.List[VirtualVoiceApplicationsPolicy]
        $this.VoicemailPolicy = New-Object System.Collections.Generic.List[VirtualVoicemailPolicy]
        $this.EmergencyNumber = New-Object System.Collections.Generic.List[VirtualEmergencyNumber]
        $this.EmergencyCallingPolicy = New-Object System.Collections.Generic.List[VirtualEmergencyCallingPolicy]
        $this.EmergencyCallRoutingPolicy = New-Object System.Collections.Generic.List[VirtualEmergencyCallRoutingPolicy]
        $this.DialPlan = New-Object System.Collections.Generic.List[VirtualDialPlan]
        $this.VoiceNormalisation = New-Object System.Collections.Generic.List[VirtualVoiceNormalisation]
        $this.CallHoldPolicy = New-Object System.Collections.Generic.List[VirtualCallHoldPolicy]
        $this.CallingPolicy = New-Object System.Collections.Generic.List[VirtualCallingPolicy]
        $this.CallingIDPolicy = New-Object System.Collections.Generic.List[VirtualCallingIDPolicy]
        $this.CallParkPolicy = New-Object System.Collections.Generic.List[VirtualCallParkPolicy]
        $this.MobilityPolicy = New-Object System.Collections.Generic.List[VirtualMobilityPolicy]
        $this.PhonePolicy = New-Object System.Collections.Generic.List[VirtualPhonePolicy]
        $this.SurvivableBranchAppliance = New-Object System.Collections.Generic.List[VirtualSurvivableBranchAppliance]
        $this.SurvivableBranchAppliancePolicy = New-Object System.Collections.Generic.List[VirtualSurvivableBranchAppliancePolicy]
        $this.User = New-Object System.Collections.Generic.List[VirtualUser]
    }
}

