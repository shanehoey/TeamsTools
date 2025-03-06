
# Logon to azure ad 
connect-teamsToolsMSGraph -useDeviceCode 

# Check to see if logged on OK 
Get-TeamsToolsMSGraph
$tenantId = (Get-TeamsToolsMSGraph).TenantId
$tenant = (Get-TeamsToolsMSGraph).Tenant
$tenantId
$tenant

#Check to see if the app exists
Get-TeamsToolsMSGraphApp -tenantId $tenantId -appName "AuthenticationApp"

# delete the app if it exists 

# create the new app 
