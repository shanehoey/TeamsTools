# DOC Documentation set-teams
# TODO Add support for SupportsShouldProcess

Function set-teamsvirtualVoiceRoutingPolicy {

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

        if ($script:VirtualTopology.VoiceRoutingPolicy.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        foreach ($item in $pstnUsageList) {
            If ($script:VirtualTopology.PSTNUsage.PSTNUsage -notcontains $item) {
                throw "PSTNUsage $item not found in VirtualTopology."
            }
        }
    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
