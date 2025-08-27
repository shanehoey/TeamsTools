# DOC Documentation get-teamsVirtualCallingIdPolicy
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualCallingIDPolicy {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
    [string] $Identity = "*"
    )

    try {
        
        Test-VirtualTopology

        if (-not $PSCmdlet.ShouldProcess("VirtualTopology CallingIdPolicy", "Retrieve items matching '$Identity'")) {
            Write-Verbose "Skipping retrieval of CallingIdPolicy matching '$Identity' (ShouldProcess declined)."
            return
        }

        $Item = $script:VirtualTopology.CallingIdPolicy | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

