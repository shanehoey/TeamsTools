# DOC Documentation initialize-teamsVirtualSurvivableBranchAppliancePolicy
# INVESTIGATE  should these function do any cross checking or just create the new object ? 

Function initialize-teamsVirtualSurvivableBranchAppliancePolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $Identity,
    [System.Collections.Generic.List[string]] $BranchApplianceFqdns
    )

    try {

        $Item = [VirtualSurvivableBranchAppliancePolicy]::new($Identity)
        if($BranchApplianceFqdns){$item.BranchApplianceFqdns = $BranchApplianceFqdns}

        return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
