# Install Microsoft Graph module if not already installed
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph)) {
    Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
}

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Application.Read.All","Application.ReadWrite.All"

#                        "Directory.Read.All", "Directory.ReadWrite.All", 
#                        "RoleManagement.ReadWrite.Directory","RoleManagement.Read.All",
#                        "AppRoleAssignment.ReadWrite.All"

#REMOVE existing

$removeAppId = Get-MgApplication -Filter "displayName eq 'TeamsToolsAuth'"
if($removeAppId) { remove-MgApplication -ApplicationId $removeAppId.ID }
Get-MgApplication 

# Create the Azure AD application
$application = New-MgApplication -DisplayName "TeamsToolsAuth"
$application 

# Create a service principal for the application
$servicePrincipal = New-MgServicePrincipal -AppId $application.AppId
$servicePrincipal

# Add the required permissions to the service principal
$apiPermission = Get-MgServicePrincipal -Filter "displayName eq 'Microsoft Graph'"
$apiPermission

# Add the required permissions to the service principal
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

# Add the required permissions to the service principal
foreach ($permission in $permissions) {
    $appRole = $apiPermission.AppRoles | Where-Object { $_.Value -eq $permission }
    new-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $servicePrincipal.Id -PrincipalId $servicePrincipal.Id -ResourceId $apiPermission.Id -AppRoleId $appRole.Id
}

# Create a new client secret for the application
$passwordCredential = @{
    displayName = 'Created in PowerShell'
    endDateTime = (Get-Date).AddMonths(6)
 }
$secret = Add-MGApplicationPassword -ApplicationID $application.Id -PasswordCredential $passwordCredential
$Secret

$secrets = @{
    ClientId = $application.AppId
    ClientSecret = $secret.SecretText
    TenantId = (Get-MgOrganization).Id
}
$secretsJson = $secrets | ConvertTo-Json
$jsonFilePath = "$HOME/Documents/TeamsTools/teamsTools.json"
$secureContent = ConvertTo-SecureString -String $secretsJson -AsPlainText -Force
$secureContent | ConvertFrom-SecureString | Out-File -FilePath $jsonFilePath -Force


# Assign the Teams Administrator role to the service principal
$RoleDefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Teams Administrator'"
$RoleDefinition
$ServicePrincipal = Get-MgServicePrincipal -Filter "displayName eq 'TeamsToolsAuth'"
$servicePrincipal
New-MgRoleManagementDirectoryRoleAssignment -PrincipalId $ServicePrincipal.Id -RoleDefinitionId $RoleDefinition.Id -DirectoryScopeId "/"

# Assign the Exchange Online Administrator role to the service principal
$RoleDefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Exchange Administrator'"
$RoleDefinition
$ServicePrincipal = Get-MgServicePrincipal -Filter "displayName eq 'TeamsToolsAuth'"
$servicePrincipal
New-MgRoleManagementDirectoryRoleAssignment -PrincipalId $ServicePrincipal.Id -RoleDefinitionId $RoleDefinition.Id -DirectoryScopeId "/"


# Disconnect from Microsoft Graph
Disconnect-MgGraph
