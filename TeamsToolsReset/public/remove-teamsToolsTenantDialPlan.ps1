function remove-teamsToolsTenantDialPlan {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = Get-CsTenantDialPlan -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsTenantDialPlan $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if ($PSCmdlet.ShouldProcess($($item.identity), "Remove CsTenantDialPlan")) {
                Remove-CsTenantDialPlan -identity $item.identity -ErrorAction Stop 
                Write-Information -messageData  "Removed $($item.identity) Tenant Dial Plan" -informationaction continue
            }
        }
        catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}
