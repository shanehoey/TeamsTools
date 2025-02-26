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

Install-Module -Name MicrosoftTeams -MinimumVersion 6.8.0 -Scope AllUsers
Install-Module -Name ExchangeOnlineManagement -MinimumVersion 3.7.1 -Scope AllUsers
Install-Module -Name Microsoft.Graph.authentication -MinimumVersion 2.26.1 -Scope AllUsers
Install-Module -Name Microsoft.Graph.Applications -MinimumVersion 2.26.1 -Scope AllUsers
Install-Module -Name Microsoft.Graph.Identity.DirectoryManagement -MinimumVersion 2.26.1 -Scope AllUsers
Install-Module -Name Microsoft.Graph.Groups -MinimumVersion 2.26.1 -Scope AllUsers
Install-Module -Name Microsoft.Graph.Users -MinimumVersion 2.26.1 -Scope AllUsers

```
