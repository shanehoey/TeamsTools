# TeamsTools

A PowerShell Module, that includes a collection of scripts to expand on Managing Microsoft Teams with PowerShell.<!---->

## Installation Teams Tools

```powershell 

install-module -Name TeamsTools

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