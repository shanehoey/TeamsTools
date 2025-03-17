import-module ./teamsTools/  -force  -Verbose
import-teamsToolsauthfile -filename /home/shane/Documents/TeamsTools/TeamsToolsAuth.json | Connect-teamsTools


# Get the current domains in the tenant
get-teamsDomain 

add-teamsDomain -domain "sandbox.shanehoey.dev"
add-teamsDomain -domain "sandbox.shanehoey.dev","play.shanehoey.dev"


get-teamsDomainVerificiationRecord
get-teamsDomainVerificiationRecord -domain "sandbox.shanehoey.dev"


confirm-teamsDomainVerificationRecord -domain "sandbox.shanehoey.dev"
confirm-teamsDomainVerificationRecord -domain "play.shanehoey.dev"



get-teamsDomainConfigurationRecord
-domain "play.shanehoey.dev"

confirm-teamsDomainService -domain "play.shanehoey.dev"
