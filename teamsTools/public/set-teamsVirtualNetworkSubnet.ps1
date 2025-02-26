# DOC Documentation set-teamsVirtualNetworkSubnet
Function set-teamsVirtualNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param(
    [Parameter(Mandatory = $true)]
    [string]$SubnetId,
    [string]$Mask,
    [string]$NetworkSiteId,
    [string]$Description
    )
    try {

    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ( $script:VirtualTopology.NetworkSite.NetworkSiteId -notcontains $NetworkSiteId) {
        throw "NetworkSiteId $NetworkSiteId not found in VirtualTopology."
    }

    if ($script:VirtualTopology.NetworkSubnet.SubnetId -notcontains $SubnetId) {
        throw "SubnetId $SubnetId not found in VirtualTopology."
    }

    $Item = $script:VirtualTopology.NetworkSubnet | where-object {$_.SubnetId -eq $SubnetId}
    $Item.NetworkSiteId = $NetworkSiteId
    $Item.Mask = $Mask
    $Item.Description = $Description

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

