# DOC Documentation set-teams
Function set-teamsVirtualVoiceRoute {

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
