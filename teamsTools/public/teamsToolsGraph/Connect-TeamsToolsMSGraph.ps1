
Function connect-teamsToolsMSGraph {
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