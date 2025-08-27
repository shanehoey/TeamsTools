# DOC Documentation get-teamsVirtualVoiceRoutingPolicy
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualVoiceRoutingPolicy {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (

    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if (-not $PSCmdlet.ShouldProcess("VirtualTopology VoiceRoutingPolicy", "Retrieve items matching '$Identity'")) {
            Write-Verbose "Skipping retrieval of VoiceRoutingPolicy matching '$Identity' (ShouldProcess declined)."
            return
        }

        $Item = $script:VirtualTopology.VoiceRoutingPolicy | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

