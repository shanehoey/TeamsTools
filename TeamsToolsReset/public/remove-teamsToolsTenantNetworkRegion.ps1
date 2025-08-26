

function remove-teamsToolsTenantNetworkRegion {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()


    try { $items = Get-CsTenantNetworkRegion -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsTenantNetworkRegion $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if ($PSCmdlet.ShouldProcess($($item.identity), "Remove Voice Configuration")) {
                Remove-CsTenantNetworkRegion -identity $item.identity -ErrorAction Stop
                Write-Information -messageData  "Removed $($item.identity) Tenant Network Region" -informationaction continue
            }
        }
        catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}
