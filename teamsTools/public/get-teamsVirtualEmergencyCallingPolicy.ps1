# DOC Documentation get-teamsVirtualEmergencyCallingPolicy
# TODO Add support for SupportsShouldProcess

Function get-teamsVirtualEmergencyCallingPolicy {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.EmergencyCallingPolicy | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}