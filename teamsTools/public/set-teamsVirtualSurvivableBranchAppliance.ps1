
Function set-teamsVirtualSurvivableBranchAppliance {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$identity,
        [string]$site,
        [string]$Description

    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ($script:VirtualTopology.SurvivableBranchAppliance.identity -notcontains $identity) {
        throw "identity $identity not found in VirtualTopology."
    }

    $Item = $script:VirtualTopology.SurvivableBranchAppliance | where-object {$_.identity -eq $identity}
    if ($item.site) {$Item.site = $site}
    if ($item.description) { $Item.site = $site }


    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

