Function add-teamsVirtualSurvivableBranchAppliance {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
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

        $Item = [VirtualSurvivableBranchAppliance]::new($identity)
        if ($site) {$item.site =$site}
        if ($Description) {$item.Description = $Description}
     
        $script:VirtualTopology.SurvivableBranchAppliance.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

