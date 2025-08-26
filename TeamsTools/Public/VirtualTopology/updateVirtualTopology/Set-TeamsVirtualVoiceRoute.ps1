# DOC Documentation set-teams
# IMPROVEMENT Add support for SupportsShouldProcess
Function Set-TeamsVirtualVoiceRoute {
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
            Write-TeamsToolsError -Message "Teams VirtualTopology not found." -Terminate
        }

        if ($script:VirtualTopology.VoiceRoute.Identity -notcontains $Identity) {
            Write-TeamsToolsError -Message "Identity $Identity not found in VirtualTopology." -Terminate
        }
       
        foreach ($item in $PstnUsageList.pstnusage) {
        If ($script:VirtualTopology.PstnUsage.pstnusage -notcontains $item) {
            Write-TeamsToolsError -Message "PstnUsage $PstnUsage not found in VirtualTopology." -Terminate
        }
        }
    
        foreach ($item in $PstnGatewayList.identity) {
            If ($script:VirtualTopology.PSTNGateway.identity -notcontains $item) {
                    Write-TeamsToolsError -Message "pstngatewaylist $pstngatewaylist not found in VirtualTopology." -Terminate
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
        Write-TeamsToolsError -Message "$_.Exception.Message" -Exception $_.Exception -Terminate
    }
}
