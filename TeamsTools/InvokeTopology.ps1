# TeamsToolsCreating
# https://github.com/shanehoey/TeamsTools


# Invoke-TeamsNetworkRegion
Function Invoke-TeamsNetworkRegion {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualNetworkRegion]]$VirtualNetworkRegion
    )
    Begin { }
    Process { 
        foreach ($Item in $VirtualNetworkRegion) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.NetworkRegionId)
                if($item.Description){$params.Add("Description", $Item.Description)}
                $NetworkRegion = Get-CsTenantNetworkRegion -Identity $($Item.NetworkRegionId) -ErrorAction SilentlyContinue 
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$NetworkRegion} | Convertto-json -depth 10)
                if ($NetworkRegion.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.NetworkRegionId)", "Updating TenantNetworkRegion")) { Set-csTenantNetworkRegion @params -ErrorAction Stop }}
                elseif ($NetworkRegion.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.NetworkRegionId)", "Creating TenantNetworkRegion")) { New-cstenantnetworkregion @params -ErrorAction Stop }}
                else { throw "Unknown Network Region for $($Item.NetworkRegionId)" }}
            catch { write-warning -Message "[Error] $($Item.networkregionid) -> $($_.exception.message)" } 
        }
    }
    end { }
}

# Invoke-TeamsNetworkSite
Function Invoke-TeamsNetworkSite {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (    
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualNetworkSite]]$VirtualNetworkSite
    )
 
    Begin { }
    Process {
        foreach ($Item in $VirtualNetworkSite) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.NetworkSiteId)
                $params.Add("NetworkRegionID", $Item.NetworkRegionId)
                if($item.Description){$params.Add("Description", $Item.Description)}
                $NetworkSiteID = Get-CsTenantNetworkSite -Identity $($Item.NetworkSiteId) -ErrorAction SilentlyContinue
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$NetworkSiteID} | Convertto-json -depth 10)
                if ($NetworkSiteID.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.NetworkSiteId)", "Updating TenantNetworkSite")) { set-CsTenantNetworkSite @params -ErrorAction Stop }} 
                elseif ($NetworkSiteID.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.NetworkSiteId)", "Creating TenantNetworkSite")) { New-CsTenantNetworkSite @params -ErrorAction Stop }}
                else { throw "Unknown Network Site for $($Item.networksiteid)" }}
            catch { write-warning "[Error] $item.networksiteid $($_.exception.message)" -WarningAction continue }
        } 
    }
    End {}
}

# Invoke-TeamsNetworkSubnet
Function Invoke-TeamsNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualNetworkSubnet]]$VirtualNetworkSubnet
 
    )
    Begin {}
    Process {
        foreach ($Item in $VirtualNetworkSubnet) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.SubnetId)
                $params.add("MaskBits", $Item.mask.replace("/", ""))
                $params.add("NetworkSiteID", $Item.networksiteid)
                if($item.Description){$params.Add("Description", $Item.Description)}
                $NetworkSubnet = Get-csTenantNetworkSubnet -Identity $item.SubnetId -erroraction SilentlyContinue
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$NetworkSubnet} | Convertto-json -depth 10)
                if ($NetworkSubnet.count -eq 1) { if($PSCmdlet.ShouldProcess("$($Item.SubnetId)", "Updating TenantNetworkSubnet")) { Set-csTenantNetworkSubnet @params -erroraction stop }}
                elseif ($NetworkSubnet.count -eq 0) { if($PSCmdlet.ShouldProcess("$($Item.SubnetId)", "Creating TenantNetworkSubnet")) { New-csTenantNetworkSubnet @params -erroraction stop }}
                else { throw "Unknown Network Subnets for $($Item.SubnetId)" }
            }
            catch { write-warning "[Error] $SiteID $subnetid -> $($_.exception.message)" }
        }
    }
    End {}
}        

# Invoke-TeamsTrustedIPAddress
Function Invoke-TeamsTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualTrustedIPAddress]]$VirtualTrustedIPAddress
    )

    Begin { }
    Process {
        foreach ($Item in $VirtualTrustedIPAddress) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.IpAddress)
                $params.Add("Mask", $Item.mask.replace("/", ""))
                if ($item.Description) {$params.Add("Description", $Item.Description)}
                $TrustedIPAddress = Get-CsTenantTrustedIPAddress -Identity $Item.ipaddress -erroraction SilentlyContinue
                Write-Information -MessageData (@{ "Virtual"=$Item;"Tenant"=$TrustedIPAddress} | Convertto-json -depth 10)
                if ($TrustedIPAddress.count -eq 1) { if($PSCmdlet.ShouldProcess("$($Item.ipaddress)", "Updating TenantTrustedIPAddress")){ set-CsTenantTrustedIPAddress @params -erroraction stop }}
                elseif ($TrustedIPAddress.count -eq 0) { if($PSCmdlet.ShouldProcess("$($Item.ipaddress)", "Creating TenantTrustedIPAddress")){ new-CsTenantTrustedIPAddress @params -erroraction stop }}
                else { throw "Unknown TrustedIPAddress for $($Item.IpAddress)" }
            }
            catch { write-warning "[Error] $ipaddress -> $($_.exception.message)" }   
        }
    }
    End {}

}

