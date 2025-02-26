# DOC Documentation invoke-teamsDialPlan


Function invoke-teamsDialPlan {
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