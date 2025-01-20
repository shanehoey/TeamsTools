
# TeamsTools
# https://github.com/shanehoey/TeamsTools

# clean-bulkteamsconfig
function remove-teamstoolsconfig {

    [CmdletBinding(SupportsShouldProcess)]
    param(
      [switch]$clean = $false,
      [Parameter(Mandatory=$true)]
      [string]$domainname,
      [switch]$skipusers 
      )
 
    if(get-cstenant | Where-Object {$_.SipDomain -eq $domainname}) {

    If ($PSBoundParameters.ContainsKey('clean'))
    { 
        write-warning -Message "This script will remove all Teams Configuration from $domainname" -WarningAction Continue
        
        $params = @{
            whatif   = ($PSBoundParameters.ContainsKey('whatif'))
            confirm  = ($PSBoundParameters.ContainsKey('confirm'))
        }
        
      if(!($skipusers)){remove-teamstoolsusers @params}
      if(!($skipusers)){remove-teamstoolsusers @params}
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
    else 
    {
      write-warning "Correct Parameter's where not used" -WarningAction Continue
    }
} else {

    write-warning "Domain $domainname did not match domain in your tenant" -WarningAction Continue
 

}
    }

# remove-teamstoolsusers
function remove-teamstoolsusers {
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
param()

    try { $items = get-csonlineuser -erroraction SilentlyContinue } catch { write-warning "[Error] get-csonlineusers $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if($item.EnterpriseVoiceEnabled) {
            if($PSCmdlet.ShouldProcess($($item.sipaddress),"Remove Voice Configuration")) {
                
                if($item.lineuri) { Grant-CsOnlineVoiceRoutingPolicy -identity $item.identity -PolicyName $null -ErrorAction Stop }
                if($item.OnlineVoiceRoutingPolicy) { Remove-CsPhoneNumberAssignment -identity $item.identity -RemoveAll -ErrorAction Stop } 
                if($item.TenantDialPlan) { Grant-CsTenantDialPlan -Identity $item.identity -PolicyName $null -ErrorAction Stop  }
   
                write-information -MessageData "Removed $($item.sipaddress) Voice Configuration" -informationaction continue
                }
            }
        } catch {
            write-error -message "$($item.sipaddress) $($error[0].exception.message)" -CategoryActivity "Error"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false
}

# remove-teamstoolsOnlineVoiceRoutingPolicy
function remove-teamstoolsOnlineVoiceRoutingPolicy {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsOnlineVoiceRoutingPolicy -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsOnlineVoiceRoutingPolicy $($error[0].exception.message)" }
    foreach ($item in $items) {
        try { 
            if( $PSCmdlet.ShouldProcess($($item.identity),"Remove csOnlineVoiceRoutingPolicy" )) 
            {
                 Remove-CsOnlineVoiceRoutingPolicy -identity $($item.identity) -ErrorAction Stop
                 write-information -MessageData "Removed $($item.identity) online voice routing policy" -informationaction continue
            }
        } catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        } 
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false
}

# remove-teamstoolsOnlineVoiceRoute
function remove-teamstoolsOnlineVoiceRoute {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsOnlineVoiceRoute -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsOnlineVoiceRoute $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
             if($PSCmdlet.ShouldProcess($($item.identity),"Remove CsOnlineVoiceRoute")) { 
                Remove-CsOnlineVoiceRoute -identity $item.identity -ErrorAction Stop
                Write-Information -messageData  "Removed $($item.identity) online voice route" -informationaction continue 
                
            }
        } catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false
}

# remove-teamstoolsOnlinePSTNGateway
function remove-teamstoolsOnlinePSTNGateway{
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsOnlinePSTNGateway -erroraction SilentlyContinue | sort-object ProxySBC -Descending   } catch { write-warning "[Error] Get-CsOnlinePSTNGateway $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
             if($PSCmdlet.ShouldProcess($($item.identity),"Remove CsOnlinePSTNGateway")) { 
                Remove-CsOnlinePSTNGateway -identity $item.identity -ErrorAction Stop
                Write-Information -messageData  "Removed $($item.identity) Online PSTN Gateway" -informationaction continue
            }
        } catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false
}

