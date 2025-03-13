# DOC Documentation update=teamsToolsAuth
# IMPROVEMENT Add support for SupportsShouldProcess

Function update-teamsToolsAuth {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'med')]
    param (
        [int]$fecretDurationMonths = 3,
        
        [string]$filename

    )

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
    Connect-MgGraph -Scopes "Application.Read.All","Application.ReadWrite.All", 
                            "Directory.Read.All", "Directory.ReadWrite.All", 
                            "RoleManagement.ReadWrite.Directory","RoleManagement.Read.All",
                            "AppRoleAssignment.ReadWrite.All"

   write-warning -message "Update-TeamsToolsAuth not implemented"

}
