# DOC Documentation initialize-teamsVirtualUser
Function initialize-teamsVirtualUser {

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

        $Item = [VirtualUser]::new($Identity)
        
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
        
        return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

