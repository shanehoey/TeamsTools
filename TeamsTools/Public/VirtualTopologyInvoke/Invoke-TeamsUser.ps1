<#
.SYNOPSIS
    This function processes a list of virtual users and updates their Teams settings based on specified parameters.

.DESCRIPTION
    The Invoke-TeamsUser function takes a list of virtual users and performs various checks and updates on their Teams settings.
    It verifies user properties such as PhoneSystem, UsageLocation, OnPremHostingProvider, InterpretedUserType, OnPremLineUri, OnPremSIPEnabled, and TeamsUpgradeEffectiveMode.
    If necessary, it updates the user's PhoneNumberAssignment, OnlineVoiceRoutingPolicy, Dialoutpolicy, TenantDialPlan, and TeamsSurvivableBranchAppliancePolicy.

.PARAMETER VirtualUser
    A list of virtual users to be processed. Each user should have properties such as Identity, telephonenumber, VoiceRoutingPolicy, onlineDialOutPolicy, DialPlan, and SurvivableBranchAppliancePolicy.

.EXAMPLE
    $virtualUsers = Get-VirtualUsers
    $virtualUsers | Invoke-TeamsUser

.NOTES
    This function requires the Teams PowerShell module to be installed and imported.
    It uses the ShouldProcess method to support -WhatIf and -Confirm parameters for safe execution.

#>
Function Invoke-TeamsUser {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [Alias("Invoke-Teamsdevice")]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualUser]]$VirtualUser
    )
       
    Begin { }
    Process {    
        foreach ($Item in $VirtualUser) {      
            try {

                $user = get-csonlineuser -identity $Item.Identity -ErrorAction silentlycontinue

                if ($user.count -eq 1 ) {

                    if ($user.featureTypes -notcontains "PhoneSystem" ) { Write-warning -message "[Warning] $($Item.Identity) does not have PhoneSystem" -ErrorAction continue }
                    if ($user.UsageLocation -ne $Item.UsageLocation) { Write-warning -message "[Warning] $($Item.Identity) Location is $($user.UsageLocation) should be $($Item.UsageLocation)" -ErrorAction continue }
                    if ($user.OnPremHostingProvider -eq "SRV:") { Write-warning -message "[Warning] $($Item.Identity) OnPremHostingProvider is $($user.OnPremHostingProvider)" -ErrorAction continue }   
                    if (($user.InterpretedUserType -ne "HybridOnlineTeamsOnlyUser") -and  ($user.InterpretedUserType -ne "PureOnlineTeamsOnlyUser")) { Write-warning -message "[Warning] $($Item.Identity) InterpretedUserType is $($user.InterpretedUserType)" -ErrorAction continue }   
                    if ($user.OnPremLineUri) { Write-warning -message "[Warning] $($Item.Identity) OnPremLineUri is $($user.OnPremLineUri)" -ErrorAction continue }
                    if ($user.OnPremSIPEnabled) { Write-warning -message "[Warning] $($Item.Identity) OnPremLineUri is $($user.OnPremSIPEnabled)" -ErrorAction continue }
                    if ($user.TeamsUpgradeEffectiveMode -ne "TeamsOnly") { Write-warning -message "[Warning] $($item.Identity) is $($user.TeamsUpgradeEffectiveMode)" }
                    
                    try { 
                        # TODO: need to add what to do on empty values
                        if ($Item.telephonenumber -ne $null) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating PhoneNumberAssignment")){Set-CsPhoneNumberAssignment -Identity $user.Identity -PhoneNumber $Item.telephonenumber -PhoneNumberType DirectRouting -erroraction Inquire }}
                        if ($Item.VoiceRoutingPolicy -ne $null) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating OnlineVoiceRoutingPolicy")){Grant-CsOnlineVoiceRoutingPolicy -Identity $user.Identity -PolicyName $($Item.VoiceRoutingPolicy) -erroraction Inquire }}
                        if ($Item.onlineDialOutPolicy -ne $null) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating Dialoutpolicy")){ Grant-csDialoutpolicy -Identity $user.Identity -policyname $Item.onlineDialOutPolicy -erroraction Inquire }}
                        if ($Item.DialPlan -ne $null) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating TenantDialPlan")){ Grant-CsTenantDialPlan -identity $user.Identity -PolicyName $Item.DialPlan -erroraction Inquire }}
                        if ($Item.SurvivableBranchAppliancePolicy -ne $null) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating TeamsSurvivableBranchAppliancePolicy")){ Grant-CsTeamsSurvivableBranchAppliancePolicy -identity $user.Identity -PolicyName $Item.SurvivableBranchAppliancePolicy -erroraction Inquire} else { Grant-CsTeamsSurvivableBranchAppliancePolicy -identity $user.Identity -PolicyName $null} }
                        
                    } catch {
                            Write-warning -message "[Warning] $($item.Identity) $($_.exception.message)" -ErrorAction continue }
                } else { Throw "Unknown User for $($Item.Identity)"}

            } catch {
                Write-warning -message "[Error] $($Item.sipaddress) $($_.exception.message)" -ErrorAction continue
            }
        }
    }
    End {}
}