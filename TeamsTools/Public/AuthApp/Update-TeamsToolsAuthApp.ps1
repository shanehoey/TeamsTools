# DOC Documentation update=teamsToolsAuth
# IMPROVEMENT Add support for SupportsShouldProcess
Function Update-TeamsToolsAuthApp {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [int]$SecretDurationMonths = 3, 
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


if ($PSCmdlet.ShouldProcess("Update TeamsToolsAuthApp", "Perform update actions")) {
    Write-Error -Message "$($MyInvocation.MyCommand.Name) not implemented"
} else {
    Write-Verbose "Skipping Update-TeamsToolsAuthApp (ShouldProcess declined)."
}

}
