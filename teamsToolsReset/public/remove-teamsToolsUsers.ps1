function remove-teamsToolsUsers {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = get-csonlineuser -erroraction SilentlyContinue } catch { write-warning "[Error] get-csonlineusers $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if ($item.EnterpriseVoiceEnabled) {
                if ($PSCmdlet.ShouldProcess($($item.sipaddress), "Remove Voice Configuration")) {
                
                    if ($item.lineuri) { Grant-CsOnlineVoiceRoutingPolicy -identity $item.identity -PolicyName $null -ErrorAction Stop }
                    if ($item.OnlineVoiceRoutingPolicy) { Remove-CsPhoneNumberAssignment -identity $item.identity -RemoveAll -ErrorAction Stop } 
                    if ($item.TenantDialPlan) { Grant-CsTenantDialPlan -Identity $item.identity -PolicyName $null -ErrorAction Stop }
   
                    write-information -MessageData "Removed $($item.sipaddress) Voice Configuration" -informationaction continue
                }
            }
        }
        catch {
            write-error -message "$($item.sipaddress) $($error[0].exception.message)" -CategoryActivity "Error"
        }
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false
}
