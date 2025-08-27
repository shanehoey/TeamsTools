# DOC Documentation get-teamsVirtualNetworkSubnet
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param(
    [string]$SubnetId = "*",
    [string]$NetworkSiteId = "*"
    )
    try {

    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if (-not $PSCmdlet.ShouldProcess("VirtualTopology NetworkSubnet", "Retrieve items matching '$SubnetId' and site '$NetworkSiteId'")) {
        Write-Verbose "Skipping retrieval of NetworkSubnet matching '$SubnetId' and site '$NetworkSiteId' (ShouldProcess declined)."
        return
    }

    $Item = $script:VirtualTopology.NetworkSubnet | where-object {$_.SubnetId -like $SubnetId -and $_.NetworkSiteId -like $NetworkSiteId}
    return $Item

    } catch {
        Write-Error -Message "$.Exception.Message"
    }
}