# Invoke-TeamsPstnGateway
Function Invoke-TeamsPstnGateway {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualPstnGateway]]$VirtualPstnGateway
    )

    Begin {}
    Process {
        foreach ($Item in $VirtualPstnGateway) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.identity)
                if($item.Enabled){$params.Add("Enabled", $Item.Enabled)}
                if($item.SipSignalingPort){ $params.Add("SipSignalingPort", $Item.sipsignalingport) }
                if($item.MaxConcurrentSessions){$params.Add("MaxConcurrentSessions", $Item.maxconcurrentsessions)}
                if($item.sendSipOptions){$params.Add("sendSipOptions", $Item.sendsipoptions)}
                if($item.ForwardCallHistory){$params.Add("ForwardCallHistory", $Item.forwardcallhistory)}
                if($item.Forwardpai){$params.Add("Forwardpai", $Item.forwardpai)}
                if($item.$mediaRelayRoutingLocationOverride) {$params.Add("MediaRelayRoutingLocationOverride", $Item.mediarelayroutinglocationoverride)}
                if($item.FailoverResponseCodes) {$params.Add("FailoverResponseCodes", $Item.failoverresponsecodes)}
                if($item.FailoverTimeSeconds) {$params.Add("FailoverTimeSeconds", $Item.failovertimeseconds)}
                if($item.MediaBypass) {$params.Add("MediaBypass", $Item.mediabypass)}
                if($item.bypassmode) {$params.add("BypassMode", $Item.bypassmode)}
                if($item.ProxySBC) {$params.add("ProxySBC", $Item.ProxySBC)}
                if($item.gatewaysiteid){$params.Add("gatewaysiteid", $Item.gatewaysiteid)}
                if($item.GatewaySiteLbrEnabled){$params.Add("GatewaySiteLbrEnabled", $Item.GatewaySiteLbrEnabled)}
                if($item.GatewayLbrEnabledUserOverride){$params.Add("GatewayLbrEnabledUserOverride", $Item.GatewayLbrEnabledUserOverride)}   
                $PstnGateway = Get-CsOnlinePstnGateway -Identity $Item.identity -erroraction SilentlyContinue
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$PstnGateway} | Convertto-json -depth 10)
                if ($PstnGateway.count -eq 1) { if($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating OnlinePstnGateway")) { Set-CsOnlinePstnGateway @params -erroraction stop }}
                elseif ($PstnGateway.count -eq 0) { if($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating OnlinePstnGateway")) { New-CsOnlinePstnGateway @params -erroraction stop }}
                else { throw "Unknown PstnGateway for $($item.identity)" }
            }
            catch { write-warning "[Error] $($item.identity) -> $($_.exception.message)" }   
        }
    }
    End {}
}

# Invoke-TeamsPstnUsage
Function Invoke-TeamsPstnUsage {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualPstnUsage]]$VirtualPSTNusage
    )
    Begin { }
    Process {
        foreach ($Item in $VirtualPSTNusage) {
            try {
                $PstnUsage = (Get-CsOnlinePSTNUsage -ErrorAction SilentlyContinue).usage
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$PstnUsage} | Convertto-json -depth 10)
                if (!( $PstnUsage | where-object { $_ -contains $Item.pstnusage })) {
                    if ($PSCmdlet.ShouldProcess("$($Item.pstnusage)", "Creating PstnUsage")){ Set-CsOnlinePstnUsage -Identity global -Usage @{add="$($Item.pstnusage)"} -erroraction stop }
                } else {
                    Write-Warning -message "PstnUsage $($Item.pstnusage) already exists"
                }
            } catch { Write-Warning -Message "[Error] PstnUsage $($Item.pstnusage)" }
        }
    }
    End { }    
}

