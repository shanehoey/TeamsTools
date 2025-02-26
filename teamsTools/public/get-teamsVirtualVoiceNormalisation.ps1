# DOC Documentation get-teamsVirtualVoiceNormalisation
Function get-teamsVirtualVoiceNormalisation {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string] $Identity = "*",
    [string] $Pattern = "*",
    [string] $Translation = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.VoiceNormalisation | where-object {$_.Identity -like $Identity -and $_.Pattern -like $Pattern -and $_.Translation -like $Translation}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

