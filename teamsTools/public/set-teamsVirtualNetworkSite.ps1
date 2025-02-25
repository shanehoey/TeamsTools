Function set-teamsVirtualNetworkSite {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
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
        [string]$Description
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ($script:VirtualTopology.NetworkRegion.NetworkRegionId -notcontains $NetworkRegionID ) {
        throw "NetworkRegionID $NetworkRegionID not found in VirtualTopology."
    }

    if ($script:VirtualTopology.NetworkSite.NetworkSiteID -notcontains $NetworkSiteID) {
        throw "NetworkSiteID $NetworkSiteID not found in VirtualTopology."
    }

    $item = $script:VirtualTopology.NetworkSite | where-object {$_.NetworkSiteID -eq $NetworkSiteID}
    $item.NetworkRegionID = $NetworkRegionID

    if ($EmergencyCallingPolicy){$item.EmergencyCallingPolicy = $EmergencyCallingPolicy}
    If ($EmergencyCallRoutingPolicy){$item.EmergencyCallRoutingPolicy = $EmergencyCallRoutingPolicy}
    If ($EnableLocationBasedRouting){$item.EnableLocationBasedRouting = $EnableLocationBasedRouting}
    If ($LocationPolicy){$item.LocationPolicy = $LocationPolicy}
    If ($NetworkRoamingPolicy){$item.NetworkRoamingPolicy = $NetworkRoamingPolicy}
    If ($OnlineVoiceRoutingPolicy){$item.OnlineVoiceRoutingPolicy = $OnlineVoiceRoutingPolicy}
    If ($SiteAddress){$item.SiteAddress = $SiteAddress}
    If ($Description){$item.Description = $Description}

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
