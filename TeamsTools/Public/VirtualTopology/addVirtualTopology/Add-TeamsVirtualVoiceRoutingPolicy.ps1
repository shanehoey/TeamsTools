# DOC Documentation add-teamsVirtualVoiceRoutingPolicy
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualVoiceRoutingPolicy {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (

    [string] $Identity,
    [System.Collections.Generic.List[string]] $pstnUsageList,
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.VoiceRoutingPolicy.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        foreach ($item in $pstnUsageList) {
            If ($script:VirtualTopology.PstnUsage.PstnUsage -notcontains $item) {
                throw "PstnUsage $item not found in VirtualTopology."
            }
        }


        if ($PSCmdlet.ShouldProcess("VirtualTopology VoiceRoutingPolicy '$Identity'","Add")) {
            $Item = [VirtualVoiceRoutingPolicy]::new($Identity,$pstnUsageList)
            if ($Description){$item.Description = $Description}

            $script:VirtualTopology.VoiceRoutingPolicy.Add($Item)
        } else {
            Write-Verbose "Skipping add of VoiceRoutingPolicy '$Identity' (ShouldProcess declined or -WhatIf)."
        }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}