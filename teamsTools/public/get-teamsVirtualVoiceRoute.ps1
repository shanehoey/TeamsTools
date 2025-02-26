# DOC Documentation get-teamsVirtualVoiceRoute
Function get-teamsVirtualVoiceRoute {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.VoiceRoute | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
