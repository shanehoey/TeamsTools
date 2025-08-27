# DOC Documentation set-teamsVirtualSurvivableBranchAppliancePolicy
# IMPROVEMENT Add support for SupportsShouldProcess
Function Set-TeamsVirtualSurvivableBranchAppliancePolicy {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Identity,
        [Parameter(Mandatory = $true)]
        [System.Collections.Generic.List[string]] $BranchApplianceFqdns
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ($script:VirtualTopology.SurvivableBranchAppliancePolicy.identity -notcontains $identity) {
        throw "Identity $Identity not found in VirtualTopology."
    }

    $Item = $script:VirtualTopology.SurvivableBranchAppliancePolicy.identity | where-object {$_.identity -eq $Identity}
    $Item.BranchApplianceFqdns = $BranchApplianceFqdns

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}


