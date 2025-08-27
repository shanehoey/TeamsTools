# DOC Documentation add-teamsVirtualPhonePolicy
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualPhonePolicy {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [AllowBetterTogether] $AllowBetterTogether,
    [AllowHomeScreen] $AllowHomeScreen,
    [Boolean] $AllowHotDesking,
    [String] $HotDeskingIdleTimeoutInMinutes,	
    [String] $SearchOnCommonAreaPhoneMode,
    [SignInMode] $SignInMode,
    [String] $Description

    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.PhonePolicy.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        if ($PSCmdlet.ShouldProcess("VirtualTopology PhonePolicy '$Identity'","Add")) {
            $Item = [VirtualPhonePolicy]::new($Identity)
            if ($AllowBetterTogether){$item.AllowBetterTogether = $AllowBetterTogether}
            if ($AllowHomeScreen){$item.AllowHomeScreen = $AllowHomeScreen}
            if ($AllowHotDesking){$item.AllowHotDesking = $AllowHotDesking}
            if ($HotDeskingIdleTimeoutInMinutes){$item.HotDeskingIdleTimeoutInMinutes = $HotDeskingIdleTimeoutInMinutes}
            if ($SearchOnCommonAreaPhoneMode){$item.SearchOnCommonAreaPhoneMode = $SearchOnCommonAreaPhoneMode}
            if ($SignInMode){$item.SignInMode = $SignInMode}
            if ($Description){$item.Description = $Description}

            $script:VirtualTopology.PhonePolicy.Add($Item)
        } else {
            Write-Verbose "Skipping add of PhonePolicy '$Identity' (ShouldProcess declined or -WhatIf)."
        }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}


