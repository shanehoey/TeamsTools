function Write-TeamsToolsError {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Message,

        [Parameter(Mandatory=$false)]
        [System.Exception]$Exception,

        [Parameter(Mandatory=$false)]
        [switch]$Terminate,

        [Parameter(Mandatory=$false)]
        [string]$ErrorId = 'TeamsToolsError',

        [Parameter(Mandatory=$false)]
        [System.Management.Automation.ErrorCategory]$Category = [System.Management.Automation.ErrorCategory]::NotSpecified
    )

    Write-Error -Message $Message -ErrorId $ErrorId -Category $Category

    if ($Terminate.IsPresent) {
        throw $Exception ?? (New-Object System.Exception -ArgumentList $Message)
    }
}
