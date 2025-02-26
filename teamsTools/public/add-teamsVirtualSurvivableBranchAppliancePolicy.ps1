# DOC Documentation add-teamsVirtualSurvivableBranchAppliancePolicy
# TODO Add support for SupportsShouldProcess

Function add-teamsVirtualSurvivableBranchAppliancePolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $Identity,
    [System.Collections.Generic.List[string]] $BranchApplianceFqdns
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.SurvivableBranchAppliancePolicy.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        $Item = [VirtualSurvivableBranchAppliancePolicy]::new($Identity)
        if($BranchApplianceFqdns){$item.BranchApplianceFqdns = $BranchApplianceFqdns}

        $script:VirtualTopology.SurvivableBranchAppliancePolicy.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
