# DOC Documentation add-teamsVirtualVoiceNormalisation
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualVoiceNormalisation {
    [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName='default', ConfirmImpact = 'Low')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName='default')]
        [ValidateNotNullOrEmpty()]
        [string] $Identity,
        [Parameter(Mandatory = $true, ParameterSetName='parent')]
        [ValidateNotNullOrEmpty()]
        [string] $Parent,
        [Parameter(Mandatory = $true, ParameterSetName='parent')]
        [ValidateNotNullOrEmpty()]
        [string] $Name,
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
        
        # THIS IS BROKE when using IDENTITY 
        if ($script:VirtualTopology.VoiceNormalisationRule.Identity -contains $parent) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        if ($PSCmdlet.ShouldProcess("VirtualTopology VoiceNormalisation","Add $($Name ?? $Identity)")) {
            if ($PSCmdlet.ParameterSetName -eq 'parent') {
                $Item = [VirtualVoiceNormalisation]::new($Parent,$Name,$Pattern,$Translation)
            } else {
                $Item = [VirtualVoiceNormalisation]::new($Identity,$Pattern,$Translation)
            }

            if ($isinternalextension){$item.isinternalextension = $isinternalextension}
            if ($Priority){$item.Priority = $Priority}
            if ($Description){$item.Description = $Description}

            $script:VirtualTopology.VoiceNormalisation.Add($Item)
        } else {
            Write-Verbose "Skipping add of VoiceNormalisation for $($Name ?? $Identity) (ShouldProcess declined or -WhatIf)."
        }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

