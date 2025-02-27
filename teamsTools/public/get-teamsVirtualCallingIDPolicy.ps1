# DOC Documentation get-teamsVirtualCallingIdPolicy
# IMPROVEMENT Add support for SupportsShouldProcess

Function get-teamsVirtualCallingIdPolicy {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.CallingLineIdentity | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

