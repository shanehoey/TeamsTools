function add-teamsDomain ($domain) {

    $newdomain = New-MgDomain -AuthenticationType Managed -id $domain -IsAdminManaged -IsDefault 
    $msrecord = (Get-MgDomainVerificationDnsRecord -DomainId $domain | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text
    $msrecord
    
}