# Invoke-TeamsVoiceRoute
Function Invoke-TeamsVoiceRoute {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualVoiceRoute]]$VirtualVoiceRoute
    )

    Begin {}
    Process { 
        foreach ($Item in $VirtualVoiceRoute) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.identity) 
                $params.Add("NumberPattern", $Item.NumberPattern)
                $params.Add("OnlinePstnUsages", $Item.PstnUsageList)
                $params.Add("OnlinePstnGatewayList", $Item.PstnGatewayList)
                $params.Add("Priority", $Item.Priority)
                if($item.description) {$params.Add("Description", $Item.Description)}

                $voiceroute = Get-CsOnlineVoiceRoute -Identity $Item.identity -erroraction SilentlyContinue
                if ($voiceroute.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating OnlineVoiceRoute")) { set-csonlinevoiceroute @params -erroraction stop } }
                elseif ($voiceroute.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating OnlineVoiceRoute")) { new-csonlinevoiceroute @params -erroraction stop } }
                else { throw "Unknown VoiceRoute for $($Item.identity)" }
            }
            catch { write-warning "[Error] $identity -> $($_.exception.message)" } 
        }
    }
    End {}
}

# Invoke-TeamseVoiceRoutingPolicy
Function Invoke-TeamsVoiceRoutingPolicy {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualVoiceRoutingPolicy]]$VirtualVoiceRoutingPolicy
    )

    Begin {}
    Process {
        foreach ($Item in $VirtualVoiceRoutingPolicy) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.identity)
                $params.Add("OnlinePstnUsages", $Item.PstnUsageList)
                if($item.Description) {$params.Add("Description", $Item.Description)}
                $voiceRoutingPolicy = Get-CsOnlineVoiceRoutingPolicy -Identity $Item.identity -erroraction SilentlyContinue
                if ($voiceRoutingPolicy.count -eq 1) {if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating OnlineVoiceRoutingPolicy")) { set-CsOnlineVoiceRoutingPolicy @params -erroraction stop }}
                elseif ($voiceRoutingPolicy.count -eq 0){ if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating OnlineVoiceRoutingPolicy")) { new-CsOnlineVoiceRoutingPolicy @params -erroraction stop }}
                else { throw "Unknown VoiceRoutingPolicy for $($Item.identity)" }}
            catch {write-warning "[Error] $identity -> $($_.exception.message)"}
        }
    }
    End {}
}

# Invoke-TeamsDialPlan
Function Invoke-TeamsDialPlan {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualDialPlan]]$VirtualDialPlan,
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualVoiceNormalisation]]$VirtualVoiceNormalisation
    
    )

    Begin {}
    Process {
        
        foreach ($Item in $VirtualDialPlan) {
            try {
                $params = @{ }
                $params.Add("identity",$Item.identity)
                if($item.description) {$params.Add("description",$Item.Description)}
                if($item.externalAccessPrefix) {$params.Add("externalAccessPrefix",$Item.externalAccessPrefix)}
                if($item.OptimizeDeviceDialing) {$params.Add("OptimizeDeviceDialing",$Item.OptimizeDeviceDialing)}
                $DialPlan = Get-CsTenantDialPlan -Identity $Item.identity -erroraction SilentlyContinue
                if ( $DialPlan.count -eq 1 ) {
                    if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating TenantDialPlan")) { set-csTenantdialplan @params -erroraction stop }
                }
                elseif ( $DialPlan.count -eq 0 ) {
                    if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating TenantDialPlan")) { New-csTenantDialPlan @params -erroraction stop }
                }
                else {
                    throw "Unknown DialPlan for $($Item.identity)"
                }
            } catch { 
                write-warning "[Error] $($item.identity) $($_.exception.message)" 
            }

            try{
                $rules = foreach ($rule in $VirtualVoiceNormalisation) {   
                    if ($item.identity -eq $rule.identity.split("/")[0] ) {
                            $params = @{ }
                            $params.add("Identity",$rule.identity)
                            if($rule.Pattern){$params.add("Pattern",$rule.pattern)}
                            if($rule.Translation){$params.add("Translation",$rule.translation)}
                            #BUG 
                            #if($rule.isinternalExtension){$params.add("IsInternalExtension",$rule.IsInternalExtension)}
                            if($rule.Priority){$params.add("priority",$rule.priority)}
                            if($rule.description){$params.add("description",$rule.description)}
                            New-CsVoiceNormalizationRule @params -InMemory
                    }
            
                }
                if ($rules) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Replace NormalizationRules")) {Set-CsTenantDialPlan -Identity $item.identity -NormalizationRules $rules -erroraction stop }}

            } catch { 
                Write-warning -message "[voiceNormalisation] $($rule.identity) $($_.exception.message))" -ErrorAction continue
            }
        }

    }
    End {}
}

# Invoke-TeamsIPPhonePolicy
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