# remove-teamstoolsOnlinePstnUsage
function remove-teamstoolsOnlinePstnUsage {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsOnlinePstnUsage -erroraction silentlycontinue } catch { write-warning "[Error] Get-CsOnlinePstnUsage $($error[0].exception.message)" }
    foreach ($item in $items.usage) {
        try {
            if($PSCmdlet.ShouldProcess($($item.identity),"Remove CsOnlinePstnUsage")) {
                Set-CsOnlinePstnUsage -Identity global -Usage @{ Remove=$($item)} -ErrorAction Stop
                Write-Information -messageData  "Removed $($item) online PStn Usage" -informationaction continue
                 }
        } catch {
            write-warning "[Error] $($item) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}

# remove-teamstoolsTenantTrustedIPAddress
function remove-teamstoolsTenantTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsTenantTrustedIPAddress -erroraction silentlycontinue } catch { write-warning "[Error] Get-CsTenantTrustedIPAddress $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if($PSCmdlet.ShouldProcess($($item.identity),"Remove CsTenantTrustedIPAddress ")) {
                Remove-CsTenantTrustedIPAddress -identity $item.identity -erroraction Stop 
                Write-Information -messageData  "Removed $($item.identity) Tenant Trusted IP Address" -informationaction continue
                }
        } catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}

# remove-teamstoolsTenantNetworkSubnet
function remove-teamstoolsTenantNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsTenantNetworkSubnet -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsTenantNetworkSubnet $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if($PSCmdlet.ShouldProcess($($item.identity),"Remove Voice Configuration")) { 
                Remove-CsTenantNetworkSubnet -identity $($item.identity) -erroraction Stop 
                Write-Information -messageData  "Removed $($item.identity) Tenant Network Subnet" -informationaction continue
            }
        } catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}

# remove-teamstoolsTenantNetworkSite
function remove-teamstoolsTenantNetworkSite {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsTenantNetworkSite -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsTenantNetworkSite $($error[0].exception.message)" }
    foreach ($item in $items) {
    try {
        if($PSCmdlet.ShouldProcess($($item.identity),"Remove Voice Configuration")) { 
            Remove-CsTenantNetworkSite -identity $item.identity -ErrorAction Stop 
            Write-Information -messageData  "Removed $($item.identity) Tenant Network Site" -informationaction continue
        }
    } catch {
        write-warning "[Error] $($item.identity) $($error[0].exception.message)"
    }

    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false

    }
}

# remove-teamstoolsTenantNetworkRegion
function remove-teamstoolsTenantNetworkRegion {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()


    try { $items = Get-CsTenantNetworkRegion -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsTenantNetworkRegion $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if($PSCmdlet.ShouldProcess($($item.identity),"Remove Voice Configuration")) {
                Remove-CsTenantNetworkRegion -identity $item.identity -ErrorAction Stop
                Write-Information -messageData  "Removed $($item.identity) Tenant Network Region" -informationaction continue
            }
        } catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}

# remove-teamstoolsTenantDialPlan
function remove-teamstoolsTenantDialPlan {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsTenantDialPlan -erroraction SilentlyContinue } catch { write-warning "[Error] Get-CsTenantDialPlan $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if($PSCmdlet.ShouldProcess($($item.identity),"Remove CsTenantDialPlan")) {
                Remove-CsTenantDialPlan -identity $item.identity -ErrorAction Stop 
                Write-Information -messageData  "Removed $($item.identity) Tenant Dial Plan" -informationaction continue
            }
        } catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}

# remove-teamstoolsSurvivableBranchAppliancePolicy
function remove-teamstoolsSurvivableBranchAppliancePolicy {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsTeamsSurvivableBranchAppliancePolicy -erroraction SilentlyContinue } catch { write-warning "[Error] get-CsTeamsSurvivableBranchAppliancePolicy $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if($PSCmdlet.ShouldProcess($($item.identity),"Remove CsTeamsSurvivableBranchAppliancePolicy")) {
                Remove-CsTeamsSurvivableBranchAppliancePolicy -identity $item.identity -ErrorAction Stop 
                Write-Information -messageData  "Removed $($item.identity) Survivable Branch Appliance Policy" -informationaction continue
            }
        } catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}

# remove-teamstoolsSurvivableBranchAppliance
function remove-teamstoolsSurvivableBranchAppliance {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="HIGH")]
    param()

    try { $items = Get-CsTeamsSurvivableBranchAppliance -erroraction SilentlyContinue } catch { write-warning "[Error] get-CsTeamsSurvivableBranchAppliance $($error[0].exception.message)" }
    foreach ($item in $items) {
        try {
            if($PSCmdlet.ShouldProcess($($item.identity),"Remove CsTeamsSurvivableBranchAppliance")) {
                Remove-CsTeamsSurvivableBranchAppliance -identity $item.identity -ErrorAction Stop 
                Write-Information -messageData  "Removed $($item.identity) Survivable Branch Appliance" -informationaction continue
            }
        } catch {
            write-warning "[Error] $($item.identity) $($error[0].exception.message)"
        }
    }
    Remove-Variable -name items,item -erroraction SilentlyContinue -confirm:$false -whatif:$false

}