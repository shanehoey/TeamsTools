# DOC Documentation get-teamsVirtualNetworkSite
# IMPROVEMENT Add support for SupportsShouldProcess

Function get-teamsVirtualNetworkSite {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param(
        [string]$NetworkSiteID = "*",

        [string]$NetworkRegionID = "*"
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    $item = $script:VirtualTopology.NetworkSite | where-object {$_.NetworkSiteID -like $NetworkSiteID -and $_.NetworkRegionID -like $NetworkRegionID}
    return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}


