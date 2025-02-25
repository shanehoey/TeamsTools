function confirm-teamsDomainService ($domain){

    Get-MgDomainServiceConfigurationRecord -DomainId $domain | sort-object SupportedService | FL SupportedService,RecordType,label,ttl,AdditionalProperties
    update-MgDomain -DomainID $domain -SupportedServices email
    get-mgdomain -DomainID $domain

}