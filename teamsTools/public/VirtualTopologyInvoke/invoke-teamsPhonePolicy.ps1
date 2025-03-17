# DOC Documentation invoke-teamsPhonePolicy

Function invoke-teamsPhonePolicy {
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
                $params.Add("Identity",$Item.identity)
                $params.Add("AllowBetterTogether",$Item.allowbettertogether)
                $params.Add("AllowHomeScreen",$Item.AllowHomeScreen)
                $params.Add("AllowHotDesking", $Item.AllowHotDesking)
                $params.Add("HotDeskingIdleTimeoutInMinutes", $Item.HotDeskingIdleTimeoutInMinutes)
                $params.Add("SearchOnCommonAreaPhoneMode", $Item.SearchOnCommonAreaPhoneMode)
                $params.Add("SignInMode", $Item.SignInMode)
                $params.Add("Description", $Item.Description)

                $PhonePolicy = get-CsTeamsIPPhonePolicy -identity $Item.identity -erroraction silentlycontinue

                if ($PhonePolicy.count -eq 1) {
                    if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating")) { Set-CsTeamsIPPhonePolicy @params -ErrorAction Stop }
                }
                elseif ($PhonePolicy.count -eq 0) {
                    if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating")) { new-CsTeamsIPPhonePolicy @params -ErrorAction Stop }
                }
                else {
                    throw "Unknown PhonePolicy for $($Item.identity)"
                }Function invoke-teamsPhonePolicy {
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
                                $params.Add("Identity",$Item.identity)
                                $params.Add("AllowBetterTogether",$Item.allowbettertogether)
                                $params.Add("AllowHomeScreen",$Item.AllowHomeScreen)
                                $params.Add("AllowHotDesking", $Item.AllowHotDesking)
                                $params.Add("HotDeskingIdleTimeoutInMinutes", $Item.HotDeskingIdleTimeoutInMinutes)
                                $params.Add("SearchOnCommonAreaPhoneMode", $Item.SearchOnCommonAreaPhoneMode)
                                $params.Add("SignInMode", $Item.SignInMode)
                                $params.Add("Description", $Item.Description)
                
                                $PhonePolicy = get-CsTeamsIPPhonePolicy -identity $Item.identity -erroraction silentlycontinue
                
                                if ($PhonePolicy.count -eq 1) {
                                    if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating")) { Set-CsTeamsIPPhonePolicy @params -ErrorAction Stop }
                                }
                                elseif ($PhonePolicy.count -eq 0) {
                                    if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating")) { new-CsTeamsIPPhonePolicy @params -ErrorAction Stop }
                                }
                                else {
                                    throw "Unknown PhonePolicy for $($Item.identity)"
                                }
                            }
                            catch {
                                write-warning "[Error] $identity -> $($_.exception.message)"
                            }   
                        }
                    }
                    End {}
                }
                
            }
            catch {
                write-warning "[Error] $identity -> $($_.exception.message)"
            }   
        }
    }
    End {}
}
