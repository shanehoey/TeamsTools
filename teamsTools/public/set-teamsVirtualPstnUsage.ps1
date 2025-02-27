
Function set-teamsVirtualPstnUsage {
# IMPROVEMENT Add support for SupportsShouldProcess

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    $PstnUsage
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.PstnUsage.PstnUsage -notcontains $PstnUsage) {
            throw "PstnUsage $PstnUsage not found in VirtualTopology."
        }

        $Item = $script:VirtualTopology.PstnUsage | where-object {$_.PstnUsage -eq $PstnUsage}
        $script:VirtualTopology.PstnUsage.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }

}