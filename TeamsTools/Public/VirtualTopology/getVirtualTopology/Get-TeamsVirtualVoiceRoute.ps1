# DOC Documentation get-teamsVirtualVoiceRoute
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualVoiceRoute {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if (-not $PSCmdlet.ShouldProcess("VirtualTopology VoiceRoute", "Retrieve items matching '$Identity'")) {
            Write-Verbose "Skipping retrieval of VoiceRoute matching '$Identity' (ShouldProcess declined)."
            return
        }

        $Item = $script:VirtualTopology.VoiceRoute | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
