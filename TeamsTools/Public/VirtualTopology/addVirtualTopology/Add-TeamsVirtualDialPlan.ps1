# DOC Documentation add-teamsVirtualDialPlan
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualDialPlan {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
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
        
        if ($PSCmdlet.ShouldProcess("VirtualTopology DialPlan '$Identity'","Add")) {
            $Item = [VirtualDialPlan]::new($Identity)
            if ($SimpleName){$item.SimpleName = $SimpleName}
            if ($ExternalAccessPrefix){$item.ExternalAccessPrefix = $ExternalAccessPrefix}
            if ($OptimizeDeviceDialing){$item.OptimizeDeviceDialing = $OptimizeDeviceDialing}
            if ($Description){$item.Description = $Description}

            $script:VirtualTopology.DialPlan.Add($Item)
        } else {
            Write-Verbose "Skipping add of DialPlan '$Identity' (ShouldProcess declined or -WhatIf)."
        }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

