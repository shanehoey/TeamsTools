# DOC Documentation remove-teamsToolsAuthApp
# IMPROVEMENT Add support for SupportsShouldProcess

Function Remove-TeamsToolsAuthApp {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact = 'High')]
    param ()

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

}
