# DOC Documentation set-teamsVirtualTrustedIPAddress
# IMPROVEMENT Add support for SupportsShouldProcess
Function Set-TeamsVirtualTrustedIPAddres {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
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

    if ($PSCmdlet.ShouldProcess("VirtualTopology TrustedIPAddress '$IpAddress'","Update")) {
        $Item = $script:VirtualTopology.TrustedIPAddress | where-object {$_.IPAddress -eq $IpAddress}
        $Item.Mask = $Mask
        $Item.Description = $Description
    } else {
        Write-Verbose "Skipping update of TrustedIPAddress '$IpAddress' (ShouldProcess declined or -WhatIf)."
    }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

