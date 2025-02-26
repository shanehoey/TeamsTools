<#
.SYNOPSIS
Removes all Online PSTN Gateways in Microsoft Teams.

.DESCRIPTION
The remove-teamsToolsOnlinePSTNGateway function retrieves all Online PSTN Gateways, sorts them in descending order by ProxySBC, and removes each one after confirming with the user. It logs the removal of each gateway and handles any errors that occur during the process.

.PARAMETERS
This function does not take any parameters.

.EXAMPLES
.EXAMPLE
remove-teamsToolsOnlinePSTNGateway

This example removes all Online PSTN Gateways after user confirmation.

.NOTES
This function requires the Teams PowerShell module to be installed and connected to the appropriate Teams environment.

#>
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
