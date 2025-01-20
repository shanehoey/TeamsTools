# TeamsTools
# https://github.com/shanehoey/TeamsTools

# TeamsVirtualTopology
Function Get-TeamsVirtualTopology {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param ()

    Try{

        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found. Please create new VirtualTopology with New-TeamsVirtualTopology."
        }

        return $Script:VirtualTopology

    }
    Catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function New-TeamsVirtualTopology {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DomainName
    )
    try{
        $Script:VirtualTopology = [VirtualTopology]::new($DomainName)
    }
    Catch {
        Write-Error -Message $_.Exception.Message
    }

}

# TeamsVirtualNetworkRegion
Function Add-TeamsVirtualNetworkRegion {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string]$NetworkRegionID,
        [Parameter(ValueFromPipeline)][string]$Description,
        [Parameter(ValueFromPipeline)][source]$source
    )
    
   try { 
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if  ($script:VirtualTopology.NetworkRegion.NetworkRegionID -contains $NetworkRegionID) {
        throw "VirtualTopology already contains $NetworkRegionID."
    }

    $item = [VirtualNetworkRegion]::new($NetworkRegionID)
    if ($Description){$item.Description = $Description}
    if ($source){$item.Source = $source}
    
    $Script:VirtualTopology.NetworkRegion.Add($item) 

    } Catch {
        Write-Error -Message "$_.Exception.Message"
    }

}

Function Set-TeamsVirtualNetworkRegion {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$NetworkRegionID,
        [string]$Description
    )
    
   try { 
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if  ($script:VirtualTopology.NetworkRegion.NetworkRegionID -notcontains $NetworkRegionID) {
        throw "VirtualTopology does not contain $NetworkRegionID."
    }

    $item = $script:VirtualTopology.NetworkRegion | where-object {$_.NetworkRegionID -eq $NetworkRegionID}
    $item.Description = $Description
    
    } Catch {
        Write-Error -Message "$_.Exception.Message"
    }

}

Function Get-TeamsVirtualNetworkRegion {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [string]$NetworkRegionID = "*"
    )
    
   try { 
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    $item = $script:VirtualTopology.NetworkRegion | where-object {$_.NetworkRegionID -like $NetworkRegionID}
    return $item
    
    } Catch {
        Write-Error -Message "$_.Exception.Message"
    }

}

