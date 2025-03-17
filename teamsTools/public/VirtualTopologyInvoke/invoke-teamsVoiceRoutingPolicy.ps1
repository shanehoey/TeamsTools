# DOC Documentation invoke-teamsVoiceRoutingPolicy

Function invoke-teamsVoiceRoutingPolicy {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualVoiceRoutingPolicy]]$VirtualVoiceRoutingPolicy
    )

    Begin {}
    Process {
        foreach ($Item in $VirtualVoiceRoutingPolicy) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.identity)
                $params.Add("OnlinePstnUsages", $Item.PstnUsageList)
                if($item.Description) {$params.Add("Description", $Item.Description)}
                $voiceRoutingPolicy = Get-CsOnlineVoiceRoutingPolicy -Identity $Item.identity -erroraction SilentlyContinue
                if ($voiceRoutingPolicy.count -eq 1) {if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating OnlineVoiceRoutingPolicy")) { set-CsOnlineVoiceRoutingPolicy @params -erroraction stop }}
                elseif ($voiceRoutingPolicy.count -eq 0){ if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating OnlineVoiceRoutingPolicy")) { new-CsOnlineVoiceRoutingPolicy @params -erroraction stop }}
                else { throw "Unknown VoiceRoutingPolicy for $($Item.identity)" }}
            catch {write-warning "[Error] $identity -> $($_.exception.message)"}
        }
    }
    End {}
}
