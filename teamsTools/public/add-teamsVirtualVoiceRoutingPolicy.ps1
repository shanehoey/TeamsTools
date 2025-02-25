Function add-teamsVirtualVoiceRoutingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
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
            If ($script:VirtualTopology.PSTNUsage.PSTNUsage -notcontains $item) {
                throw "PSTNUsage $item not found in VirtualTopology."
            }
        }


        $Item = [VirtualVoiceRoutingPolicy]::new($Identity,$pstnUsageList)
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.VoiceRoutingPolicy.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}