function confirm-teamsDomain ($domain) {

    confirm-MgDomain -DomainId $domain | Format-list *
    get-mgdomain | select id, isDefault, supportedServices, VerificationDnsRecords, AdditionalProperties  | FT 
    update-MgDomain -DomainID $domain -SupportedServices email
    
}


