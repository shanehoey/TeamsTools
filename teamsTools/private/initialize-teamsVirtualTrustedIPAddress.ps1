# DOC Documentation initialize-teamsVirtualTrustedIPAddress
Function initialize-teamsVirtualTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$IpAddress,
        [Parameter(Mandatory = $true)]
        [string]$Mask,
        [string]$Description  
    )

    try {

        $item = [VirtualTrustedIPAddress]::new($IpAddress, $Mask)
        if ($Description){$item.Description = $Description}

        return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

