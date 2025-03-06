# DOC Documentation remove-teamsToolsAuth
# IMPROVEMENT Add support for SupportsShouldProcess

Function remove-TeamsToolsAuth {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact = 'High')]
    param ()

    # Connect to Microsoft Graph
    Connect-MgGraph -Scopes "Application.Read.All","Application.ReadWrite.All", 
                            "Directory.Read.All", "Directory.ReadWrite.All", 
                            "RoleManagement.ReadWrite.Directory","RoleManagement.Read.All",
                            "AppRoleAssignment.ReadWrite.All" -NoWelcome -UseDeviceCode

    # Remove the TeamsToolsAuth Azure AD application
    $application = Get-MgApplication -Filter "displayName eq 'TeamsToolsAuth'"

    if ($application) {
        if ($PSCmdlet.ShouldProcess("TeamsToolsAuth Azure App", "Remove-TeamsToolsAuth")) {
            Remove-MgApplication -ApplicationId $application.ID
            write-Warning "TeamsToolsAuth Azure AD application was Removed."
        }
    } else {
        write-Warning "TeamsToolsAuth Azure AD application not found."
    }

    # Disconnect from Microsoft Graph
    Disconnect-MgGraph  | out-null
}
