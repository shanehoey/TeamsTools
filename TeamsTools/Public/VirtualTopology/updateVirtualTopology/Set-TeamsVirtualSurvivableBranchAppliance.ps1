# DOC Documentation set-teamsvirtualsurvivablebranchappliance
# IMPROVEMENT Add support for SupportsShouldProcess
Function Set-TeamsVirtualSurvivableBranchAppliance {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
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

    if ($PSCmdlet.ShouldProcess("VirtualTopology SurvivableBranchAppliance '$identity'","Update")) {
        $Item = $script:VirtualTopology.SurvivableBranchAppliance | where-object {$_.identity -eq $identity}
        if ($item.site) {$Item.site = $site}
        if ($item.description) { $Item.site = $site }
    } else {
        Write-Verbose "Skipping update of SurvivableBranchAppliance '$identity' (ShouldProcess declined or -WhatIf)."
    }


    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

