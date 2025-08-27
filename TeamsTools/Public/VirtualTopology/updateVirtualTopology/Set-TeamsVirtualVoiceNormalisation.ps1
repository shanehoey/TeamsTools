# DOC Documentation set-teamsVirtualVoiceNormalisation
# IMPROVEMENT Add support for SupportsShouldProcess
Function Set-TeamsVirtualVoiceNormalisation {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory = $false)]
        [string] $Identity = "*",
        [ValidateNotNullOrEmpty()][string] $Pattern,
        [ValidateNotNullOrEmpty()][string] $Translation,
        [string] $isinternalextension,
        [string] $Priority =1,
        [string] $Description
    )

    try {

        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }
        
        if ($script:VirtualTopology.VoiceNormalisationRule.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        if ($PSCmdlet.ShouldProcess("VirtualTopology VoiceNormalisation '$Identity'","Update")) {
            $Item = $script:VirtualTopology.VoiceNormalisation | where-object {$_.Identity -eq $Identity}
            $Item.Pattern = $Pattern
            $Item.Translation = $Translation
            $Item.isinternalextension = $isinternalextension
            $Item.Priority = $Priority
            $Item.Description = $Description
        } else {
            Write-Verbose "Skipping update of VoiceNormalisation '$Identity' (ShouldProcess declined or -WhatIf)."
        }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

