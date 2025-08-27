# DOC Documentation add-teamsvirtualnetworksubnet
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
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

    if ($PSCmdlet.ShouldProcess("VirtualTopology NetworkSubnet '$SubnetId'","Add")) {
        $Item = [VirtualNetworkSubnet]::new($NetworkSiteId, $SubnetId, $Mask)
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.NetworkSubnet.Add($Item)
    } else {
        Write-Verbose "Skipping add of NetworkSubnet '$SubnetId' (ShouldProcess declined or -WhatIf)."
    }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
