Function get-teamsVirtualTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [string]$IpAddress = "*"
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    $Item = $script:VirtualTopology.TrustedIPAddress | where-object {$_.IPAddress -like $IpAddress}
    return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
