# DOC Documentation invoke-teamsPhonePolicy
Function Invoke-TeamsPhonePolicy {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualPhonePolicy]]$VirtualIpPhonePolicy
    )

    Begin { }
    Process {
        foreach ($Item in $VirtualIpPhonePolicy) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.identity)
                $params.Add("AllowBetterTogether", $Item.allowbettertogether)
                $params.Add("AllowHomeScreen", $Item.AllowHomeScreen)
                $params.Add("AllowHotDesking", $Item.AllowHotDesking)
                $params.Add("HotDeskingIdleTimeoutInMinutes", $Item.HotDeskingIdleTimeoutInMinutes)
                $params.Add("SearchOnCommonAreaPhoneMode", $Item.SearchOnCommonAreaPhoneMode)
                $params.Add("SignInMode", $Item.SignInMode)
                $params.Add("Description", $Item.Description)

                $PhonePolicy = Get-CsTeamsIPPhonePolicy -Identity $Item.identity -ErrorAction SilentlyContinue

                if ($PhonePolicy.Count -eq 1) {
                    if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating")) { Set-CsTeamsIPPhonePolicy @params -ErrorAction Stop }
                }
                elseif ($PhonePolicy.Count -eq 0) {
                    if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating")) { New-CsTeamsIPPhonePolicy @params -ErrorAction Stop }
                }
                else {
                    Write-TeamsToolsError -Message "Unknown PhonePolicy for $($Item.identity)" -Exception (New-Object System.Exception -ArgumentList "Unknown PhonePolicy")
                }
            }
            catch {
                Write-TeamsToolsError -Message "[Error] $($Item.identity) -> $($_.exception.message)" -Exception $_.Exception
            }
        }
    }
    End {}
}
