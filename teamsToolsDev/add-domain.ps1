

function add-teamsDomain ($domain) {

    $newdomain = New-MgDomain -AuthenticationType Managed -id $domain -IsAdminManaged -IsDefault 
    $msrecord = (Get-MgDomainVerificationDnsRecord -DomainId $domain | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text
    
}


function confirmDomain ($domain) {

    confirm-MgDomain -DomainId $domain | Format-list *
    get-mgdomain | select id, isDefault, supportedServices, VerificationDnsRecords, AdditionalProperties  | FT 
    update-MgDomain -DomainID $domain -SupportedServices email

    
}


function confirmService ($domain){

    Get-MgDomainServiceConfigurationRecord -DomainId $domain | sort-object SupportedService | FL SupportedService,RecordType,label,ttl,AdditionalProperties
    update-MgDomain -DomainID $domain -SupportedServices email
    get-mgdomain -DomainID $domain

}


#$Connect-Mggraph -scopes "Domain.ReadWrite.All" 
#Disconnect-MgGraph 


### TODO  AT MOMENT THE ONLY WAY TO CHANGE THE DOMAIN TO HEALTH IS TO GO VIA ADMIN CENTRE
