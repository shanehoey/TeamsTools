# DOC Documentation set-teams
function Set-TeamsVirtualVoiceRoutingPolicy {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Identity,

        [Parameter(Mandatory = $false)]
        [System.Collections.Generic.List[string]]$PstnUsageList,

        [Parameter(Mandatory = $false)]
        [string]$Description
    )

    try {
        if (-not $script:VirtualTopology) {
            Write-TeamsToolsError -Message "Teams VirtualTopology not loaded in script scope." -Terminate
        }

        # Find the policy object (adjust collection name if different)
        $policy = $script:VirtualTopology.VoiceRoutingPolicies | Where-Object { $_.Identity -eq $Identity }

        if (-not $policy) {
            Write-TeamsToolsError -Message "Voice routing policy with Identity '$Identity' not found in VirtualTopology." -Terminate
        }

        # Validate Pstn usages if provided (adjust property names to your model)
        if ($PstnUsageList) {
            $missing = @()
            foreach ($usageId in $PstnUsageList) {
                if (-not ($script:VirtualTopology.PstnUsages | Where-Object { $_.Identity -eq $usageId })) {
                    $missing += $usageId
                }
            }
            if ($missing.Count -gt 0) {
                Write-TeamsToolsError -Message "PstnUsage(s) not found in VirtualTopology: $($missing -join ', ')" -Terminate
            }
        }

        # Respect -WhatIf / -Confirm
        if ($PSCmdlet.ShouldProcess("VoiceRoutingPolicy/$Identity", "Update")) {
            if ($Description) {
                $policy.Description = $Description
            }
            if ($PstnUsageList) {
                # store whichever shape your policy expects (IDs or objects)
                $policy.PstnUsages = $PstnUsageList
            }

            # Return the updated policy
            return $policy
        } else {
            return $null
        }

    } catch {
        $msg = if ($_.Exception) { $_.Exception.Message } else { $_.ToString() }
        Write-TeamsToolsError -Message $msg -Exception $_.Exception -Terminate
    }
}
