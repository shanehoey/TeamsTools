# DOC Documentation get-teamsvirtualPSTNGateway
# IMPROVEMENT Add support for SupportsShouldProcess

Function get-teamsVirtualPSTNGateway {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string]$Identity = "*"
    )
    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.PSTNGateway | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
