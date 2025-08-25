# Simple test for defaultVoiceRoute class

BeforeAll -Scriptblock {
    . "./teamsTools/classes/defaultVoiceRoute.ps1"
}

Describe "defaultVoiceRoute Class Tests" {
    
    It "Can create defaultVoiceRoute with parameters" {
        $route = [defaultVoiceRoute]::new("AU", "Australia National", "National", "^\+61[2-9]\d{8}$")
        
        $route.countryCode | Should -Be "AU"
        $route.displayName | Should -Be "Australia National"
        $route.type | Should -Be "National"
        $route.pattern | Should -Be "^\+61[2-9]\d{8}$"
    }
    
    It "Can create Emergency route" {
        $route = [defaultVoiceRoute]::new("AU", "Australia Emergency", "Emergency", "^000$")
        
        $route.type | Should -Be "Emergency"
        $route.pattern | Should -Be "^000$"
    }
    
    It "Can create International route" {
        $route = [defaultVoiceRoute]::new("global", "International Calls", "International", "^\+(?!61)\d+$")
        
        $route.countryCode | Should -Be "global"
        $route.type | Should -Be "International"
    }
    
    It "Can create Service route" {
        $route = [defaultVoiceRoute]::new("AU", "Directory Services", "Service", "^(1234|5678)$")
        
        $route.type | Should -Be "Service"
        $route.displayName | Should -Be "Directory Services"
    }
}
