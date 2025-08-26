function remove-teamsToolsOnlineVoiceRoute {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = Get-CsOnlineVoiceRoute -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsOnlineVoiceRoute $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if ($PSCmdlet.ShouldProcess($($item.identity), "Remove CsOnlineVoiceRoute")) { 
                Remove-CsOnlineVoiceRoute -identity $item.identity -ErrorAction Stop
                Write-Information -messageData  "Removed $($item.identity) online voice route" -informationaction continue 
                
            }
        }
        catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false
}
