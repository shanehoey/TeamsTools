# DOC Documentation initialize-teamsteamsVirtualPhonePolicy
# INVESTIGATE  should these function do any cross checking or just create the new object ? 

Function initialize-teamsVirtualPhonePolicy {

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

        $Item = [VirtualPhonePolicy]::new($Identity)
        if ($AllowBetterTogether){$item.AllowBetterTogether = $AllowBetterTogether}
        if ($AllowHomeScreen){$item.AllowHomeScreen = $AllowHomeScreen}
        if ($AllowHotDesking){$item.AllowHotDesking = $AllowHotDesking}
        if ($HotDeskingIdleTimeoutInMinutes){$item.HotDeskingIdleTimeoutInMinutes = $HotDeskingIdleTimeoutInMinutes}
        if ($SearchOnCommonAreaPhoneMode){$item.SearchOnCommonAreaPhoneMode = $SearchOnCommonAreaPhoneMode}
        if ($SignInMode){$item.SignInMode = $SignInMode}
        if ($Description){$item.Description = $Description}

        return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}


