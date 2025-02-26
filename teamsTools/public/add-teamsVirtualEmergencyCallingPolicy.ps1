# DOC Documentation add-teamsVirtualEmergencyCallingPolicy
Function add-teamsVirtualEmergencyCallingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity	,
    [ValidateNotNullOrEmpty()][string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.EmergencyCallingPolicy.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        $Item = [VirtualEmergencyCallingPolicy]::new($Identity)
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.EmergencyCallingPolicy.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}


