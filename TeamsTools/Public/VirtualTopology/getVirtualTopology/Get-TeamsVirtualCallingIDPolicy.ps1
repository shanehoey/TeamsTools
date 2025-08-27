# DOC Documentation get-teamsVirtualCallingIdPolicy
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualCallingIDPolicy {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string] $Identity = "*"
    )

    try {
        
        Test-VirtualTopology
        $Item = $script:VirtualTopology.CallingIdPolicy | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

