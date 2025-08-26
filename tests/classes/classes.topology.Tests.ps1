# Simple test for topology classes

BeforeAll -Scriptblock {
    . "./TeamsTools/Classes/Topology.ps1"
}

Describe "All Tests" {

Describe "VirtualTopology Class Tests" {
    
    It "Can create VirtualTopology with domain name" {
        $topology = [VirtualTopology]::new("contoso.com")
        
        $topology.DomainName | Should -Be "contoso.com"
        $topology.TenantID | Should -Be "00000000-0000-0000-0000-000000000000"
        $topology.NetworkRegion | Should -BeNullOrEmpty
        $topology.NetworkSite | Should -BeNullOrEmpty
        $topology.NetworkSubnet | Should -BeNullOrEmpty
        $topology.TrustedIpAddress | Should -BeNullOrEmpty
        $topology.PstnGateway | Should -BeNullOrEmpty
        $topology.PstnUsage | Should -BeNullOrEmpty
        $topology.VoiceRoute | Should -BeNullOrEmpty
        $topology.VoiceRoutingPolicy | Should -BeNullOrEmpty
        $topology.VoiceApplicationsPolicy |  Should -BeNullOrEmpty
        $topology.VoicemailPolicy | Should -BeNullOrEmpty
        $topology.EmergencyNumber | Should -BeNullOrEmpty
        $topology.EmergencyCallingPolicy | Should -BeNullOrEmpty
        $topology.EmergencyCallRoutingPolicy | Should -BeNullOrEmpty
        $topology.DialPlan | Should -BeNullOrEmpty
        $topology.VoiceNormalisation | Should -BeNullOrEmpty
        $topology.CallHoldPolicy | Should -BeNullOrEmpty
        $topology.CallingPolicy | Should -BeNullOrEmpty
        $topology.CallingIdPolicy | Should -BeNullOrEmpty
        $topology.CallParkPolicy | Should -BeNullOrEmpty
        $topology.MobilityPolicy | Should -BeNullOrEmpty
        $topology.PhonePolicy | Should -BeNullOrEmpty
        $topology.SurvivableBranchAppliance | Should -BeNullOrEmpty
        $topology.SurvivableBranchAppliancePolicy | Should -BeNullOrEmpty
        $topology.User | Should -BeNullOrEmpty

    }
}

Describe "VirtualNetworkRegion Class Tests" {
    
    It "Can create VirtualNetworkRegion with ID" {
        $region = [VirtualNetworkRegion]::new("Sydney_Region")
        $region.NetworkRegionId | Should -Be "Sydney_Region"
        $region.Source | Should -Be "Unspecified"
    }
    
    It "Can create VirtualNetworkRegion with description" {
        $region = [VirtualNetworkRegion]::new("Sydney_Region", "Sydney Office Network")
        $region.NetworkRegionId | Should -Be "Sydney_Region"
        $region.Description | Should -Be "Sydney Office Network"
        $region.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualNetworkSite Class Tests" {
    
    It "Can create VirtualNetworkSite with basic parameters" {
        $site = [VirtualNetworkSite]::new("Sydney_Site", "Sydney_Region")
        
        $site.NetworkSiteId | Should -Be "Sydney_Site"
        $site.NetworkRegionId | Should -Be "Sydney_Region"
        $site.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualPstnGateway Class Tests" {
    
    It "Can create VirtualPstnGateway with FQDN" {
        $gateway = [VirtualPstnGateway]::new("sbc.contoso.com")
        
        $gateway.Identity | Should -Be "sbc.contoso.com"
        $gateway.Source | Should -Be "Unspecified"
        $gateway.Enabled | Should -Be $true
        $gateway.MediaBypass | Should -Be $false
    }
}

Describe "VirtualVoiceRoute Class Tests" {
    
    It "Can create VirtualVoiceRoute with basic parameters" {
        $usageList = [System.Collections.Generic.List[String]]@("National")
        $gatewayList = [System.Collections.Generic.List[String]]@("sbc.contoso.com")
        $route = [VirtualVoiceRoute]::new("AU_National", "^\+61[2-9]\d{8}$", $usageList, $gatewayList, 1000)
        
        $route.Identity | Should -Be "AU_National"
        $route.NumberPattern | Should -Be "^\+61[2-9]\d{8}$"
        $route.Priority | Should -Be 1000
        $route.PstnUsageList.Count | Should -Be 1
        $route.PstnGatewayList.Count | Should -Be 1
    }
}

Describe "VirtualDialPlan Class Tests" {
    
    It "Can create VirtualDialPlan with identity" {
        $dialPlan = [VirtualDialPlan]::new("Sydney_DialPlan")
        
        $dialPlan.Identity | Should -Be "Sydney_DialPlan"
        $dialPlan.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualNetworkSubnet Class Tests" {
    
    It "Can create VirtualNetworkSubnet with parameters" {
        $subnet = [VirtualNetworkSubnet]::new("Sydney_Site", "192.168.1.0", "24")
        
        $subnet.NetworkSiteID | Should -Be "Sydney_Site"
        $subnet.SubnetId | Should -Be "192.168.1.0"
        $subnet.Mask | Should -Be "24"
        $subnet.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualTrustedIpAddress Class Tests" {
    
    It "Can create VirtualTrustedIpAddress with parameters" {
        $trustedIp = [VirtualTrustedIpAddress]::new("192.168.1.100", "24")
        $trustedIp.IpAddress | Should -Be "192.168.1.100"
        $trustedIp.Mask | Should -Be "24"
        $trustedIp.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualPstnUsage Class Tests" {
    
    It "Can create VirtualPstnUsage with identity" {
        $usage = [VirtualPstnUsage]::new("National")
        $usage.PstnUsage | Should -Be "National"
        $usage.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualVoiceRoutingPolicy Class Tests" {
    
    It "Can create VirtualVoiceRoutingPolicy with parameters" {
        $usageList = [System.Collections.Generic.List[String]]@("National", "International")
        $policy = [VirtualVoiceRoutingPolicy]::new("AU_Policy", $usageList)
        $policy.Identity | Should -Be "AU_Policy"
        $policy.PstnUsageList.Count | Should -Be 2
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualVoiceApplicationsPolicy Class Tests" {
    
    It "Can create VirtualVoiceApplicationsPolicy with identity" {
        $policy = [VirtualVoiceApplicationsPolicy]::new("Default_Policy")
        
        $policy.Identity | Should -Be "Default_Policy"
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualEmergencyNumber Class Tests" {
    
    It "Can create VirtualEmergencyNumber with dial string" {
        $emergency = [VirtualEmergencyNumber]::new("000","000","Emergency")
        $emergency.EmergencyDialString | Should -Be "000"
        $emergency.EmergencyDialMask | Should -Be "000"
        $emergency.OnlinePstnUsage | Should -Be "Emergency"
    }
}

Describe "VirtualVoicemailPolicy Class Tests" {
    
    It "Can create VirtualVoicemailPolicy with identity" {
        $policy = [VirtualVoicemailPolicy]::new("Default_Voicemail")
        
        $policy.Identity | Should -Be "Default_Voicemail"
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualEmergencyCallingPolicy Class Tests" {
    
    It "Can create VirtualEmergencyCallingPolicy with identity" {
        $policy = [VirtualEmergencyCallingPolicy]::new("Sydney_Emergency")
        
        $policy.Identity | Should -Be "Sydney_Emergency"
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualEmergencyCallRoutingPolicy Class Tests" {
    
    It "Can create VirtualEmergencyCallRoutingPolicy with identity" {
        $policy = [VirtualEmergencyCallRoutingPolicy]::new("Sydney_Routing")
        
        $policy.Identity | Should -Be "Sydney_Routing"
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualVoiceNormalisation Class Tests" {
    
    It "Can create VirtualVoiceNormalisation with parameters" {
        $normalisation = [VirtualVoiceNormalisation]::new("Sydney/Local", "^(\d{8})$", "+612$1")
        
        $normalisation.Identity | Should -Be "Sydney/Local"
        $normalisation.Pattern | Should -Be "^(\d{8})$"
        $normalisation.Translation | Should -Be "+612$1"
    }
}

Describe "VirtualCallHoldPolicy Class Tests" {
    
    It "Can create VirtualCallHoldPolicy with identity" {
        $policy = [VirtualCallHoldPolicy]::new("Default_Hold")
        
        $policy.Identity | Should -Be "Default_Hold"
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualCallingPolicy Class Tests" {
    
    It "Can create VirtualCallingPolicy with identity" {
        $policy = [VirtualCallingPolicy]::new("AU_Calling")
        
        $policy.Identity | Should -Be "AU_Calling"
        #$policy.AutoAnswerEnabledType | Should -be false
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualCallingIdPolicy Class Tests" {
    
    It "Can create VirtualCallingIdPolicy with identity" {
        $policy = [VirtualCallingIdPolicy]::new("Default_CallerId")
        
        $policy.Identity | Should -Be "Default_CallerId"
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualCallParkPolicy Class Tests" {
    
    It "Can create VirtualCallParkPolicy with identity" {
        $policy = [VirtualCallParkPolicy]::new("Default_Park")
        
        $policy.Identity | Should -Be "Default_Park"
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualMobilityPolicy Class Tests" {
    
    It "Can create VirtualMobilityPolicy with identity" {
        $policy = [VirtualMobilityPolicy]::new("Default_Mobility")
        
        $policy.Identity | Should -Be "Default_Mobility"
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualPhonePolicy Class Tests" {
    
    It "Can create VirtualPhonePolicy with identity" {
        $policy = [VirtualPhonePolicy]::new("Default_Phone")
        
        $policy.Identity | Should -Be "Default_Phone"
        $policy.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualUser Class Tests" {
    
    It "Can create VirtualUser with UPN" {
        $user = [VirtualUser]::new("user@contoso.com")
        
        $user.UserPrincipalName | Should -Be "user@contoso.com"
        $user.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualSurvivableBranchAppliance Class Tests" {
    
    It "Can create VirtualSurvivableBranchAppliance with identity" {
        $sba = [VirtualSurvivableBranchAppliance]::new("SBA_Sydney")
        
        $sba.Identity | Should -Be "SBA_Sydney"
        $sba.Source | Should -Be "Unspecified"
    }
}

Describe "VirtualSurvivableBranchAppliancePolicy Class Tests" {
    
    It "Can create VirtualSurvivableBranchAppliancePolicy with identity" {
        $policy = [VirtualSurvivableBranchAppliancePolicy]::new("SBA_Policy")
        
        $policy.Identity | Should -Be "SBA_Policy"
        $policy.Source | Should -Be "Unspecified"
    }
}

}