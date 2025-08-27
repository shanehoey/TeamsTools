
# Get the current domains in the tenant
get-teamsDomain

add-teamsDomain -domain "sandbox.shanehoey.dev"

get-teamsDomainVerificiationRecord -domain "sandbox.shanehoey.dev"

#TODO  Add the TXT record using automation 

confirm-teamsDomainVerificationRecord -domain "sandbox.shanehoey.dev"

get-teamsDomainConfigurationRecord | Format-Table -AutoSize

#BUG  Wildcard domains are not supported
get-teamsDomainConfigurationRecord -domain "sandbox.shanehoey.dev" | FL * 



# Manually confirm the domain in the Microsoft 365 Admin Center
# Manually set default domain in the Microsoft 365 Admin Center
