# DOC Documentation add-teamsVirtualVoiceNormalisation
Function add-teamsVirtualVoiceNormalisation {

    [CmdletBinding(DefaultParameterSetName='default')]
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

        if ($PSCmdlet.ParameterSetName -eq 'parent') {
            $Item = [VirtualVoiceNormalisation]::new($Parent,$Name,$Pattern,$Translation)
        } else {
            $Item = [VirtualVoiceNormalisation]::new($Identity,$Pattern,$Translation)
        }

        if ($isinternalextension){$item.isinternalextension = $isinternalextension}
        if ($Priority){$item.Priority = $Priority}
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.VoiceNormalisation.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

