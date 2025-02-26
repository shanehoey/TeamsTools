# DOC Documentation set-teamsVirtualUser
# TODO Add support for SupportsShouldProcess

Function set-teamsVirtualUser {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity, #EmergencyCallRoutingPolicy
    [string] $VoiceRoutingPolicy,
    [string] $Telephonenumber,
    [string] $TelephoneNumberType = "DirectRouting",
    [Boolean] $EnterpriseVoiceEnabled = $true, 
    [string] $DialPlan,
    [String] $PhonePolicy,
    [String] $EmergencyCallingPolicy,
    [String] $EmergencyCallRoutingPolicy,    
    [string] $UsageLocation,
    [String] $DialOutPolicy,
    [String] $CallingIDPolicy,
    [String] $CallHoldPolicy,
    [String] $CallParkPolicy,
    [String] $CallingLineIdentityPolicy,
    [String] $TeamsMobilityPolicy,
    [String] $VoicemailPolicy,
    [String] $SurvivableBranchAppliancePolicy

    )

    try {

        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.User.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        if ($PSBoundParameters.ContainsKey('VoiceRoutingPolicy')){
            If ($script:VirtualTopology.VoiceRoutingPolicy.Identity -notcontains $VoiceRoutingPolicy) {
                throw "VoiceRoutingPolicy $VoiceRoutingPolicy not found in VirtualTopology."
            }
        }

        $Item = $script:VirtualTopology.User | where-object {$_.Identity -eq $Identity}

        if ($VoiceRoutingPolicy){$item.VoiceRoutingPolicy = $VoiceRoutingPolicy}
        if ($Telephonenumber){$item.Telephonenumber = $Telephonenumber}
        if ($TelephoneNumberType){$item.TelephoneNumberType = $TelephoneNumberType}
        if ($EnterpriseVoiceEnabled){$item.EnterpriseVoiceEnabled = $EnterpriseVoiceEnabled}
        if ($DialPlan){$item.DialPlan = $DialPlan}
        if ($PhonePolicy){$item.PhonePolicy = $PhonePolicy}
        if ($EmergencyCallingPolicy){$item.EmergencyCallingPolicy = $EmergencyCallingPolicy}
        if ($EmergencyCallRoutingPolicy){$item.EmergencyCallRoutingPolicy = $EmergencyCallRoutingPolicy}
        if ($UsageLocation){$item.UsageLocation = $UsageLocation}
        if ($DialOutPolicy){$item.DialOutPolicy = $DialOutPolicy}
        if ($CallingIDPolicy){$item.CallingIDPolicy = $CallingIDPolicy}
        if ($CallHoldPolicy){$item.CallHoldPolicy = $CallHoldPolicy}
        if ($CallParkPolicy){$item.CallParkPolicy = $CallParkPolicy}
        if ($CallingLineIdentityPolicy){$item.CallingLineIdentityPolicy = $CallingLineIdentityPolicy}
        if ($TeamsMobilityPolicy){$item.TeamsMobilityPolicy = $TeamsMobilityPolicy}
        if ($VoicemailPolicy){$item.VoicemailPolicy = $VoicemailPolicy}
        if ($SurvivableBranchAppliancePolicy){$item.SurvivableBranchAppliancePolicy = $SurvivableBranchAppliancePolicy}
    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

