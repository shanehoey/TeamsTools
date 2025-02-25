Function invoke-teamsPstnGateway {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualPstnGateway]]$VirtualPstnGateway
    )

    Begin {}
    Process {
        foreach ($Item in $VirtualPstnGateway) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.identity)
                if($item.Enabled){$params.Add("Enabled", $Item.Enabled)}
                if($item.SipSignalingPort){ $params.Add("SipSignalingPort", $Item.sipsignalingport) }
                if($item.MaxConcurrentSessions){$params.Add("MaxConcurrentSessions", $Item.maxconcurrentsessions)}
                if($item.sendSipOptions){$params.Add("sendSipOptions", $Item.sendsipoptions)}
                if($item.ForwardCallHistory){$params.Add("ForwardCallHistory", $Item.forwardcallhistory)}
                if($item.Forwardpai){$params.Add("Forwardpai", $Item.forwardpai)}
                if($item.$mediaRelayRoutingLocationOverride) {$params.Add("MediaRelayRoutingLocationOverride", $Item.mediarelayroutinglocationoverride)}
                if($item.FailoverResponseCodes) {$params.Add("FailoverResponseCodes", $Item.failoverresponsecodes)}
                if($item.FailoverTimeSeconds) {$params.Add("FailoverTimeSeconds", $Item.failovertimeseconds)}
                if($item.MediaBypass) {$params.Add("MediaBypass", $Item.mediabypass)}
                if($item.bypassmode) {$params.add("BypassMode", $Item.bypassmode)}
                if($item.ProxySBC) {$params.add("ProxySBC", $Item.ProxySBC)}
                if($item.gatewaysiteid){$params.Add("gatewaysiteid", $Item.gatewaysiteid)}
                if($item.GatewaySiteLbrEnabled){$params.Add("GatewaySiteLbrEnabled", $Item.GatewaySiteLbrEnabled)}
                if($item.GatewayLbrEnabledUserOverride){$params.Add("GatewayLbrEnabledUserOverride", $Item.GatewayLbrEnabledUserOverride)}   
                $PstnGateway = Get-CsOnlinePstnGateway -Identity $Item.identity -erroraction SilentlyContinue
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$PstnGateway} | Convertto-json -depth 10)
                if ($PstnGateway.count -eq 1) { if($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating OnlinePstnGateway")) { Set-CsOnlinePstnGateway @params -erroraction stop }}
                elseif ($PstnGateway.count -eq 0) { if($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating OnlinePstnGateway")) { New-CsOnlinePstnGateway @params -erroraction stop }}
                else { throw "Unknown PstnGateway for $($item.identity)" }
            }
            catch { write-warning "[Error] $($item.identity) -> $($_.exception.message)" }   
        }
    }
    End {}
}