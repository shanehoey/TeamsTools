# DOC Documentation get-teamsVirtualTrustedIPAddress
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [string]$IpAddress = "*"
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if (-not $PSCmdlet.ShouldProcess("VirtualTopology TrustedIPAddress", "Retrieve items matching '$IpAddress'")) {
        Write-Verbose "Skipping retrieval of TrustedIPAddress matching '$IpAddress' (ShouldProcess declined)."
        return
    }

    $Item = $script:VirtualTopology.TrustedIPAddress | where-object {$_.IPAddress -like $IpAddress}
    return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
