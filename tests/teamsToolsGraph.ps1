# Test Connection while disconnected

# Expected Result Warning Message not connected
Disconnect-TeamsToolsGraph

#Expected Result Error Message to authenticate
Get-TeamsToolsGraph
Get-TeamsToolsGraph -domain "notRealDomain"
Get-TeamsToolsGraph -domain (Test-TeamsToolsGraph).tenant
Get-TeamsToolsGraph -tenantID "notRealTenantID"
Get-TeamsToolsGraph -tenantID (Test-TeamsToolsGraph).tenantID

# Expected Result $false
Test-TeamsToolsGraph
Test-TeamsToolsGraph -domain "notRealDomain"
Test-TeamsToolsGraph -domain (Test-TeamsToolsGraph).tenant
Test-TeamsToolsGraph -tenantID "notRealTenantID"
Test-TeamsToolsGraph -tenantID (Test-TeamsToolsGraph).tenantID 


# Logon to azure ad 

Connect-TeamsToolsGraph -scopes "Application.Read.All","User.Read.All" -useDeviceCode
Disconnect-TeamsToolsGraph

Connect-TeamsToolsGraph -scopes "Application.Read.All","User.Read.All"
Disconnect-TeamsToolsGraph

Connect-TeamsToolsGraph -useDeviceCode 
Disconnect-TeamsToolsGraph

Connect-TeamsToolsGraph


#  Expected Result $true
Test-TeamsToolsGraph
Test-TeamsToolsGraph -domain (Test-TeamsToolsGraph).tenant
Test-TeamsToolsGraph -tenantID (Test-TeamsToolsGraph).tenantID 
# Expected Result $false
Test-TeamsToolsGraph -domain "notRealDomain"
Test-TeamsToolsGraph -tenantID "notRealTenantID"


Get-TeamsToolsGraph
Get-TeamsToolsGraph -domain "notRealDomain"
get-TeamsToolsGraph -domain (Test-TeamsToolsGraph).tenant
get-TeamsToolsGraph -tenantID "notRealTenantID"
get-TeamsToolsGraph -tenantID (Test-TeamsToolsGraph).tenantID 

