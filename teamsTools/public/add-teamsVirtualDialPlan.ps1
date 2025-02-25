Function add-teamsVirtualDialPlan {

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

        if ($script:VirtualTopology.DialPlan.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        if ($script:VirtualTopology.DialPlan.simplename -contains $simplename) {
            throw "SimpleNaME $simplename exists in VirtualTopology."
        }
        
        $Item = [VirtualDialPlan]::new($Identity)
        if ($SimpleName){$item.SimpleName = $SimpleName}
        if ($ExternalAccessPrefix){$item.ExternalAccessPrefix = $ExternalAccessPrefix}
        if ($OptimizeDeviceDialing){$item.OptimizeDeviceDialing = $OptimizeDeviceDialing}
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.DialPlan.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

