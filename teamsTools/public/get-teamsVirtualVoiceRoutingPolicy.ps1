# DOC Documentation get-teamsVirtualVoiceRoutingPolicy
# TODO Add support for SupportsShouldProcess

Function get-teamsVirtualVoiceRoutingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.VoiceRoutingPolicy | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

