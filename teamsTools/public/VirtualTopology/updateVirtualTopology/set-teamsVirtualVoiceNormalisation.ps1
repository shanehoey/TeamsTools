# DOC Documentation set-teamsVirtualVoiceNormalisation
# IMPROVEMENT Add support for SupportsShouldProcess

Function set-teamsVirtualVoiceNormalisation {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
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

        $Item = $script:VirtualTopology.VoiceNormalisation | where-object {$_.Identity -eq $Identity}
        $Item.Pattern = $Pattern
        $Item.Translation = $Translation
        $Item.isinternalextension = $isinternalextension
        $Item.Priority = $Priority
        $Item.Description = $Description

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

