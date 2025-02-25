function remove-teamsToolsOnlinePstnUsage {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = Get-CsOnlinePstnUsage -erroraction silentlycontinue } catch { write-warning "[Error] Get-CsOnlinePstnUsage $($error[0].exception.message)" }
    foreach ($item in $items.usage) {
        try {
            if ($PSCmdlet.ShouldProcess($($item.identity), "Remove CsOnlinePstnUsage")) {
                Set-CsOnlinePstnUsage -Identity global -Usage @{ Remove = $($item) } -ErrorAction Stop
                Write-Information -messageData  "Removed $($item) online PStn Usage" -informationaction continue
            }
        }
        catch {
            write-warning "[Error] $($item) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}
