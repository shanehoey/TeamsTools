# DOC Documentation add-teamsvirtualnetworksubnet
# TODO Add support for SupportsShouldProcess

Function add-teamsVirtualNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param(
    [Parameter(Mandatory = $true)]
    [string]$SubnetId,
    [string]$Mask,
    [string]$NetworkSiteId,
    [string]$Description,
    [string]$source
    )
    try {

    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ( $script:VirtualTopology.NetworkSite.NetworkSiteId -notcontains $NetworkSiteId) {
        throw "NetworkSiteId $NetworkSiteId not found in VirtualTopology."
    }

    if ($script:VirtualTopology.NetworkSubnet.SubnetId -contains $SubnetId) {
        throw "SubnetId $SubnetId exists in VirtualTopology."
    }

    $Item = [VirtualNetworkSubnet]::new($NetworkSiteId, $SubnetId, $Mask)
    if ($Description){$item.Description = $Description}

    $script:VirtualTopology.NetworkSubnet.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
