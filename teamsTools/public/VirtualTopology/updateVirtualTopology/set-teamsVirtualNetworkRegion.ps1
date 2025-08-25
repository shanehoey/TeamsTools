# DOC Documentation set-teamsVirtualNetworkRegion
# IMPROVEMENT Add support for SupportsShouldProcess

Function set-teamsVirtualNetworkRegion {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$NetworkRegionID,
        [string]$Description
    )
    
   try { 
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if  ($script:VirtualTopology.NetworkRegion.NetworkRegionID -notcontains $NetworkRegionID) {
        throw "VirtualTopology does not contain $NetworkRegionID."
    }

    $item = $script:VirtualTopology.NetworkRegion | where-object {$_.NetworkRegionID -eq $NetworkRegionID}
    $item.Description = $Description
    
    } Catch {
        Write-Error -Message "$_.Exception.Message"
    }

}