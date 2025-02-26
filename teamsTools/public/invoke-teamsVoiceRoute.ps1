# DOC Documentation invoke-teamsVoiceRoute
Function invoke-teamsVoiceRoute {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualVoiceRoute]]$VirtualVoiceRoute
    )

    Begin {}
    Process { 
        foreach ($Item in $VirtualVoiceRoute) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.identity) 
                $params.Add("NumberPattern", $Item.NumberPattern)
                $params.Add("OnlinePstnUsages", $Item.PstnUsageList)
                $params.Add("OnlinePstnGatewayList", $Item.PstnGatewayList)
                $params.Add("Priority", $Item.Priority)
                if($item.description) {$params.Add("Description", $Item.Description)}

                $voiceroute = Get-CsOnlineVoiceRoute -Identity $Item.identity -erroraction SilentlyContinue
                if ($voiceroute.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating OnlineVoiceRoute")) { set-csonlinevoiceroute @params -erroraction stop } }
                elseif ($voiceroute.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating OnlineVoiceRoute")) { new-csonlinevoiceroute @params -erroraction stop } }
                else { throw "Unknown VoiceRoute for $($Item.identity)" }
            }
            catch { write-warning "[Error] $identity -> $($_.exception.message)" } 
        }
    }
    End {}
}
