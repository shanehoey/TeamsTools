# DOC Documentation set-teamsVirtualTrustedIPAddress
# IMPROVEMENT Add support for SupportsShouldProcess

Function set-teamsVirtualTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$IpAddress,
        [Parameter(Mandatory = $true)]
        [string]$Mask,
        [string]$Description  
    )
    try {
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if ($script:VirtualTopology.TrustedIPAddress.IPAddress -notcontains $IpAddress) {
        throw "IPAddress $IpAddress not found in VirtualTopology."
    }

    $Item = $script:VirtualTopology.TrustedIPAddress | where-object {$_.IPAddress -eq $IpAddress}
    $Item.Mask = $Mask
    $Item.Description = $Description

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

