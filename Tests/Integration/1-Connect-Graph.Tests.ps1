
Import-Module ./TeamsTools/ -Force #-Verbose
Disconnect-TeamsToolsGraph
	
# Expected Result: Error Message to authenticate
Get-TeamsToolsGraph
Get-TeamsToolsGraph -domain "notRealDomain" 
Get-TeamsToolsGraph -tenantID "notRealTenantID"

Test-TeamsToolsGraph 
# Should I throw if the tenantid is not correct format
Test-TeamsToolsGraph -domain "notRealDomain"
# Should I throw if the tenantid is not correct format
Test-TeamsToolsGraph -tenantID "notRealTenantID"
	
Connect-TeamsToolsGraph -scopes "Application.Read.All","User.Read.All"
Test-TeamsToolsGraph
Disconnect-TeamsToolsGraph

Connect-TeamsToolsGraph -scopes "Application.Read.All","User.Read.All"
Test-TeamsToolsGraph
Disconnect-TeamsToolsGraph
		
Connect-TeamsToolsGraph -useDeviceCode
Test-TeamsToolsGraph 
Disconnect-TeamsToolsGraph

	
Connect-TeamsToolsGraph
Test-TeamsToolsGraph


Test-TeamsToolsGraph -domain (Get-TeamsToolsGraph).tenant[0]
Test-TeamsToolsGraph -tenantID (Get-TeamsToolsGraph).tenantID

Test-TeamsToolsGraph -domain "notRealDomain"
Test-TeamsToolsGraph -tenantID "notRealTenantID"

