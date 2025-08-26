function remove-teamsToolsSurvivableBranchAppliance {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "HIGH")]
    param()

    try { $items = Get-CsTeamsSurvivableBranchAppliance -erroraction SilentlyContinue } catch { write-warning "[Error] get-CsTeamsSurvivableBranchAppliance $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if ($PSCmdlet.ShouldProcess($($item.identity), "Remove CsTeamsSurvivableBranchAppliance")) {
                Remove-CsTeamsSurvivableBranchAppliance -identity $item.identity -ErrorAction Stop 
                Write-Information -messageData  "Removed $($item.identity) Survivable Branch Appliance" -informationaction continue
            }
        }
        catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items, item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}