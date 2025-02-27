# DOC Documentation initialize-teamsVirtualNetworkSite
# INVESTIGATE  should these function do any cross checking or just create the new object ? 

Function initialize-teamsVirtualNetworkSite {
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

    $item = [VirtualNetworkSite]::new($NetworkSiteID, $NetworkRegionID)

    if ($EmergencyCallingPolicy){$item.EmergencyCallingPolicy = $EmergencyCallingPolicy}
    If ($EmergencyCallRoutingPolicy){$item.EmergencyCallRoutingPolicy = $EmergencyCallRoutingPolicy}
    If ($EnableLocationBasedRouting){$item.EnableLocationBasedRouting = $EnableLocationBasedRouting}
    If ($LocationPolicy){$item.LocationPolicy = $LocationPolicy}
    If ($NetworkRoamingPolicy){$item.NetworkRoamingPolicy = $NetworkRoamingPolicy}
    If ($OnlineVoiceRoutingPolicy){$item.OnlineVoiceRoutingPolicy = $OnlineVoiceRoutingPolicy}
    If ($SiteAddress){$item.SiteAddress = $SiteAddress}
    If ($Description){$item.Description = $Description}

    
    return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
