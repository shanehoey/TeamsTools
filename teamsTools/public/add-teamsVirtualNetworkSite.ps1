# DOC Documentation add-teamsVirtualNetworkSite
# TODO Add support for SupportsShouldProcess

Function add-teamsVirtualNetworkSite {
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

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
