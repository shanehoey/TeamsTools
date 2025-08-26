function remove-teamsToolsTenantTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = Get-CsTenantTrustedIPAddress -erroraction silentlycontinue } catch { write-warning "[Error] Get-CsTenantTrustedIPAddress $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if ($PSCmdlet.ShouldProcess($($item.identity), "Remove CsTenantTrustedIPAddress ")) {
                Remove-CsTenantTrustedIPAddress -identity $item.identity -erroraction Stop 
                Write-Information -messageData  "Removed $($item.identity) Tenant Trusted IP Address" -informationaction continue
            }
        }
        catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}