# TeamsVirtualNetworkSite
Function Add-TeamsVirtualNetworkSite {
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

Function Set-TeamsVirtualNetworkSite {
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

Function Get-TeamsVirtualNetworkSite {
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

# TeamsVirtualNetworkSubnet
Function Add-TeamsVirtualNetworkSubnet {
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

Function Set-TeamsVirtualNetworkSubnet {
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

    $Item = $script:VirtualTopology.NetworkSubnet | where-object {$_.SubnetId -like $SubnetId -and $_.NetworkSiteId -like $NetworkSiteId}
    return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}


# TeamsVirtualTrustedIPAddress
Function Add-TeamsVirtualTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$IpAddress,
        [Parameter(Mandatory = $true)]
        [string]$Mask,
        [string]$Description  
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ($script:VirtualTopology.TrustedIPAddress.IPAddress -contains $IpAddress) {
        throw "IPAddress $IpAddress exists in VirtualTopology."
    }

    $Item = [VirtualTrustedIPAddress]::new($IpAddress, $Mask)
    if ($Description){$item.Description = $Description}

    $script:VirtualTopology.TrustedIPAddress.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-TeamsVirtualTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$IpAddress,
        [Parameter(Mandatory = $true)]
        [string]$Mask,
        [string]$Description  
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ($script:VirtualTopology.TrustedIPAddress.IPAddress -notcontains $IpAddress) {
        throw "IPAddress $IpAddress not found in VirtualTopology."
    }

    $Item = $script:VirtualTopology.TrustedIPAddress | where-object {$_.IPAddress -eq $IpAddress}
    $Item.Mask = $Mask
    $Item.Description = $Description

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [string]$IpAddress = "*"
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    $Item = $script:VirtualTopology.TrustedIPAddress | where-object {$_.IPAddress -like $IpAddress}
    return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

# TeamsVirtualPSTNGateway

Function Add-TeamsVirtualPSTNGateway {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [string] $Identity,
    [int] $SipSignalingPort,
    [int] $MaxConcurrentSessions,
    [string] $SendSipOptions,
    [string] $ForwardCallHistory,
    [string] $ForwardPai,
    [string] $FailoverResponseCodes,
    [string] $FailoverTimeSeconds,
    [string] $MediaBypass,
    [string] $BypassMode,

    [string] $ProxySbc,
    [string] $Enabled,
    [string] $Description,
    [string] $GatewayLbrEnabledUserOverride,
    [string] $GatewaySiteId,
    [string] $GatewaySiteLbrEnabled,
    [string] $InboundPstnNumberTranslationRules,
    [string] $InboundTeamsNumberTranslationRules,
    [string] $MediaRelayRoutingLocationOverride,
    [string] $OutboundPstnNumberTranslationRules,
    [string] $OutboundTeamsNumberTranslationRules
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }
        if ($script:VirtualTopology.PSTNGateway.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        if ($PSBoundParameters.ContainsKey('GatewaySiteId')){
            If ($script:VirtualTopology.Networksite.NetworkSiteId -notcontains $GatewaySiteId) {
                throw "GatewaySiteId $GatewaySiteId not found in VirtualTopology."
            }
        }

        $Item = [VirtualPSTNGateway]::new($Identity)
        if ($SipSignalingPort){$item.SipSignalingPort = $SipSignalingPort}
        if ($maxConcurrentSessions){$item.MaxConcurrentSessions = $MaxConcurrentSessions}
        if ($SendSipOptions){$item.SendSipOptions = $SendSipOptions}
        if ($ForwardCallHistory){$item.ForwardCallHistory = $ForwardCallHistory}
        if ($ForwardPai){$item.ForwardPai = $ForwardPai}
        if ($FailoverResponseCodes){$item.FailoverResponseCodes = $FailoverResponseCodes}
        if ($FailoverTimeSeconds){$item.FailoverTimeSeconds = $FailoverTimeSeconds}
        if ($MediaBypass){$item.MediaBypass = $MediaBypass}
        if ($BypassMode){$item.BypassMode = $BypassMode}
        if ($ProxySbc){$item.ProxySbc = $ProxySbc}
        if ($Enabled){$item.Enabled = $Enabled}
        if ($Description){$item.Description = $Description}
        if ($GatewayLbrEnabledUserOverride){$item.GatewayLbrEnabledUserOverride = $GatewayLbrEnabledUserOverride}
        if ($GatewaySiteId){$item.GatewaySiteId = $GatewaySiteId}
        if ($GatewaySiteLbrEnabled){$item.GatewaySiteLbrEnabled = $GatewaySiteLbrEnabled}
        if ($InboundPstnNumberTranslationRules){$item.InboundPstnNumberTranslationRules = $InboundPstnNumberTranslationRules}
        if ($InboundTeamsNumberTranslationRules){$item.InboundTeamsNumberTranslationRules = $InboundTeamsNumberTranslationRules}
        if ($MediaRelayRoutingLocationOverride){$item.MediaRelayRoutingLocationOverride = $MediaRelayRoutingLocationOverride}
        if ($OutboundPstnNumberTranslationRules){$item.OutboundPstnNumberTranslationRules = $OutboundPstnNumberTranslationRules}
        if ($OutboundTeamsNumberTranslationRules){$item.OutboundTeamsNumberTranslationRules = $OutboundTeamsNumberTranslationRules}

        $script:VirtualTopology.PSTNGateway.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }


}

Function Set-TeamsVirtualPSTNGateway {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [string] $Identity,
    [int] $SipSignalingPort,
    [int] $MaxConcurrentSessions,
    [string] $SendSipOptions,
    [string] $ForwardCallHistory,
    [string] $ForwardPai,
    [string] $FailoverResponseCodes,
    [string] $FailoverTimeSeconds,	
    [string] $MediaBypass,
    [string] $BypassMode,
    [string] $ProxySbc,
    [string] $Enabled,	
    [string] $Description,
    [string] $GatewayLbrEnabledUserOverride,
    [string] $GatewaySiteId,
    [string] $GatewaySiteLbrEnabled,
    [string] $InboundPstnNumberTranslationRules,
    [string] $InboundTeamsNumberTranslationRules,
    [string] $MediaRelayRoutingLocationOverride,
    [string] $OutboundPstnNumberTranslationRules,
    [string] $OutboundTeamsNumberTranslationRules
    )
    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.PSTNGateway.Identity -notcontains $Identity) {
            throw "Identity $Identity does not exist in VirtualTopology."
        }
        

        if ($PSBoundParameters.ContainsKey('ProxySbc')){
            If ($script:VirtualTopology.PSTNGateway.Identity -notcontains $proxysbc ) {
                throw "ProxySBC $ProxySBC not found in VirtualTopology."
            }
        }


        if ($PSBoundParameters.ContainsKey('GatewaySiteId')){
            If ($script:VirtualTopology.Networksite.NetworkSiteId -notcontains $GatewaySiteId) {
                throw "GatewaySiteId $GatewaySiteId not found in VirtualTopology."
            }
        }


        $Item = $script:VirtualTopology.PstnGateway | where-object {$_.Identity -eq $Identity}
        
        if ($SipSignalingPort){$item.SipSignalingPort = $SipSignalingPort}
        if ($maxConcurrentSessions){$item.MaxConcurrentSessions = $MaxConcurrentSessions}
        if ($SendSipOptions){$item.SendSipOptions = $SendSipOptions}
        if ($ForwardCallHistory){$item.ForwardCallHistory = $ForwardCallHistory}
        if ($ForwardPai){$item.ForwardPai = $ForwardPai}
        if ($FailoverResponseCodes){$item.FailoverResponseCodes = $FailoverResponseCodes}
        if ($FailoverTimeSeconds){$item.FailoverTimeSeconds = $FailoverTimeSeconds}
        if ($MediaBypass){$item.MediaBypass = $MediaBypass}
        if ($BypassMode){$item.BypassMode = $BypassMode}
        if ($ProxySbc){$item.ProxySbc = $ProxySbc}
        if ($Enabled){$item.Enabled = $Enabled}
        if ($Description){$item.Description = $Description}
        if ($GatewayLbrEnabledUserOverride){$item.GatewayLbrEnabledUserOverride = $GatewayLbrEnabledUserOverride}
        if ($GatewaySiteId){$item.GatewaySiteId = $GatewaySiteId}
        if ($GatewaySiteLbrEnabled){$item.GatewaySiteLbrEnabled = $GatewaySiteLbrEnabled}
        if ($InboundPstnNumberTranslationRules){$item.InboundPstnNumberTranslationRules = $InboundPstnNumberTranslationRules}
        if ($InboundTeamsNumberTranslationRules){$item.InboundTeamsNumberTranslationRules = $InboundTeamsNumberTranslationRules}
        if ($MediaRelayRoutingLocationOverride){$item.MediaRelayRoutingLocationOverride = $MediaRelayRoutingLocationOverride}
        if ($OutboundPstnNumberTranslationRules){$item.OutboundPstnNumberTranslationRules = $OutboundPstnNumberTranslationRules}
        if ($OutboundTeamsNumberTranslationRules){$item.OutboundTeamsNumberTranslationRules = $OutboundTeamsNumberTranslationRules}

        $script:VirtualTopology.PSTNGateway.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualPSTNGateway {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string]$Identity = "*"
    )
    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.PSTNGateway | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

# TeamsVirtualPstnUsage

Function Add-TeamsVirtualPstnUsage {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    $PstnUsage
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.PstnUsage.PstnUsage -contains $PstnUsage) {
            throw "PstnUsage $PstnUsage exists in VirtualTopology."
        }

        $Item = [VirtualPstnUsage]::new($PstnUsage)
        $script:VirtualTopology.PstnUsage.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }

}

