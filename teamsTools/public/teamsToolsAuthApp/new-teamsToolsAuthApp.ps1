# DOC Documentation NewteamsToolsAuth
# IMPROVEMENT Add support for SupportsShouldProcess

Function New-teamsToolsAuthApp {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param (
        [int]$secretDurationMonths = 3

    )
    try {
        #Check if Application exists
        if (Get-MgApplication -Filter "displayName eq 'TeamsToolsAuth'") {
            throw "An application with the display name 'TeamsToolsAuth' already exists."
        } else {

            # Create the Azure AD application
            $application = New-MgApplication -DisplayName "TeamsToolsAuth"
            Write-verbose -message  "Created application 'TeamsToolsAuth'."

            # Create a service principal for the application
            $servicePrincipal = New-MgServicePrincipal -AppId $application.AppId
            Write-verbose -message  "Created service principal for 'TeamsToolsAuth'."

            # Add the required permissions to the service principal
            $apiPermission = Get-MgServicePrincipal -Filter "displayName eq 'Microsoft Graph'"
            $permissions = @(
                "Organization.Read.All",
                "User.Read.All",
                "Group.ReadWrite.All",
                "AppCatalog.ReadWrite.All",
                "TeamSettings.ReadWrite.All",
                "Channel.Delete.All",
                "ChannelSettings.ReadWrite.All",
                "ChannelMember.ReadWrite.All"
            )

            foreach ($permission in $permissions) {
                $appRole = $apiPermission.AppRoles | Where-Object { $_.Value -eq $permission }
                new-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id -PrincipalId $servicePrincipal.Id -ResourceId $apiPermission.Id -AppRoleId $appRole.Id | out-null
                Write-verbose -message  "Added permission '$permission' to service principal."
            }

            # Assign the Teams Administrator role to the service principal
            $RoleDefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Teams Administrator'"
            New-MgRoleManagementDirectoryRoleAssignment -PrincipalId $servicePrincipal.Id -RoleDefinitionId $RoleDefinition.Id -DirectoryScopeId "/"
            Write-verbose -Message "Assigned Teams Administrator role to service principal."

            # BUG Exchange Online Administrator
            Write-Verbose -message "Assigning Exchange Online Administrator role to service principal"
            Write-warning -message "BUG Token authentication not supported for Exchange Online, WORKAROUND : manually connect to exchange online"

            # Create a new client secret for the application
            $passwordCredential = @{
                displayName = "TeamsToolAuth ${Get-Date}"
                endDateTime = (Get-Date).AddMonths($SecretDurationMonths)
            }

            $secret = Add-MGApplicationPassword -ApplicationID $application.Id -PasswordCredential $passwordCredential
            Write-verbose -message  "Created client secret for application 'TeamsToolsAuth'."

            $secrets = [PSCustomObject]@{
                ClientId = $application.AppId
                ClientSecret = $secret.SecretText
                TenantId = (Get-MgOrganization).Id
            }

            return $secrets
        } 
        
    } catch {
        Write-Error -message "Error creating the TeamsToolsAuth App : $_"
    }
}
