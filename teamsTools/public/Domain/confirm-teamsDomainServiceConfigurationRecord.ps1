function confirm-teamsDomainServiceCongigurationRecord ($domain){

    Get-MgDomainServiceConfigurationRecord -DomainId $domain | sort-object SupportedService | FL SupportedService,RecordType,label,ttl,AdditionalProperties

}