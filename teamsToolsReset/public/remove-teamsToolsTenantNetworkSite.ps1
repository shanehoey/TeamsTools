function remove-teamsToolsTenantNetworkSite {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = Get-CsTenantNetworkSite -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsTenantNetworkSite $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if ($PSCmdlet.ShouldProcess($($item.identity), "Remove Voice Configuration")) { 
                Remove-CsTenantNetworkSite -identity $item.identity -ErrorAction Stop 
                Write-Information -messageData  "Removed $($item.identity) Tenant Network Site" -informationaction continue
            }
        }
        catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }

        Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false

    }
}
