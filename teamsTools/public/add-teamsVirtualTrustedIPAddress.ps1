# DOC Documentation add-teamVirtualTrustedIPAddress
Function add-teamsVirtualTrustedIPAddress {
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

    if ($script:VirtualTopology.TrustedIPAddress.IPAddress -contains $IpAddress) {
        throw "IPAddress $IpAddress exists in VirtualTopology."
    }

    $Item = [VirtualTrustedIPAddress]::new($IpAddress, $Mask)
    if ($Description){$item.Description = $Description}

    $script:VirtualTopology.TrustedIPAddress.Add($Item)

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

