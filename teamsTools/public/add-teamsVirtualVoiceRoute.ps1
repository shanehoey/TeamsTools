# DOC Documentation add-teamsvirtualvoiceroute
# TODO Add support for SupportsShouldProcess

Function add-teamsVirtualVoiceRoute {

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

