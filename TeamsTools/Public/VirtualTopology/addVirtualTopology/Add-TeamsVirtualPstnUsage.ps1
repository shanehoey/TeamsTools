# DOC Documentation Function add-teamsVirtualPstnUsage
# IMPROVEMENT Add support for SupportsShouldProcess

Function Add-TeamsVirtualPstnUsage {
    
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
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

        if ($PSCmdlet.ShouldProcess("VirtualTopology PstnUsage '$PstnUsage'","Add")) {
            $Item = [VirtualPstnUsage]::new($PstnUsage)
            $script:VirtualTopology.PstnUsage.Add($Item)
        } else {
            Write-Verbose "Skipping add of PstnUsage '$PstnUsage' (ShouldProcess declined or -WhatIf)."
        }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }

}