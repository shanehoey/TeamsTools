Function set-teamsVirtualEmergencyCallingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity	,
    [ValidateNotNullOrEmpty()][string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.EmergencyCallingPolicy.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        $Item = $script:VirtualTopology.EmergencyCallingPolicy | where-object {$_.Identity -eq $Identity}
        $Item.Description = $Description

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

