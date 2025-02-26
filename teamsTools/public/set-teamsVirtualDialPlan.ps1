# DOC Documentation set-teamsVirtualDialPlan
Function set-teamsVirtualDialPlan {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [String] $SimpleName = $identity,
    [String] $ExternalAccessPrefix,
    [String] $OptimizeDeviceDialing,	
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.DialPlan.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        if ($script:VirtualTopology.DialPlan.simplename -notcontains $simplename) {
            throw "SimpleNaME $simplename not found in VirtualTopology."
        }
        
        $Item = $script:VirtualTopology.DialPlan | where-object {$_.Identity -eq $Identity}
        $Item.SimpleName = $SimpleName
        $Item.ExternalAccessPrefix = $ExternalAccessPrefix
        $Item.OptimizeDeviceDialing = $OptimizeDeviceDialing
        $Item.Description = $Description

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