# Invoke-TeamsSurvivableBranchAppliance
Function Invoke-TeamsSurvivableBranchAppliance {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (    
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualSurvivableBranchAppliance]]$VirtualSurvivableBranchAppliance
    )
 
    Begin { }
    Process {
        foreach ($Item in $VirtualSurvivableBranchAppliance) {
            try {
                $params = @{ }
                $params.Add("identity", $Item.identity)
                if($item.site){$params.Add("site", $Item.site)}
                if($item.description){$params.Add("description", $Item.description)}
       
                $tenant = Get-CsTeamsSurvivableBranchAppliance -Identity $($Item.identity) -ErrorAction SilentlyContinue

                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$tenant} | Convertto-json -depth 10)

                if ($tenant.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating TeamsSurvivableBranchAppliance")) { Set-CsTeamsSurvivableBranchAppliance @params -ErrorAction Stop }} 
                elseif ($tenant.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating TeamsSurvivableBranchAppliance")) { New-CsTeamsSurvivableBranchAppliance @params -ErrorAction Stop }}
                else { throw "Unknown SBA for $($Item.identity)" }}
            catch { write-warning "[Error] $item.identity $($_.exception.message)" -WarningAction continue }
        } 
    }
    End {}
}


# Invoke-TeamsSurvivableBranchAppliancePolicy
Function Invoke-TeamsSurvivableBranchAppliancePolicy {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (    
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualSurvivableBranchAppliancePolicy]]$VirtualSurvivableBranchAppliancePolicy
    )
 
    Begin { }
    Process {
        foreach ($Item in $VirtualSurvivableBranchAppliancePolicy) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.Identity)
                if($item.BranchApplianceFqdns){$params.Add("BranchApplianceFqdns", $Item.BranchApplianceFqdns)}


                $tenant = Get-CsTeamsSurvivableBranchAppliancePolicy -Identity $($Item.Identity) -ErrorAction SilentlyContinue

                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$tenant} | Convertto-json -depth 10)

                if ($tenant.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating TeamsSurvivableBranchAppliancePolicy")) { Set-CsTeamsSurvivableBranchAppliancePolicy @params -ErrorAction Stop }} 
                elseif ($tenant.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating TeamsSurvivableBranchAppliancePolicy")) { New-CsTeamsSurvivableBranchAppliancePolicy @params -ErrorAction Stop }}
                else { throw "Unknown SBA Policy for $($Item.identity)" }}
            catch { write-warning "[Error] $item.identity $($_.exception.message)" -WarningAction continue }
        } 
    }
    End {}
}


# Invoke-TeamsUser
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

# Set-TeamsVirtualTopologyOverride
Function Set-TeamsVirtualTopologyOverride {
    [CmdletBinding(ConfirmImpact = 'medium')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$PstnGateway,
        [Parameter(Position = 1, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$OverridePstnGateway,
        [Parameter(Position = 2, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$OverridePstnGatewayPort,
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "User", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$UserIdentity,
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "User", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$OverrideUserIdentity,
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "User", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$OverrideUserTelephone
        )

    Begin { }
    Process {
        try 
        {
            if($PSBoundParameters.ContainsKey('PstnGateway')) {
                    foreach ($item in $topology.pstngateway) {
                        if ($item.identity -eq $pstnGateway) 
                        {  
                            $item.Identity = $OverridePstnGateway
                            $item.SipSignalingPort = $OverridePstnGatewayPort
                            Write-Information -MessageData "Updatingd PstnGateway $PstnGateway -> $OverridePstnGateway"
                        }
                        if ($item.proxysbc -eq $pstnGateway) 
                        {  
                            $item.proxysbc = $OverridePstnGateway
                            Write-Information -MessageData "Updatingd Proxy $PstnGateway -> $OverridePstnGateway"
                        }
                    }

                    foreach ($item in $topology.voiceroute){
                        if($item.PstnGatewaylist -contains $PstnGateway) {
                            $item.PstnGatewaylist = $item.PstnGatewaylist.replace($PstnGateway,$OverridePstnGateway) 
                            Write-Information -MessageData "Updating VoiceRoute $PstnGateway -> $OverridePstnGateway" 
                        }
                    }
            }
            if($PSBoundParameters.ContainsKey('UserIdentity')) {
                foreach ($item in $topology.user) {
                    if ($item.identity -eq $UserIdentity) 
                    {  
                        $item.Identity = $OverrideUserIdentity
                        $item.TelephoneNumber = $OverrideUserTelephone
                    }
                }
            }  
        }
        catch { Write-warning -Message "***** Override not successful *****" -WarningAction Continue }
    }
    End { }
}  
