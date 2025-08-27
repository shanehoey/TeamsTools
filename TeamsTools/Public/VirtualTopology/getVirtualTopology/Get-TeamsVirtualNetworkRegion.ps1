# DOC Documentation get-teamsVirtualNetworkRegion
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualNetworkRegion {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [string]$NetworkRegionID = "*"
    )
    
    try { 
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if (-not $PSCmdlet.ShouldProcess("VirtualTopology NetworkRegion", "Retrieve items matching '$NetworkRegionID'")) {
        Write-Verbose "Skipping retrieval of NetworkRegion matching '$NetworkRegionID' (ShouldProcess declined)."
        return
    }

    $item = $script:VirtualTopology.NetworkRegion | where-object {$_.NetworkRegionID -like $NetworkRegionID}
    return $item
    
    } Catch {
        Write-Error -Message "$.Exception.Message"
    }

}