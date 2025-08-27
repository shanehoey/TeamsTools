
# Get the current domains in the tenant
get-teamsDomain

add-teamsDomain -domain "sandbox.shanehoey.dev"
add-teamsDomain -domain "sandbox.shanehoey.dev","play.shanehoey.dev"
add-teamsDomain -domain "sandbox.audiocodes.dev","hosting.audiocodes.dev"

get-teamsDomainVerificiationRecord
get-teamsDomainVerificiationRecord -domain "sandbox.shanehoey.dev"

#TODO  Add the TXT record using automation 


confirm-teamsDomainVerificationRecord -domain "sandbox.shanehoey.dev"
confirm-teamsDomainVerificationRecord 


get-teamsDomainConfigurationRecord | Format-Table -AutoSize

#BUG  Wildcard domains are not supported
get-teamsDomainConfigurationRecord -domain "play*.shanehoey.dev"


get-teamsDomainConfigurationRecord -domain "play.shanehoey.dev"


#CHECK: Is this a valid command in the module ?
confirm-teamsDomainService -domain "play.shanehoey.dev"

# Manually confirm the domain in the Microsoft 365 Admin Center
# Manually set default domain in the Microsoft 365 Admin Center
