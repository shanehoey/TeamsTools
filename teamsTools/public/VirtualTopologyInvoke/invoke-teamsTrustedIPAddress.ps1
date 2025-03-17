# DOC Documentation invoke-teamsTrustedIPAddress
Function invoke-teamsTrustedIPAddress {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualTrustedIPAddress]]$VirtualTrustedIPAddress
    )

    Begin { }
    Process {
        foreach ($Item in $VirtualTrustedIPAddress) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.IpAddress)
                $params.Add("Mask", $Item.mask.replace("/", ""))
                if ($item.Description) {$params.Add("Description", $Item.Description)}
                $TrustedIPAddress = Get-CsTenantTrustedIPAddress -Identity $Item.ipaddress -erroraction SilentlyContinue
                Write-Information -MessageData (@{ "Virtual"=$Item;"Tenant"=$TrustedIPAddress} | Convertto-json -depth 10)
                if ($TrustedIPAddress.count -eq 1) { if($PSCmdlet.ShouldProcess("$($Item.ipaddress)", "Updating TenantTrustedIPAddress")){ set-CsTenantTrustedIPAddress @params -erroraction stop }}
                elseif ($TrustedIPAddress.count -eq 0) { if($PSCmdlet.ShouldProcess("$($Item.ipaddress)", "Creating TenantTrustedIPAddress")){ new-CsTenantTrustedIPAddress @params -erroraction stop }}
                else { throw "Unknown TrustedIPAddress for $($Item.IpAddress)" }
            }
            catch { write-warning "[Error] $ipaddress -> $($_.exception.message)" }   
        }
    }
    End {}

}

