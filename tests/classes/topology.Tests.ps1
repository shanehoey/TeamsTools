# Simple test for topology classes
. "./teamsTools/classes/topology.ps1"

Describe "VirtualTopology Class Tests" {
    
    It "Can create VirtualTopology with domain name" {
        $topology = [VirtualTopology]::new("contoso.com")
        
        $topology.DomainName | Should -Be "contoso.com"
        $topology.TenantID | Should -Be "00000000-0000-0000-0000-000000000000"
        $topology.NetworkRegion | Should -Not -BeNullOrEmpty
        $topology.NetworkSite | Should -Not -BeNullOrEmpty
        $topology.PstnGateway | Should -Not -BeNullOrEmpty
    }
}

Describe "VirtualNetworkRegion Class Tests" {
    
    It "Can create VirtualNetworkRegion with ID" {
        $region = [VirtualNetworkRegion]::new("Sydney_Region")
        
        $region.NetworkRegionId | Should -Be "Sydney_Region"
        $region.Source | Should -Be "Unspecified"
    }
    
    It "Can create VirtualNetworkRegion with description" {
        $region = [VirtualNetworkRegion]::new("Sydney_Region", "Sydney Office Network", "Virtual")
        
        $region.NetworkRegionId | Should -Be "Sydney_Region"
        $region.Description | Should -Be "Sydney Office Network"
        $region.Source | Should -Be "Virtual"
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
        $route.OnlinePstnUsages.Count | Should -Be 1
        $route.OnlinePstnGatewayList.Count | Should -Be 1
    }
}

Describe "VirtualDialPlan Class Tests" {
    
    It "Can create VirtualDialPlan with identity" {
        $dialPlan = [VirtualDialPlan]::new("Sydney_DialPlan")
        
        $dialPlan.Identity | Should -Be "Sydney_DialPlan"
        $dialPlan.Source | Should -Be "Unspecified"
    }
}
