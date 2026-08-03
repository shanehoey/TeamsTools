# TeamsTools

TeamsTools is a PowerShell module that extends and automates Microsoft Teams Direct Routing and related configuration tasks.


Key Features

- **Virtual Topology Management**: Model Teams topology (gateways, routes, users, policies) in memory or via files, then apply it to a tenant.
- **Automation**: Create, update, and remove Teams Direct Routing components.
- **Domain Management**: Add and remove domains, and verify DNS records.
- **Graph Integration**: Connect to Microsoft Graph for Teams management.
- **Defaults & Templates**: Use default normalization rules and voice routes for quick setup.

Cmdlets are organized by feature area:

- **AuthApp**: Manage TeamsTools authentication apps.
- **AuthFile**: Import/export authentication files.
- **Defaults**: Get default normalization rules and voice routes.
- **Domain**: Manage Teams domains and DNS records.
- **Graph**: Connect to Microsoft Graph.
- **VirtualTopology**: Add, get, create, and update virtual topology objects.
- **VirtualTopologyInvoke**: Cmdlets to invoke Teams configuration for dial plans, network regions/sites/subnets, phone policies, PSTN gateways/usages, etc


## Install TeamsTools

```powershell

Install-Module -Name TeamsTools
Install-Module -Name TeamsToolsReset # Optional if you want to reset the domain

```

## Install TeamsToolsReset

TeamsToolsReset is not intended for normal production use. Review the module carefully before installing.

This module is optional, but incorrect usage can remove configuration from your tenant.

```powershell

Install-Module -Name TeamsToolsReset

```

### Install prerequisite modules

```powershell

# Install for either AllUsers or CurrentUser
$scope = "CurrentUser"

$prereqModules = @(
    @{ Name = "MicrosoftTeams"; MinimumVersion = [version]"7.9.0" }
    @{ Name = "ExchangeOnlineManagement"; MinimumVersion = [version]"3.10.1" }
    @{ Name = "Microsoft.Graph.authentication"; MinimumVersion = [version]"2.38.1" }
    @{ Name = "Microsoft.Graph.Applications"; MinimumVersion = [version]"2.38.1" }
    @{ Name = "Microsoft.Graph.Identity.DirectoryManagement"; MinimumVersion = [version]"2.38.1" }
    @{ Name = "Microsoft.Graph.Groups"; MinimumVersion = [version]"2.38.1" }
    @{ Name = "Microsoft.Graph.Users"; MinimumVersion = [version]"2.38.1" }
    @{ Name = "Microsoft.Graph.Teams"; MinimumVersion = [version]"2.38.1" }
)

foreach ($module in $prereqModules) {
    Install-Module -Name $module.Name -MinimumVersion $module.MinimumVersion -Scope $scope
}

```
### Check prerequisite modules

This check confirms that the required modules are installed and that their versions meet the minimums above.

```powershell

# Use the same $prereqModules list as above.
foreach ($module in $prereqModules) {
    $installedModule = Get-Module -ListAvailable -Name $module.Name | Sort-Object Version -Descending | Select-Object -First 1

    if (-not $installedModule) {
        Write-Warning "Module $($module.Name) is not installed."
        continue
    }

    if ($installedModule.Version -lt $module.MinimumVersion) {
        Write-Warning "Module $($module.Name) is installed at version $($installedModule.Version), but version $($module.MinimumVersion) or later is required."
    }
}

```



## Licensing
Licensed under MIT (LICENSE.txt), allowing free use, modification, and distribution.
