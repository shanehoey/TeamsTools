<#
.SYNOPSIS
Connects to Microsoft Graph using the specified scopes.

.DESCRIPTION
The Connect-TeamsToolsGraph function connects to Microsoft Graph with the provided scopes. 
It supports both device code authentication and interactive login.

.PARAMETER useDeviceCode
A switch parameter to indicate whether to use device code authentication.

.PARAMETER scopes
An array of scopes to request access to. The default scopes are:
- Application.ReadWrite.All
- Directory.ReadWrite.All
- RoleManagement.ReadWrite.Directory
- AppRoleAssignment.ReadWrite.All

.EXAMPLE
PS C:\> Connect-TeamsToolsGraph -useDeviceCode

This example connects to Microsoft Graph using device code authentication.

.EXAMPLE
PS C:\> Connect-TeamsToolsGraph

This example connects to Microsoft Graph using interactive login.

.NOTES
If the connection fails, appropriate error messages will be displayed based on the exception message.
#>

Function Connect-TeamsToolsGraph {
    [CmdletBinding(SupportsShouldProcess=$false, ConfirmImpact = 'low')]
    param (
        [switch]$useDeviceCode,
        [array]$scopes = @("Application.ReadWrite.All","Directory.ReadWrite.All","RoleManagement.ReadWrite.Directory","AppRoleAssignment.ReadWrite.All")
    )

    try {
        if ($UseDeviceCode) {
            Connect-MgGraph -Scopes $scopes -UseDeviceCode -noWelcome -ErrorAction stop
        } else {
            Connect-MgGraph -Scopes $scopes -noWelcome  -ErrorAction stop 
        }
    } catch {
        # BUG trycatch not working but may not be supported
        if ($_.Exception.Message -match "browser was closed") {
            Write-Error -message "Failed to connect to Microsoft Graph: Browser was closed."
        } elseif ($_.Exception.Message -match "login failed") {
            Write-Error -message "Failed to connect to Microsoft Graph: Login failed."
        } else {
            Write-Error -message "Failed to connect to Microsoft Graph: $_"
        }
    }

}