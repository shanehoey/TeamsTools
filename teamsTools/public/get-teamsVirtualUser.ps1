# DOC Documentation get-teamsVirtualUser
Function get-teamsVirtualUser {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.User | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}