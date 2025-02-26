# DOC Documentation get-teamsvirtualphonepstnusage
# TODO Add support for SupportsShouldProcess



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

