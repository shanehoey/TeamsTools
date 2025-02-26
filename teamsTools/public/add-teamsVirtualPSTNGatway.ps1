# DOC Documentation Function add-teamsVirtualPSTNGateway
# TODO Add support for SupportsShouldProcess

Function add-teamsVirtualPSTNGateway {
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