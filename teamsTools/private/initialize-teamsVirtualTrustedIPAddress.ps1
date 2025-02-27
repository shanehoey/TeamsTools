# DOC Documentation initialize-teamsVirtualTrustedIPAddress
# INVESTIGATE  should these function do any cross checking or just create the new object ? 

Function initialize-teamsVirtualTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$IpAddress,
        [Parameter(Mandatory = $true)]
        [string]$Mask,
        [string]$Description  
    )

    if ($PSCmdlet.ShouldProcess("Initializing Virtual Trusted IP Address")) {
        try {
            $item = [VirtualTrustedIPAddress]::new($IpAddress, $Mask)
            if ($Description){$item.Description = $Description}

            return $item

        } catch {
            Write-Error -Message "$_.Exception.Message"
        }
    }
}

