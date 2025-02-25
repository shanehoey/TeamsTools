function remove-teamsToolsOnlineVoiceRoutingPolicy {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = Get-CsOnlineVoiceRoutingPolicy -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsOnlineVoiceRoutingPolicy $($error[0].exception.message)" }
    foreach ($item in $items) {
        try { 
            if ( $PSCmdlet.ShouldProcess($($item.identity), "Remove csOnlineVoiceRoutingPolicy" )) {
                Remove-CsOnlineVoiceRoutingPolicy -identity $($item.identity) -ErrorAction Stop
                write-information -MessageData "Removed $($item.identity) online voice routing policy" -informationaction continue
            }
        }
        catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        } 
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false
}
