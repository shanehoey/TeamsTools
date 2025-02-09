
Connect-Mggraph -scopes "Domain.ReadWrite.All" 
Import-Module Microsoft.Graph.Identity.DirectoryManagement

New-MgDomain -AuthenticationType Managed -id "sandbox.shanehoey.dev" -IsAdminManaged -IsDefault 
New-MgDomain -AuthenticationType Managed -id "play.shanehoey.dev" -IsAdminManaged 
New-MgDomain -AuthenticationType Managed -id "hosting.shanehoey.dev" -IsAdminManaged

(Get-MgDomainVerificationDnsRecord -DomainId "sandbox.shanehoey.dev" | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text
(Get-MgDomainVerificationDnsRecord -DomainId "play.shanehoey.dev" | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text
(Get-MgDomainVerificationDnsRecord -DomainId "hosting.shanehoey.dev" | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text

dig sandbox.shanehoey.dev TXT
dig play.shanehoey.dev TXT
dig hosting.shanehoey.dev TXT

confirm-MgDomain -DomainId "sandbox.shanehoey.dev" | Format-list *
confirm-MgDomain -DomainId "play.shanehoey.dev" | Format-list *
confirm-MgDomain -DomainId "hosting.shanehoey.dev" | Format-list * 

get-mgdomain | select id, isDefault, supportedServices, VerificationDnsRecords, AdditionalProperties  | FT 

update-MgDomain -DomainID "sandbox.shanehoey.dev" -SupportedServices email
update-MgDomain -DomainID "play.shanehoey.dev" -SupportedServices email
update-MgDomain -DomainID "hosting.shanehoey.dev" -SupportedServices email

Get-MgDomainServiceConfigurationRecord -DomainId "sandbox.shanehoey.dev" | sort-object SupportedService | FL SupportedService,RecordType,label,ttl,AdditionalProperties
Get-MgDomainServiceConfigurationRecord -DomainId "play.shanehoey.dev" | sort-object SupportedService | FL SupportedService,RecordType,label,ttl,AdditionalProperties
Get-MgDomainServiceConfigurationRecord -DomainId "hosting.shanehoey.dev" | sort-object SupportedService | FL SupportedService,RecordType,label,ttl,AdditionalProperties

update-MgDomain -DomainID "sandbox.shanehoey.dev" -SupportedServices email
update-MgDomain -DomainID "play.shanehoey.dev" 
update-MgDomain -DomainID "hosting.shanehoey.dev" 


### TODO  AT MOMENT THE ONLY WAY TO CHANGE THE DOMAIN TO HEALTH IS TO GO VIA ADMIN CENTRE

get-mgdomain -DomainID "sandbox.shanehoey.dev"
get-mgdomain -DomainID "play.shanehoey.dev"
get-mgdomain -DomainID "hosting.shanehoey.dev" 
