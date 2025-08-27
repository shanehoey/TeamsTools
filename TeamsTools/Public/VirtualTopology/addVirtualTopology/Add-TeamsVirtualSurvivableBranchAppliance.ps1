# DOC Documentation add-teamsVirtualSurvivableBranchAppliance
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualSurvivableBranchAppliance {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (

    [string] $identity,
    [string] $Site,
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.SurvivableBranchAppliance.identity -contains $identity) {
            throw "Identity $identity exists in VirtualTopology."
        }

        if ($PSCmdlet.ShouldProcess("VirtualTopology SurvivableBranchAppliance '$identity'","Add")) {
            $Item = [VirtualSurvivableBranchAppliance]::new($identity)
            if ($site) {$item.site =$site}
            if ($Description) {$item.Description = $Description}
        
            $script:VirtualTopology.SurvivableBranchAppliance.Add($Item)
        } else {
            Write-Verbose "Skipping add of SurvivableBranchAppliance '$identity' (ShouldProcess declined or -WhatIf)."
        }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

