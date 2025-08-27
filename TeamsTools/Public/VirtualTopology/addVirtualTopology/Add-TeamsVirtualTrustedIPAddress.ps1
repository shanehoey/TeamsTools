# DOC Documentation add-teamVirtualTrustedIPAddress
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualTrustedIPAddress {
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

    if ($script:VirtualTopology.TrustedIPAddress.IPAddress -contains $IpAddress) {
        throw "IPAddress $IpAddress exists in VirtualTopology."
    }

    if ($PSCmdlet.ShouldProcess("VirtualTopology TrustedIPAddress '$IpAddress'","Add")) {
        $Item = [VirtualTrustedIPAddress]::new($IpAddress, $Mask)
        if ($Description){$item.Description = $Description}

        $script:VirtualTopology.TrustedIPAddress.Add($Item)
    } else {
        Write-Verbose "Skipping add of TrustedIPAddress '$IpAddress' (ShouldProcess declined or -WhatIf)."
    }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

