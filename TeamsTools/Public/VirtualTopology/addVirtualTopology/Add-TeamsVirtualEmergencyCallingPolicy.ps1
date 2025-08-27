# DOC Documentation add-teamsVirtualEmergencyCallingPolicy
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualEmergencyCallingPolicy {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
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

        if ($script:VirtualTopology.EmergencyCallingPolicy.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        if ($PSCmdlet.ShouldProcess("VirtualTopology EmergencyCallingPolicy '$Identity'","Add")) {
            $Item = [VirtualEmergencyCallingPolicy]::new($Identity)
            if ($Description){$item.Description = $Description}

            $script:VirtualTopology.EmergencyCallingPolicy.Add($Item)
        } else {
            Write-Verbose "Skipping add of EmergencyCallingPolicy '$Identity' (ShouldProcess declined or -WhatIf)."
        }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}


