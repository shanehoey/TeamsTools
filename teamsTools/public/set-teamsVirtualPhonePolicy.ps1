# DOC Documentation set-teamsVirtualPhonePolicy
# TODO Add support for SupportsShouldProcess

Function set-teamsVirtualPhonePolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
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

        if ($script:VirtualTopology.PhonePolicy.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        $Item = $script:VirtualTopology.PhonePolicy | where-object {$_.Identity -eq $Identity}
        if ($AllowBetterTogether){$item.AllowBetterTogether = $AllowBetterTogether}
        if ($AllowHomeScreen){$item.AllowHomeScreen = $AllowHomeScreen}
        if ($AllowHotDesking){$item.AllowHotDesking = $AllowHotDesking}
        if ($HotDeskingIdleTimeoutInMinutes){$item.HotDeskingIdleTimeoutInMinutes = $HotDeskingIdleTimeoutInMinutes}
        if ($SearchOnCommonAreaPhoneMode){$item.SearchOnCommonAreaPhoneMode = $SearchOnCommonAreaPhoneMode}
        if ($SignInMode){$item.SignInMode = $SignInMode}
        if ($Description){$item.Description = $Description}

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

