# DOC Documentation NewteamsToolsAuth
# IMPROVEMENT Add support for SupportsShouldProcess

Function New-teamsToolsAuth {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'med')]
    param (
        [int]$secretDurationMonths = 3,
        
        [string]$filename

    )
    try {
        #Check if Filename is valid or already exists
        if ($filename){
            if (-not ($Filename -match '\.json$')) {
                throw "The filename must end with '.json'."
            }

            $parentPath = Split-Path -Path $Filename -Parent
            if (-not (Test-Path $parentPath)) {
                throw "The path '$parentPath' does not exist."
            }

            if (Test-Path $Filename) {
                throw "The file '$Filename' already exists."
            }
        }

        # Connect to Microsoft Graph
        Connect-MgGraph -Scopes "Application.Read.All","Application.ReadWrite.All", "Directory.Read.All", "Directory.ReadWrite.All", "RoleManagement.ReadWrite.Directory","RoleManagement.Read.All", "AppRoleAssignment.ReadWrite.All" -NoWelcome -UseDeviceCode
        Write-verbose -messaage  "Connected to Microsoft Graph."

        # Check if TeamsToolsAuth application already exists

        if (Get-MgApplication -Filter "displayName eq 'TeamsToolsAuth'") {
            throw "An application with the display name 'TeamsToolsAuth' already exists."
        } else {

            # Create the Azure AD application
            $application = New-MgApplication -DisplayName "TeamsToolsAuth"
            Write-verbose -messaage  "Created application 'TeamsToolsAuth'."
            # Create a service principal for the application
            $servicePrincipal = New-MgServicePrincipal -AppId $application.AppId
            Write-verbose -messaage  "Created service principal for application 'TeamsToolsAuth'."
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
                Write-verbose -messaage  "Added permission '$permission' to service principal."
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
                displayName = "Created for CreateTeamsToolAuth ${Get-Date}"
                endDateTime = (Get-Date).AddMonths($SecretDurationMonths)
            }
            $secret = Add-MGApplicationPassword -ApplicationID $application.Id -PasswordCredential $passwordCredential
            Write-verbose -messaage  "Created client secret for application 'TeamsToolsAuth'."

            # Save the client ID, client secret, and tenant ID to a JSON file
            if($filename) {
            $secrets = [PSCustomObject]@{
                ClientId = $application.AppId
                ClientSecret = $secret.SecretText
                TenantId = (Get-MgOrganization).Id
            }
            $secretsJson = $secrets | ConvertTo-Json
            $secureContent = ConvertTo-SecureString -String $secretsJson -AsPlainText -Force
            $secureContent | ConvertFrom-SecureString | Out-File -FilePath $filename -Force
            
            Write-verbose -messaage  "Saved client ID, client secret, and tenant ID to '$filename'."
            }
        }

        # Disconnect from Microsoft Graph
        Disconnect-MgGraph | out-null

        return $secrets
        
    } catch {
        Write-Error $_
        return $null 
    }
}
