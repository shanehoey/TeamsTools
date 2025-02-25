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

Function set-teamsVirtualPstnUsage {

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

Function get-teamsVirtualPstnUsage {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param()
    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.PSTNUsage
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

