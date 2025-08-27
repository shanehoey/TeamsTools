# DOC Documentation get-teamsVirtualVoiceNormalisation
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualVoiceNormalisation {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
    [string] $Identity = "*",
    [string] $Pattern = "*",
    [string] $Translation = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if (-not $PSCmdlet.ShouldProcess("VirtualTopology VoiceNormalisation", "Retrieve items matching '$Identity/$Pattern/$Translation'")) {
            Write-Verbose "Skipping retrieval of VoiceNormalisation matching '$Identity/$Pattern/$Translation' (ShouldProcess declined)."
            return
        }

        $Item = $script:VirtualTopology.VoiceNormalisation | where-object {$_.Identity -like $Identity -and $_.Pattern -like $Pattern -and $_.Translation -like $Translation}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

