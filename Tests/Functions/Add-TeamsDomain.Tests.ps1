BeforeAll {
    Import-Module /home/shane/Development/TeamsTools/TeamsTools/

    Mock Connect-MgGraph { $null }
    Mock New-MgDomain { [PSCustomObject]@{ Id = 'test-domain-id' } }
    Mock Get-MgDomainVerificationDnsRecord { 
        @(
            [PSCustomObject]@{ RecordType = 'Txt'; AdditionalProperties = @{ text = 'verification-token' } }
        )
    }
}

Describe "Add-TeamsDomain Parameter Validation" {
    It "Should reject invalid domain names" {
        Mock Invoke-MgGraphRequest { return @{ id = "test" } }
        { Add-TeamsDomain -Domain "invalid..domain" } | Should -Throw
        { Add-TeamsDomain -Domain "domain" } | Should -Throw
        { Add-TeamsDomain -Domain "" } | Should -Throw
    }
    
    It "Should accept valid domain names" {
        Mock Invoke-MgGraphRequest { return @{ id = "valid.domain.com" } }
        { Add-TeamsDomain -Domain "valid.domain.com" } | Should -Not -Throw
    }
}
