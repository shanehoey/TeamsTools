# TeamsTools

The teamsTools module is a PowerShell module designed to extend and automate Microsoft Teams Direct Routing and related configuration tasks. :<!---->


Key Features

- **Virtual Topology Management**: Model Teams topology (gateways, routes, users, policies) in-memory or via files, then apply to a tenant.
- **Automation**: Functions to create, update, and remove Teams Direct Routing components.
- **Domain Management**: Add/remove domains and verify DNS records.
- **Graph Integration**: Connect and interact with Microsoft Graph for Teams management.
- **Defaults & Templates**: Provides default normalization rules and voice routes for quick setup.

cmdlets are organised by feature area 

- **AuthApp**: Manage TeamsTools authentication apps.
- **AuthFile**: Import/export authentication files.
- **Defaults**: Get default normalization rules and voice routes.
- **Domain**: Manage Teams domains and DNS records.
- **Graph**: Connect to Microsoft Graph.
- **VirtualTopology**: Add, get, create, and update virtual topology objects.
- **VirtualTopologyInvoke**: Cmdlets to invoke Teams configuration for dial plans, network regions/sites/subnets, phone policies, PSTN gateways/usages, etc


## Installation Teams Tools

```powershell 

install-module -Name TeamsTools
install-module -Name TeamsToolsReset  #Optional if you want to reset the domain 

```

## Installation Teams Tools Reset

Teams Tools Reset is not intended for normal production use. Please review the Module carefully before installing. 

This module is not required, and if installed incorrect usage will remove configuration from your tenant

```powershell 

install-module -Name TeamsToolsReset

```

### Installing PreRequisite Modules 

``` powershell

# Install as either ALLUsers or CurrentUser
$scope  = "CurrentUser"

Install-Module -Name MicrosoftTeams -MinimumVersion 7.3.1 -Scope $scope
Install-Module -Name ExchangeOnlineManagement -MinimumVersion 3.9.0 -Scope $scope
Install-Module -Name Microsoft.Graph.authentication -MinimumVersion 2.30.0 -Scope $scope
Install-Module -Name Microsoft.Graph.Applications -MinimumVersion 2.30.0 -Scope $scope
Install-Module -Name Microsoft.Graph.Identity.DirectoryManagement -MinimumVersion 2.30.0 -Scope $scope
Install-Module -Name Microsoft.Graph.Groups -MinimumVersion 2.30.0 -Scope $scope
Install-Module -Name Microsoft.Graph.Users -MinimumVersion 2.30.0 -Scope $scope

```

Install-Module -Name Microsoft.Graph.Identity.Governance -MinimumVersion 2.30.0 -Scope $scope

## Licensing
Licensed under MIT (LICENSE.txt), allowing free use, modification, and distribution.
