function remove-teamsToolsOnlinePSTNGateway {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = Get-CsOnlinePSTNGateway -erroraction SilentlyContinue | sort-object ProxySBC -Descending } catch { write-warning "[Error] Get-CsOnlinePSTNGateway $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if ($PSCmdlet.ShouldProcess($($item.identity), "Remove CsOnlinePSTNGateway")) { 
                Remove-CsOnlinePSTNGateway -identity $item.identity -ErrorAction Stop
                Write-Information -messageData  "Removed $($item.identity) Online PSTN Gateway" -informationaction continue
            }
        }
        catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false
}