Function Set-TeamsVirtualPstnUsage {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    $PstnUsage
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.PstnUsage.PstnUsage -notcontains $PstnUsage) {
            throw "PstnUsage $PstnUsage not found in VirtualTopology."
        }

        $Item = $script:VirtualTopology.PstnUsage | where-object {$_.PstnUsage -eq $PstnUsage}
        $script:VirtualTopology.PstnUsage.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }

}

Function Get-TeamsVirtualPstnUsage {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param()
    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.PSTNUsage
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}




# TeamsVirtualVoiceRoute
Function Add-TeamsVirtualVoiceRoute {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string] $Identity,
        [Parameter(Mandatory = $true)]
        [string] $NumberPattern,
        [Parameter(Mandatory = $true)]
        [System.Collections.Generic.List[string]] $PstnUsageList,
        [Parameter(Mandatory = $true)]
        [System.Collections.Generic.List[string]] $pstngatewayList,
        [Parameter(Mandatory = $false)]
        [string] $Priority = 1,
        [string] $Description,
        [string] $BridgeSourcePhoneNumber
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.VoiceRoute.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }
       
        foreach ($item in $PstnUsageList.pstnusage) {
            If ($script:VirtualTopology.PstnUsage.pstnusage -notcontains $item) {
                    throw "PstnUsage $item not found in VirtualTopology."
            }
        }
    
        foreach ($item in $PstnGatewayList.identity) {
            If ($script:VirtualTopology.PSTNGateway.identity -notcontains $item) {
                    throw "pstngatewaylist $item not found in VirtualTopology."
                }
        }

        $Item = [VirtualVoiceRoute]::new($Identity,$NumberPattern,$PstnUsageList,$PstnGatewayList,$priority)
        if ($Description){$item.Description = $Description}
        if ($BridgeSourcePhoneNumber){$item.BridgeSourcePhoneNumber = $BridgeSourcePhoneNumber}
        $script:VirtualTopology.VoiceRoute.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-teamsVirtualVoiceRoute {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string] $Identity,
        [Parameter(Mandatory = $true)]
        [string] $numberpattern,
        [Parameter(Mandatory = $true)]
        [System.Collections.Generic.List[VirtualPstnUsage]] $PstnUsageList,
        [Parameter(Mandatory = $true)]
        [System.Collections.Generic.List[VirtualPstnGateway]] $pstngatewayList,
        [Parameter(Mandatory = $false)]
        [string] $priority=1,
        [string] $Description,
        [string] $BridgeSourcePhoneNumber
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.VoiceRoute.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }
       
        foreach ($item in $PstnUsageList.pstnusage) {
            If ($script:VirtualTopology.PstnUsage.pstnusage -notcontains $item) {
                    throw "PstnUsage $PstnUsage not found in VirtualTopology."
            }
        }
    
        foreach ($item in $PstnGatewayList.identity) {
            If ($script:VirtualTopology.PSTNGateway.identity -notcontains $item) {
                    throw "pstngatewaylist $pstngatewaylist not found in VirtualTopology."
                }
        }

        $Item = $script:VirtualTopology.VoiceRoute | where-object {$_.Identity -eq $Identity}
        $Item.NumberPattern = $NumberPattern
        $Item.PstnUsageList = $PstnUsageList
        $Item.PstnGatewayList = $PstnGatewayList
        $Item.Priority = $Priority
        $Item.Description = $Description
        $Item.BridgeSourcePhoneNumber = $BridgeSourcePhoneNumber

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualVoiceRoute {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.VoiceRoute | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

# TeamsVirtualVoiceRoutingPolicy
Function Add-TeamsVirtualVoiceRoutingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $Identity,
    [System.Collections.Generic.List[string]] $pstnUsageList,
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.VoiceRoutingPolicy.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        foreach ($item in $pstnUsageList) {
            If ($script:VirtualTopology.PSTNUsage.PSTNUsage -notcontains $item) {
                throw "PSTNUsage $item not found in VirtualTopology."
            }
        }


        $Item = [VirtualVoiceRoutingPolicy]::new($Identity,$pstnUsageList)
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.VoiceRoutingPolicy.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function set-teamsvirtualVoiceRoutingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $Identity,
    [System.Collections.Generic.List[string]] $pstnUsageList,
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.VoiceRoutingPolicy.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        foreach ($item in $pstnUsageList) {
            If ($script:VirtualTopology.PSTNUsage.PSTNUsage -notcontains $item) {
                throw "PSTNUsage $item not found in VirtualTopology."
            }
        }
    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualVoiceRoutingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.VoiceRoutingPolicy | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

# TeamsVirtualDialPlan

Function Add-TeamsVirtualDialPlan {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [String] $SimpleName = $identity,
    [String] $ExternalAccessPrefix,
    [String] $OptimizeDeviceDialing,	
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.DialPlan.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        if ($script:VirtualTopology.DialPlan.simplename -contains $simplename) {
            throw "SimpleNaME $simplename exists in VirtualTopology."
        }
        
        $Item = [VirtualDialPlan]::new($Identity)
        if ($SimpleName){$item.SimpleName = $SimpleName}
        if ($ExternalAccessPrefix){$item.ExternalAccessPrefix = $ExternalAccessPrefix}
        if ($OptimizeDeviceDialing){$item.OptimizeDeviceDialing = $OptimizeDeviceDialing}
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.DialPlan.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-TeamsVirtualDialPlan {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [String] $SimpleName = $identity,
    [String] $ExternalAccessPrefix,
    [String] $OptimizeDeviceDialing,	
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.DialPlan.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        if ($script:VirtualTopology.DialPlan.simplename -notcontains $simplename) {
            throw "SimpleNaME $simplename not found in VirtualTopology."
        }
        
        $Item = $script:VirtualTopology.DialPlan | where-object {$_.Identity -eq $Identity}
        $Item.SimpleName = $SimpleName
        $Item.ExternalAccessPrefix = $ExternalAccessPrefix
        $Item.OptimizeDeviceDialing = $OptimizeDeviceDialing
        $Item.Description = $Description

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualDialPlan {
    
        [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
        param (
        [string] $Identity = "*",
        [string] $SimpleName = "*"
        )
    
        try {
            if (-not $script:VirtualTopology) {
                throw "Teams VirtualTopology not found."
            }
    
            $Item = $script:VirtualTopology.DialPlan | where-object {$_.Identity -like $Identity -and $_.SimpleName -like $SimpleName}
            return $Item
    
        } catch {
            Write-Error -Message "$_.Exception.Message"
        }
} 


# TeamsVirtualVoiceNormalisation

Function Add-TeamsVirtualVoiceNormalisation {

    [CmdletBinding(DefaultParameterSetName='default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName='default')]
        [ValidateNotNullOrEmpty()]
        [string] $Identity,
        [Parameter(Mandatory = $true, ParameterSetName='parent')]
        [ValidateNotNullOrEmpty()]
        [string] $Parent,
        [Parameter(Mandatory = $true, ParameterSetName='parent')]
        [ValidateNotNullOrEmpty()]
        [string] $Name,
        [ValidateNotNullOrEmpty()][string] $Pattern,
        [ValidateNotNullOrEmpty()][string] $Translation,
        [string] $isinternalextension,
        [string] $Priority =1,
        [string] $Description
    )

    try {

        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }
        
        # THIS IS BROKE when using IDENTITY 
        if ($script:VirtualTopology.VoiceNormalisationRule.Identity -contains $parent) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        if ($PSCmdlet.ParameterSetName -eq 'parent') {
            $Item = [VirtualVoiceNormalisation]::new($Parent,$Name,$Pattern,$Translation)
        } else {
            $Item = [VirtualVoiceNormalisation]::new($Identity,$Pattern,$Translation)
        }

        if ($isinternalextension){$item.isinternalextension = $isinternalextension}
        if ($Priority){$item.Priority = $Priority}
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.VoiceNormalisation.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-TeamsVirtualVoiceNormalisation {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $false)]
        [string] $Identity = "*",
        [ValidateNotNullOrEmpty()][string] $Pattern,
        [ValidateNotNullOrEmpty()][string] $Translation,
        [string] $isinternalextension,
        [string] $Priority =1,
        [string] $Description
    )

    try {

        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }
        
        if ($script:VirtualTopology.VoiceNormalisationRule.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        $Item = $script:VirtualTopology.VoiceNormalisation | where-object {$_.Identity -eq $Identity}
        $Item.Pattern = $Pattern
        $Item.Translation = $Translation
        $Item.isinternalextension = $isinternalextension
        $Item.Priority = $Priority
        $Item.Description = $Description

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualVoiceNormalisation {
    
        [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
        param (
        [string] $Identity = "*",
        [string] $Pattern = "*",
        [string] $Translation = "*"
        )
    
        try {
            if (-not $script:VirtualTopology) {
                throw "Teams VirtualTopology not found."
            }
    
            $Item = $script:VirtualTopology.VoiceNormalisation | where-object {$_.Identity -like $Identity -and $_.Pattern -like $Pattern -and $_.Translation -like $Translation}
            return $Item
    
        } catch {
            Write-Error -Message "$_.Exception.Message"
        }
}

# TeamsVirtualPhonePolicy

Function Add-TeamsVirtualPhonePolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [AllowBetterTogether] $AllowBetterTogether,
    [AllowHomeScreen] $AllowHomeScreen,
    [Boolean] $AllowHotDesking,
    [String] $HotDeskingIdleTimeoutInMinutes,	
    [String] $SearchOnCommonAreaPhoneMode,
    [SignInMode] $SignInMode,
    [String] $Description

    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.PhonePolicy.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        $Item = [VirtualPhonePolicy]::new($Identity)
        if ($AllowBetterTogether){$item.AllowBetterTogether = $AllowBetterTogether}
        if ($AllowHomeScreen){$item.AllowHomeScreen = $AllowHomeScreen}
        if ($AllowHotDesking){$item.AllowHotDesking = $AllowHotDesking}
        if ($HotDeskingIdleTimeoutInMinutes){$item.HotDeskingIdleTimeoutInMinutes = $HotDeskingIdleTimeoutInMinutes}
        if ($SearchOnCommonAreaPhoneMode){$item.SearchOnCommonAreaPhoneMode = $SearchOnCommonAreaPhoneMode}
        if ($SignInMode){$item.SignInMode = $SignInMode}
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.PhonePolicy.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-TeamsVirtualPhonePolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [AllowBetterTogether] $AllowBetterTogether,
    [AllowHomeScreen] $AllowHomeScreen,
    [Boolean] $AllowHotDesking,
    [String] $HotDeskingIdleTimeoutInMinutes,	
    [String] $SearchOnCommonAreaPhoneMode,
    [SignInMode] $SignInMode,
    [String] $Description

    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.PhonePolicy.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        $Item = $script:VirtualTopology.PhonePolicy | where-object {$_.Identity -eq $Identity}
        if ($AllowBetterTogether){$item.AllowBetterTogether = $AllowBetterTogether}
        if ($AllowHomeScreen){$item.AllowHomeScreen = $AllowHomeScreen}
        if ($AllowHotDesking){$item.AllowHotDesking = $AllowHotDesking}
        if ($HotDeskingIdleTimeoutInMinutes){$item.HotDeskingIdleTimeoutInMinutes = $HotDeskingIdleTimeoutInMinutes}
        if ($SearchOnCommonAreaPhoneMode){$item.SearchOnCommonAreaPhoneMode = $SearchOnCommonAreaPhoneMode}
        if ($SignInMode){$item.SignInMode = $SignInMode}
        if ($Description){$item.Description = $Description}

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualPhonePolicy {
    
        [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
        param (
        [string] $Identity = "*"
        )
    
        try {
            if (-not $script:VirtualTopology) {
                throw "Teams VirtualTopology not found."
            }
    
            $Item = $script:VirtualTopology.PhonePolicy | where-object {$_.Identity -like $Identity}
            return $Item
    
        } catch {
            Write-Error -Message "$_.Exception.Message"
        }
}

# TeamsCallingIDPolicy

Function Add-TeamsCallingIdPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [Boolean] $BlockIncomingPstnCallerID,
    [String] $CallingIDSubstitute,
    [String] $CompanyName,	
    [Boolean] $EnableUserOverride ,	
    [String] $ResourceAccount 	,
    [String] $ServiceNumber ,
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.CallingLineIdentity.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        $Item = [CallingIDPolicy]::new($Identity)
        if ($BlockIncomingPstnCallerID){$item.BlockIncomingPstnCallerID = $BlockIncomingPstnCallerID}
        if ($CallingIDSubstitute){$item.CallingIDSubstitute = $CallingIDSubstitute}
        if ($CompanyName){$item.CompanyName = $CompanyName}
        if ($Description){$item.Description = $Description}
        if ($EnableUserOverride){$item.EnableUserOverride = $EnableUserOverride}
        if ($ResourceAccount){$item.ResourceAccount = $ResourceAccount}
        if ($ServiceNumber){$item.ServiceNumber = $ServiceNumber}
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.CallingLineIdentity.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-TeamsCallingIdPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [Boolean] $BlockIncomingPstnCallerID,
    [String] $CallingIDSubstitute,
    [String] $CompanyName,	
    [Boolean] $EnableUserOverride ,	
    [String] $ResourceAccount 	,
    [String] $ServiceNumber ,
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.CallingLineIdentity.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        $Item = $script:VirtualTopology.CallingLineIdentity | where-object {$_.Identity -eq $Identity}
        if ($BlockIncomingPstnCallerID){$item.BlockIncomingPstnCallerID = $BlockIncomingPstnCallerID}
        if ($CallingIDSubstitute){$item.CallingIDSubstitute = $CallingIDSubstitute}
        if ($CompanyName){$item.CompanyName = $CompanyName}
        if ($Description){$item.Description = $Description}
        if ($EnableUserOverride){$item.EnableUserOverride = $EnableUserOverride}
        if ($ResourceAccount){$item.ResourceAccount = $ResourceAccount}
        if ($ServiceNumber){$item.ServiceNumber = $ServiceNumber}
        if ($Description){$item.Description = $Description}

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsCallingIdPolicy {
    
        [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
        param (
        [string] $Identity = "*"
        )
    
        try {
            if (-not $script:VirtualTopology) {
                throw "Teams VirtualTopology not found."
            }
    
            $Item = $script:VirtualTopology.CallingLineIdentity | where-object {$_.Identity -like $Identity}
            return $Item
    
        } catch {
            Write-Error -Message "$_.Exception.Message"
        }
}

# TeamsVirtualEmergencyCallingPolicy

Function Add-TeamsVirtualEmergencyCallingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity	,
    [ValidateNotNullOrEmpty()][string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.EmergencyCallingPolicy.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        $Item = [VirtualEmergencyCallingPolicy]::new($Identity)
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.EmergencyCallingPolicy.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-teamsVirtualEmergencyCallingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity	,
    [ValidateNotNullOrEmpty()][string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.EmergencyCallingPolicy.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        $Item = $script:VirtualTopology.EmergencyCallingPolicy | where-object {$_.Identity -eq $Identity}
        $Item.Description = $Description

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}



# TeamsVirtualSurvivableBranchAppliancePolicy
Function Add-TeamsVirtualSurvivableBranchAppliancePolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $Identity,
    [System.Collections.Generic.List[string]] $BranchApplianceFqdns
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.SurvivableBranchAppliancePolicy.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        $Item = [VirtualSurvivableBranchAppliancePolicy]::new($Identity)
        if($BranchApplianceFqdns){$item.BranchApplianceFqdns = $BranchApplianceFqdns}

        $script:VirtualTopology.SurvivableBranchAppliancePolicy.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-TeamsVirtualSurvivableBranchAppliancePolicy {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Identity,
        [Parameter(Mandatory = $true)]
        [System.Collections.Generic.List[string]] $BranchApplianceFqdns
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ($script:VirtualTopology.SurvivableBranchAppliancePolicy.identity -notcontains $identity) {
        throw "Identity $Identity not found in VirtualTopology."
    }

    $Item = $script:VirtualTopology.SurvivableBranchAppliancePolicy.identity | where-object {$_.identity -eq $Identity}
    $Item.BranchApplianceFqdns = $BranchApplianceFqdns

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualSurvivableBranchAppliancePolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.SurvivableBranchAppliancePolicy | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}



# TeamsVirtualSurvivableBranchAppliance
Function Add-TeamsVirtualSurvivableBranchAppliance {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $identity,
    [string] $Site,
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.SurvivableBranchAppliance.identity -contains $identity) {
            throw "Identity $identity exists in VirtualTopology."
        }

        $Item = [VirtualSurvivableBranchAppliance]::new($identity)
        if ($site) {$item.site =$site}
        if ($Description) {$item.Description = $Description}
     
        $script:VirtualTopology.SurvivableBranchAppliance.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-TeamsVirtualSurvivableBranchAppliance {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$identity,
        [string]$site,
        [string]$Description

    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ($script:VirtualTopology.SurvivableBranchAppliance.identity -notcontains $identity) {
        throw "identity $identity not found in VirtualTopology."
    }

    $Item = $script:VirtualTopology.SurvivableBranchAppliance | where-object {$_.identity -eq $identity}
    if ($item.site) {$Item.site = $site}
    if ($item.description) { $Item.site = $site }


    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualSurvivableBranchAppliance {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.SurvivableBranchAppliance | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}



# TeamsVirtualUser
Function Add-teamsVirtualUser {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity, #EmergencyCallRoutingPolicy
    [string] $VoiceRoutingPolicy,
    [string] $Telephonenumber,
    [string] $TelephoneNumberType = "DirectRouting",
    [Boolean] $EnterpriseVoiceEnabled = $true, 
    [string] $DialPlan,
    [String] $PhonePolicy,
    [String] $EmergencyCallingPolicy,
    [String] $EmergencyCallRoutingPolicy,    
    [string] $UsageLocation,
    [String] $DialOutPolicy,
    [String] $CallingIDPolicy,
    [String] $CallHoldPolicy,
    [String] $CallParkPolicy,
    [String] $CallingLineIdentityPolicy,
    [String] $TeamsMobilityPolicy,
    [String] $VoicemailPolicy,
    [String] $SurvivableBranchAppliancePolicy

    )

    try {

        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.User.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        if ($PSBoundParameters.ContainsKey('VoiceRoutingPolicy')){
            If ($script:VirtualTopology.VoiceRoutingPolicy.Identity -notcontains $VoiceRoutingPolicy) {
                throw "VoiceRoutingPolicy $VoiceRoutingPolicy not found in VirtualTopology."
            }
       }

        $Item = [VirtualUser]::new($Identity)
        if ($VoiceRoutingPolicy){$item.VoiceRoutingPolicy = $VoiceRoutingPolicy}
        if ($Telephonenumber){$item.Telephonenumber = $Telephonenumber}
        if ($TelephoneNumberType){$item.TelephoneNumberType = $TelephoneNumberType}
        if ($EnterpriseVoiceEnabled){$item.EnterpriseVoiceEnabled = $EnterpriseVoiceEnabled}
        if ($DialPlan){$item.DialPlan = $DialPlan}
        if ($PhonePolicy){$item.PhonePolicy = $PhonePolicy}
        if ($EmergencyCallingPolicy){$item.EmergencyCallingPolicy = $EmergencyCallingPolicy}
        if ($EmergencyCallRoutingPolicy){$item.EmergencyCallRoutingPolicy = $EmergencyCallRoutingPolicy}
        if ($UsageLocation){$item.UsageLocation = $UsageLocation}
        if ($DialOutPolicy){$item.DialOutPolicy = $DialOutPolicy}
        if ($CallingIDPolicy){$item.CallingIDPolicy = $CallingIDPolicy}
        if ($CallHoldPolicy){$item.CallHoldPolicy = $CallHoldPolicy}
        if ($CallParkPolicy){$item.CallParkPolicy = $CallParkPolicy}
        if ($CallingLineIdentityPolicy){$item.CallingLineIdentityPolicy = $CallingLineIdentityPolicy}
        if ($TeamsMobilityPolicy){$item.TeamsMobilityPolicy = $TeamsMobilityPolicy}
        if ($VoicemailPolicy){$item.VoicemailPolicy = $VoicemailPolicy}
        if ($SurvivableBranchAppliancePolicy){$item.SurvivableBranchAppliancePolicy = $SurvivableBranchAppliancePolicy}
        
        $script:VirtualTopology.User.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Set-teamsVirtualUser {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity, #EmergencyCallRoutingPolicy
    [string] $VoiceRoutingPolicy,
    [string] $Telephonenumber,
    [string] $TelephoneNumberType = "DirectRouting",
    [Boolean] $EnterpriseVoiceEnabled = $true, 
    [string] $DialPlan,
    [String] $PhonePolicy,
    [String] $EmergencyCallingPolicy,
    [String] $EmergencyCallRoutingPolicy,    
    [string] $UsageLocation,
    [String] $DialOutPolicy,
    [String] $CallingIDPolicy,
    [String] $CallHoldPolicy,
    [String] $CallParkPolicy,
    [String] $CallingLineIdentityPolicy,
    [String] $TeamsMobilityPolicy,
    [String] $VoicemailPolicy,
    [String] $SurvivableBranchAppliancePolicy

    )

    try {

        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.User.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        if ($PSBoundParameters.ContainsKey('VoiceRoutingPolicy')){
            If ($script:VirtualTopology.VoiceRoutingPolicy.Identity -notcontains $VoiceRoutingPolicy) {
                throw "VoiceRoutingPolicy $VoiceRoutingPolicy not found in VirtualTopology."
            }
        }

        $Item = $script:VirtualTopology.User | where-object {$_.Identity -eq $Identity}

        if ($VoiceRoutingPolicy){$item.VoiceRoutingPolicy = $VoiceRoutingPolicy}
        if ($Telephonenumber){$item.Telephonenumber = $Telephonenumber}
        if ($TelephoneNumberType){$item.TelephoneNumberType = $TelephoneNumberType}
        if ($EnterpriseVoiceEnabled){$item.EnterpriseVoiceEnabled = $EnterpriseVoiceEnabled}
        if ($DialPlan){$item.DialPlan = $DialPlan}
        if ($PhonePolicy){$item.PhonePolicy = $PhonePolicy}
        if ($EmergencyCallingPolicy){$item.EmergencyCallingPolicy = $EmergencyCallingPolicy}
        if ($EmergencyCallRoutingPolicy){$item.EmergencyCallRoutingPolicy = $EmergencyCallRoutingPolicy}
        if ($UsageLocation){$item.UsageLocation = $UsageLocation}
        if ($DialOutPolicy){$item.DialOutPolicy = $DialOutPolicy}
        if ($CallingIDPolicy){$item.CallingIDPolicy = $CallingIDPolicy}
        if ($CallHoldPolicy){$item.CallHoldPolicy = $CallHoldPolicy}
        if ($CallParkPolicy){$item.CallParkPolicy = $CallParkPolicy}
        if ($CallingLineIdentityPolicy){$item.CallingLineIdentityPolicy = $CallingLineIdentityPolicy}
        if ($TeamsMobilityPolicy){$item.TeamsMobilityPolicy = $TeamsMobilityPolicy}
        if ($VoicemailPolicy){$item.VoicemailPolicy = $VoicemailPolicy}
        if ($SurvivableBranchAppliancePolicy){$item.SurvivableBranchAppliancePolicy = $SurvivableBranchAppliancePolicy}
    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

Function Get-TeamsVirtualUser {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.User | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}