# DOC Documentation add-teamsVirtualNetworkSite
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualNetworkSite {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NetworkSiteID,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NetworkRegionID,

        [string]$EmergencyCallingPolicy,
        [string]$EmergencyCallRoutingPolicy,
        [Boolean]$EnableLocationBasedRouting,
        [string]$LocationPolicy,
        [string]$NetworkRoamingPolicy,
        [string]$OnlineVoiceRoutingPolicy,
        [string]$SiteAddress,
        [string]$Description,
        [string]$source

    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ($script:VirtualTopology.NetworkRegion.NetworkRegionId -notcontains $NetworkRegionID ) {
        throw "NetworkRegionID $NetworkRegionID not found in VirtualTopology."
    }

    if ($script:VirtualTopology.NetworkSite.NetworkSiteID -contains $NetworkSiteID) {
        throw "NetworkSiteID $NetworkSiteID exists in VirtualTopology."
    }

    if ($PSCmdlet.ShouldProcess("VirtualTopology NetworkSite '$NetworkSiteID'","Add")) {
        $item = [VirtualNetworkSite]::new($NetworkSiteID, $NetworkRegionID)

        if ($EmergencyCallingPolicy){$item.EmergencyCallingPolicy = $EmergencyCallingPolicy}
        If ($EmergencyCallRoutingPolicy){$item.EmergencyCallRoutingPolicy = $EmergencyCallRoutingPolicy}
        If ($EnableLocationBasedRouting){$item.EnableLocationBasedRouting = $EnableLocationBasedRouting}
        If ($LocationPolicy){$item.LocationPolicy = $LocationPolicy}
        If ($NetworkRoamingPolicy){$item.NetworkRoamingPolicy = $NetworkRoamingPolicy}
        If ($OnlineVoiceRoutingPolicy){$item.OnlineVoiceRoutingPolicy = $OnlineVoiceRoutingPolicy}
        If ($SiteAddress){$item.SiteAddress = $SiteAddress}
        If ($Description){$item.Description = $Description}

        $item.Description = $description
        $script:VirtualTopology.NetworkSite.Add($item)
    } else {
        Write-Verbose "Skipping add of NetworkSite '$NetworkSiteID' (ShouldProcess declined or -WhatIf)."
    }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
