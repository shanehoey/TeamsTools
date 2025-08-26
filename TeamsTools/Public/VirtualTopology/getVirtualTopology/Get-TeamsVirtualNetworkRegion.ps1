# DOC Documentation get-teamsVirtualNetworkRegion
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualNetworkRegion {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [string]$NetworkRegionID = "*"
    )
    
   try { 
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    $item = $script:VirtualTopology.NetworkRegion | where-object {$_.NetworkRegionID -like $NetworkRegionID}
    return $item
    
    } Catch {
        Write-Error -Message "$_.Exception.Message"
    }

}