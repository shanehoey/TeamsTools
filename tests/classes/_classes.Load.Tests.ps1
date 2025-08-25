# Simple All-Classes Test - Run from workspace root

# Load all class files
BeforeAll -Scriptblock {

    . "./teamsTools/classes/authApp.ps1"
    . "./teamsTools/classes/domains.ps1" 
    . "./teamsTools/classes/defaultVoiceRoute.ps1"
    . "./teamsTools/classes/defaultVoiceNormalisationRule.ps1"
    . "./teamsTools/classes/topology.ps1"
    
}

Describe "All Classes Basic Tests" {
    
    Context "authApp Class" {
        It "Can create authApp" {
            $auth = [authApp]::new()
            $auth.GetType().Name | Should -Be "authApp"
        }
    }
    
    Context "DnsRecord Class" {
        It "Can create DnsRecord" {
            $record = [DnsRecord]::new()
            $record.GetType().Name | Should -Be "DnsRecord"
        }
        
        It "Can create A record" {
            $record = [DnsRecord]::new("Email", "A", "mail.contoso.com", "192.168.1.10", 3600)
            $record.Type | Should -Be "A"
            $record.Value | Should -Be "192.168.1.10"
        }
    }
    
    Context "defaultVoiceRoute Class" {
        It "Can create defaultVoiceRoute" {
            $route = [defaultVoiceRoute]::new("AU", "Australia National", "National", "^\+61[2-9]\d{8}$")
            $route.GetType().Name | Should -Be "defaultVoiceRoute"
            $route.countryCode | Should -Be "AU"
        }
    }
    
    Context "defaultVoiceNormalisationRule Class" {
        It "Can create defaultVoiceNormalisationRule" {
            $rule = [defaultVoiceNormalisationRule]::new("AU", "Sydney Local", "Local", "^(\d{8})$", "+612$1")
            $rule.GetType().Name | Should -Be "defaultVoiceNormalisationRule"
            $rule.countryCode | Should -Be "AU"
        }
    }
    
    Context "VirtualTopology Class" {
        It "Can create VirtualTopology" {
            $topology = [VirtualTopology]::new("contoso.com")
            $topology.GetType().Name | Should -Be "VirtualTopology"
            $topology.DomainName | Should -Be "contoso.com"
        }
    }
    
    Context "VirtualNetworkRegion Class" {
        It "Can create VirtualNetworkRegion" {
            $region = [VirtualNetworkRegion]::new("Sydney_Region")
            $region.GetType().Name | Should -Be "VirtualNetworkRegion"
            $region.NetworkRegionId | Should -Be "Sydney_Region"
        }
    }
    
    Context "VirtualPstnGateway Class" {
        It "Can create VirtualPstnGateway" {
            $gateway = [VirtualPstnGateway]::new("sbc.contoso.com")
            $gateway.GetType().Name | Should -Be "VirtualPstnGateway"
            $gateway.Identity | Should -Be "sbc.contoso.com"
        }
    }
    
    Context "VirtualNetworkSite Class" {
        It "Can create VirtualNetworkSite" {
            $site = [VirtualNetworkSite]::new("Sydney_Site", "Sydney_Region")
            $site.GetType().Name | Should -Be "VirtualNetworkSite"
            $site.NetworkSiteId | Should -Be "Sydney_Site"
        }
    }
    
    Context "VirtualNetworkSubnet Class" {
        It "Can create VirtualNetworkSubnet" {
            $subnet = [VirtualNetworkSubnet]::new("Sydney_Site", "192.168.1.0", "24")
            $subnet.GetType().Name | Should -Be "VirtualNetworkSubnet"
            $subnet.SubnetId | Should -Be "192.168.1.0"
        }
    }
    
    Context "VirtualTrustedIpAddress Class" {
        It "Can create VirtualTrustedIpAddress" {
            $trustedIp = [VirtualTrustedIpAddress]::new("192.168.1.100", "24")
            $trustedIp.GetType().Name | Should -Be "VirtualTrustedIpAddress"
            $trustedIp.IpAddress | Should -Be "192.168.1.100"
        }
    }
    
    Context "VirtualPstnUsage Class" {
        It "Can create VirtualPstnUsage" {
            $usage = [VirtualPstnUsage]::new("National")
            $usage.GetType().Name | Should -Be "VirtualPstnUsage"
            $usage.Identity | Should -Be "National"
        }
    }
    
    Context "VirtualVoiceRoute Class" {
        It "Can create VirtualVoiceRoute" {
            $usageList = [System.Collections.Generic.List[String]]@("National")
            $gatewayList = [System.Collections.Generic.List[String]]@("sbc.contoso.com")
            $route = [VirtualVoiceRoute]::new("AU_National", "^\+61[2-9]\d{8}$", $usageList, $gatewayList, 1000)
            $route.GetType().Name | Should -Be "VirtualVoiceRoute"
            $route.Identity | Should -Be "AU_National"
        }
    }
    
    Context "VirtualVoiceRoutingPolicy Class" {
        It "Can create VirtualVoiceRoutingPolicy" {
            $usageList = [System.Collections.Generic.List[String]]@("National", "International")
            $policy = [VirtualVoiceRoutingPolicy]::new("AU_Policy", $usageList)
            $policy.GetType().Name | Should -Be "VirtualVoiceRoutingPolicy"
            $policy.Identity | Should -Be "AU_Policy"
        }
    }
    
    Context "VirtualVoiceApplicationsPolicy Class" {
        It "Can create VirtualVoiceApplicationsPolicy" {
            $policy = [VirtualVoiceApplicationsPolicy]::new("Default_Policy")
            $policy.GetType().Name | Should -Be "VirtualVoiceApplicationsPolicy"
            $policy.Identity | Should -Be "Default_Policy"
        }
    }
    
    Context "VirtualEmergencyNumber Class" {
        It "Can create VirtualEmergencyNumber" {
            $emergency = [VirtualEmergencyNumber]::new("000")
            $emergency.GetType().Name | Should -Be "VirtualEmergencyNumber"
            $emergency.EmergencyDialString | Should -Be "000"
        }
    }
    
    Context "VirtualVoicemailPolicy Class" {
        It "Can create VirtualVoicemailPolicy" {
            $policy = [VirtualVoicemailPolicy]::new("Default_Voicemail")
            $policy.GetType().Name | Should -Be "VirtualVoicemailPolicy"
            $policy.Identity | Should -Be "Default_Voicemail"
        }
    }
    
    Context "VirtualEmergencyCallingPolicy Class" {
        It "Can create VirtualEmergencyCallingPolicy" {
            $policy = [VirtualEmergencyCallingPolicy]::new("Sydney_Emergency")
            $policy.GetType().Name | Should -Be "VirtualEmergencyCallingPolicy"
            $policy.Identity | Should -Be "Sydney_Emergency"
        }
    }
    
    Context "VirtualEmergencyCallRoutingPolicy Class" {
        It "Can create VirtualEmergencyCallRoutingPolicy" {
            $policy = [VirtualEmergencyCallRoutingPolicy]::new("Sydney_Routing")
            $policy.GetType().Name | Should -Be "VirtualEmergencyCallRoutingPolicy"
            $policy.Identity | Should -Be "Sydney_Routing"
        }
    }
    
    Context "VirtualDialPlan Class" {
        It "Can create VirtualDialPlan" {
            $dialPlan = [VirtualDialPlan]::new("Sydney_DialPlan")
            $dialPlan.GetType().Name | Should -Be "VirtualDialPlan"
            $dialPlan.Identity | Should -Be "Sydney_DialPlan"
        }
    }
    
    Context "VirtualVoiceNormalisation Class" {
        It "Can create VirtualVoiceNormalisation" {
            $normalisation = [VirtualVoiceNormalisation]::new("Sydney_Local", "^(\d{8})$", "+612$1")
            $normalisation.GetType().Name | Should -Be "VirtualVoiceNormalisation"
            $normalisation.Name | Should -Be "Sydney_Local"
        }
    }
    
    Context "VirtualCallHoldPolicy Class" {
        It "Can create VirtualCallHoldPolicy" {
            $policy = [VirtualCallHoldPolicy]::new("Default_Hold")
            $policy.GetType().Name | Should -Be "VirtualCallHoldPolicy"
            $policy.Identity | Should -Be "Default_Hold"
        }
    }
    
    Context "VirtualCallingPolicy Class" {
        It "Can create VirtualCallingPolicy" {
            $policy = [VirtualCallingPolicy]::new("Default_Calling")
            $policy.GetType().Name | Should -Be "VirtualCallingPolicy"
            $policy.Identity | Should -Be "Default_Calling"
        }
    }
    
    Context "VirtualCallingIdPolicy Class" {
        It "Can create VirtualCallingIdPolicy" {
            $policy = [VirtualCallingIdPolicy]::new("Default_CallerId")
            $policy.GetType().Name | Should -Be "VirtualCallingIdPolicy"
            $policy.Identity | Should -Be "Default_CallerId"
        }
    }
    
    Context "VirtualCallParkPolicy Class" {
        It "Can create VirtualCallParkPolicy" {
            $policy = [VirtualCallParkPolicy]::new("Default_Park")
            $policy.GetType().Name | Should -Be "VirtualCallParkPolicy"
            $policy.Identity | Should -Be "Default_Park"
        }
    }
    
    Context "VirtualMobilityPolicy Class" {
        It "Can create VirtualMobilityPolicy" {
            $policy = [VirtualMobilityPolicy]::new("Default_Mobility")
            $policy.GetType().Name | Should -Be "VirtualMobilityPolicy"
            $policy.Identity | Should -Be "Default_Mobility"
        }
    }
    
    Context "VirtualPhonePolicy Class" {
        It "Can create VirtualPhonePolicy" {
            $policy = [VirtualPhonePolicy]::new("Default_Phone")
            $policy.GetType().Name | Should -Be "VirtualPhonePolicy"
            $policy.Identity | Should -Be "Default_Phone"
        }
    }
    
    Context "VirtualUser Class" {
        It "Can create VirtualUser" {
            $user = [VirtualUser]::new("user@contoso.com")
            $user.GetType().Name | Should -Be "VirtualUser"
            $user.UserPrincipalName | Should -Be "user@contoso.com"
        }
    }
    
    Context "VirtualSurvivableBranchAppliance Class" {
        It "Can create VirtualSurvivableBranchAppliance" {
            $sba = [VirtualSurvivableBranchAppliance]::new("SBA_Sydney")
            $sba.GetType().Name | Should -Be "VirtualSurvivableBranchAppliance"
            $sba.Identity | Should -Be "SBA_Sydney"
        }
    }
    
    Context "VirtualSurvivableBranchAppliancePolicy Class" {
        It "Can create VirtualSurvivableBranchAppliancePolicy" {
            $policy = [VirtualSurvivableBranchAppliancePolicy]::new("SBA_Policy")
            $policy.GetType().Name | Should -Be "VirtualSurvivableBranchAppliancePolicy"
            $policy.Identity | Should -Be "SBA_Policy"
        }
    }
}
