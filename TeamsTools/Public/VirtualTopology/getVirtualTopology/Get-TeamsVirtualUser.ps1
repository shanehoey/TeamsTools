# DOC Documentation get-teamsVirtualUser
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualUser {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if (-not $PSCmdlet.ShouldProcess("VirtualTopology User", "Retrieve items matching '$Identity'")) {
            Write-Verbose "Skipping retrieval of User matching '$Identity' (ShouldProcess declined)."
            return
        }

        $Item = $script:VirtualTopology.User | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}