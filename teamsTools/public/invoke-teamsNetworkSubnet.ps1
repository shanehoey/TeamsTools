# DOC Documentation invoke-teamsNetworkSubnet

Function invoke-teamsNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualNetworkSubnet]]$VirtualNetworkSubnet
 
    )
    Begin {}
    Process {
        foreach ($Item in $VirtualNetworkSubnet) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.SubnetId)
                $params.add("MaskBits", $Item.mask.replace("/", ""))
                $params.add("NetworkSiteID", $Item.networksiteid)
                if($item.Description){$params.Add("Description", $Item.Description)}
                $NetworkSubnet = Get-csTenantNetworkSubnet -Identity $item.SubnetId -erroraction SilentlyContinue
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$NetworkSubnet} | Convertto-json -depth 10)
                if ($NetworkSubnet.count -eq 1) { if($PSCmdlet.ShouldProcess("$($Item.SubnetId)", "Updating TenantNetworkSubnet")) { Set-csTenantNetworkSubnet @params -erroraction stop }}
                elseif ($NetworkSubnet.count -eq 0) { if($PSCmdlet.ShouldProcess("$($Item.SubnetId)", "Creating TenantNetworkSubnet")) { New-csTenantNetworkSubnet @params -erroraction stop }}
                else { throw "Unknown Network Subnets for $($Item.SubnetId)" }
            }
            catch { write-warning "[Error] $SiteID $subnetid -> $($_.exception.message)" }
        }
    }
    End {}
}        
