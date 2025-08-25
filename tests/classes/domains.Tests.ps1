# Simple test for DnsRecord class
. "./teamsTools/classes/domains.ps1"

Describe "DnsRecord Class Tests" {
    
    It "Can create an empty DnsRecord" {
        $record = [DnsRecord]::new()
        $record | Should -Not -BeNullOrEmpty
        $record.GetType().Name | Should -Be "DnsRecord"
    }
    
    It "Can create A record with basic parameters" {
        $record = [DnsRecord]::new("Email", "A", "mail.contoso.com", "192.168.1.10", 3600)
        
        $record.ServiceType | Should -Be "EMAIL"
        $record.Type | Should -Be "A"
        $record.Name | Should -Be "mail.contoso.com"
        $record.Value | Should -Be "192.168.1.10"
        $record.Ttl | Should -Be 3600
    }
    
    It "Can create CNAME record" {
        $record = [DnsRecord]::new("SharepointDefaultDomain", "CNAME", "sharepoint.contoso.com", "contoso.sharepoint.com", 300)
        
        $record.ServiceType | Should -Be "SHAREPOINTDEFAULTDOMAIN"
        $record.Type | Should -Be "CNAME"
        $record.Name | Should -Be "sharepoint.contoso.com"
        $record.Value | Should -Be "contoso.sharepoint.com"
    }
    
    It "Can create TXT record" {
        $record = [DnsRecord]::new("OrgIdAuthentication", "TXT", "contoso.com", "MS=ms12345678", 3600)
        
        $record.ServiceType | Should -Be "ORGIDAUTHENTICATION"
        $record.Type | Should -Be "TXT"
        $record.Value | Should -Be "MS=ms12345678"
    }
    
    It "Can create MX record with preference" {
        $record = [DnsRecord]::new("Email", "MX", "contoso.com", "mail.contoso.com", "3600", 10)
        
        $record.Type | Should -Be "MX"
        $record.Value | Should -Be "mail.contoso.com"
        $record.Preference | Should -Be 10
    }
}
