function remove-teamsToolsConfig {

    [CmdletBinding(SupportsShouldProcesss, ConfirmImpact = "HIGH")]
    param(
        [switch]$clean = $false,
        [Parameter(Mandatory = $true)]
        [string]$domainname,
        [switch]$skipusers 
    )
 
    if (get-cstenant | Where-Object { $_.SipDomain -eq $domainname }) {

        If ($PSBoundParameters.ContainsKey('clean')) { 
            write-warning -Message "This script will remove all Teams Configuration from $domainname" -WarningAction Continue
        
            $params = @{
                whatif  = ($PSBoundParameters.ContainsKey('whatif'))
                confirm = ($PSBoundParameters.ContainsKey('confirm'))
            }
        
            if (!($skipusers)) { remove-teamstoolsusers @params }
            if (!($skipusers)) { remove-teamstoolsusers @params }
            remove-teamstoolsOnlineVoiceRoutingPolicy @params
            remove-teamstoolsOnlineVoiceRoute @params
            remove-teamstoolsOnlinePstnUsage @params
            remove-teamstoolsOnlinePSTNGateway @params
            remove-teamstoolsTenantDialPlan @params
            remove-teamstoolsTenantTrustedIPAddress @params
            remove-teamstoolsTenantNetworkSubnet @params
            remove-teamstoolsTenantNetworkSite @params
            remove-teamstoolsTenantNetworkRegion @params 
            remove-teamstoolsSurvivableBranchAppliancePolicy @params
            remove-teamstoolsSurvivableBranchAppliance @params
            write-information "All Teams Configuration has been removed" -informationaction continue 
        }
        else {
            write-warning "Correct Parameter's where not used" -WarningAction Continue
        }
    }
    else {

        write-warning "Domain $domainname did not match domain in your tenant" -WarningAction Continue
 

    }
}
