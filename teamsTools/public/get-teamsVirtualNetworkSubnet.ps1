# DOC Documentation get-teamsVirtualNetworkSubnet
# IMPROVEMENT Add support for SupportsShouldProcess

Function get-teamsVirtualNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param(
    [string]$SubnetId = "*",
    [string]$NetworkSiteId = "*"
    )
    try {

    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    $Item = $script:VirtualTopology.NetworkSubnet | where-object {$_.SubnetId -like $SubnetId -and $_.NetworkSiteId -like $NetworkSiteId}
    return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}


