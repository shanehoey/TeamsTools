function remove-teamsToolsTenantNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = Get-CsTenantNetworkSubnet -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsTenantNetworkSubnet $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if ($PSCmdlet.ShouldProcess($($item.identity), "Remove Voice Configuration")) { 
                Remove-CsTenantNetworkSubnet -identity $($item.identity) -erroraction Stop 
                Write-Information -messageData  "Removed $($item.identity) Tenant Network Subnet" -informationaction continue
            }
        }
        catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}