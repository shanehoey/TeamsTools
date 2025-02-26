# DOC Documentation Function add-teamsVirtualPstnUsage
# TODO Add support for SupportsShouldProcess


Function add-teamsVirtualPstnUsage {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    $PstnUsage
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.PstnUsage.PstnUsage -contains $PstnUsage) {
            throw "PstnUsage $PstnUsage exists in VirtualTopology."
        }

        $Item = [VirtualPstnUsage]::new($PstnUsage)
        $script:VirtualTopology.PstnUsage.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }

}