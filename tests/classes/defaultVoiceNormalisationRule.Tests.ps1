# Simple test for defaultVoiceNormalisationRule class
. "./teamsTools/classes/defaultVoiceNormalisationRule.ps1"

Describe "defaultVoiceNormalisationRule Class Tests" {
    
    It "Can create normalisation rule with area code" {
        $rule = [defaultVoiceNormalisationRule]::new("AU", "Sydney Local", "Local", "^(\d{8})$", "+612$1", "02")
        
        $rule.countryCode | Should -Be "AU"
        $rule.displayName | Should -Be "Sydney Local"
        $rule.type | Should -Be "Local"
        $rule.pattern | Should -Be "^(\d{8})$"
        $rule.translation | Should -Be "+612$1"
        $rule.areaCode | Should -Be "02"
    }
    
    It "Can create normalisation rule without area code" {
        $rule = [defaultVoiceNormalisationRule]::new("AU", "National Mobile", "National", "^04(\d{8})$", "+614$1")
        
        $rule.countryCode | Should -Be "AU"
        $rule.displayName | Should -Be "National Mobile"
        $rule.type | Should -Be "National"
        $rule.pattern | Should -Be "^04(\d{8})$"
        $rule.translation | Should -Be "+614$1"
        $rule.areaCode | Should -BeNullOrEmpty
    }
    
    It "Can create Emergency normalisation rule" {
        $rule = [defaultVoiceNormalisationRule]::new("AU", "Emergency", "Emergency", "^000$", "+61000")
        
        $rule.type | Should -Be "Emergency"
        $rule.pattern | Should -Be "^000$"
        $rule.translation | Should -Be "+61000"
    }
    
    It "Can create International normalisation rule" {
        $rule = [defaultVoiceNormalisationRule]::new("global", "International", "International", "^0011(\d+)$", "+$1")
        
        $rule.countryCode | Should -Be "global"
        $rule.type | Should -Be "International"
        $rule.translation | Should -Be "+$1"
    }
}
