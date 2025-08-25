# Simple All-Classes Test - Run from workspace root

# Load all class files
. "./teamsTools/classes/authApp.ps1"
. "./teamsTools/classes/domains.ps1" 
. "./teamsTools/classes/defaultVoiceRoute.ps1"
. "./teamsTools/classes/defaultVoiceNormalisationRule.ps1"
. "./teamsTools/classes/topology.ps1"

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
}
