 <#
.SYNOPSIS
Removes Teams configuration for a specified domain.

.DESCRIPTION
The remove-teamsToolsConfig function removes all Teams configuration settings for a specified domain. 
It supports the -clean switch to remove all configurations and the -skipusers switch to skip user removal.

.PARAMETER clean
Optional switch to indicate if all Teams configuration should be removed.

.PARAMETER domainname
Mandatory parameter specifying the domain name for which Teams configuration should be removed.
Mandatory parameter specifying the domain name for which Teams configuration should be removed.

.PARAMETER skipusers
Optional switch to indicate if user removal should be skipped.

.EXAMPLE
remove-teamsToolsConfig -domainname "shanehoey.dev" -clean

This command removes all Teams configuration for the tenant. "shanehoey.dev".

.EXAMPLE
remove-teamsToolsConfig -domainname "shanehoey.dev" -clean -skipusers

This command removes all Teams configuration for the domain "shanehoey.dev" but skips user removal.

.NOTES
Ensure you have the necessary permissions to run this script and modify Teams configurations.
#>
function remove-teamsToolsConfig {
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact = "HIGH")]
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
