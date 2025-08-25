# Super Simple Class Loading Test

Describe "Class File Loading Tests" {
    
    It "Can load authApp.ps1 without errors" {
        { . "./teamsTools/classes/authApp.ps1" } | Should -Not -Throw
    }
    
    It "Can load domains.ps1 without errors" {
        { . "./teamsTools/classes/domains.ps1" } | Should -Not -Throw
    }
    
    It "Can load defaultVoiceRoute.ps1 without errors" {
        { . "./teamsTools/classes/defaultVoiceRoute.ps1" } | Should -Not -Throw
    }
    
    It "Can load defaultVoiceNormalisationRule.ps1 without errors" {
        { . "./teamsTools/classes/defaultVoiceNormalisationRule.ps1" } | Should -Not -Throw
    }
    
    It "Can load topology.ps1 without errors" {
        { . "./teamsTools/classes/topology.ps1" } | Should -Not -Throw
    }
    
    It "All class files exist" {
        Test-Path "./teamsTools/classes/authApp.ps1" | Should -Be $true
        Test-Path "./teamsTools/classes/domains.ps1" | Should -Be $true
        Test-Path "./teamsTools/classes/defaultVoiceRoute.ps1" | Should -Be $true
        Test-Path "./teamsTools/classes/defaultVoiceNormalisationRule.ps1" | Should -Be $true
        Test-Path "./teamsTools/classes/topology.ps1" | Should -Be $true
    }
    
    It "Class files contain class definitions" {
        $authAppContent = Get-Content "teamsTools/classes/authApp.ps1" -Raw
        $authAppContent | Should -Match "class authApp"
        
        $domainsContent = Get-Content "teamsTools/classes/domains.ps1" -Raw
        $domainsContent | Should -Match "class DnsRecord"
        
        $topologyContent = Get-Content "teamsTools/classes/topology.ps1" -Raw
        $topologyContent | Should -Match "class VirtualTopology"
    }
}
