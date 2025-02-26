# DOC Documentation invoke-teamsNetworkSite

Function invoke-teamsNetworkSite {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (    
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualNetworkSite]]$VirtualNetworkSite
    )
 
    Begin { }
    Process {
        foreach ($Item in $VirtualNetworkSite) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.NetworkSiteId)
                $params.Add("NetworkRegionID", $Item.NetworkRegionId)
                if($item.Description){$params.Add("Description", $Item.Description)}
                $NetworkSiteID = Get-CsTenantNetworkSite -Identity $($Item.NetworkSiteId) -ErrorAction SilentlyContinue
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$NetworkSiteID} | Convertto-json -depth 10)
                if ($NetworkSiteID.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.NetworkSiteId)", "Updating TenantNetworkSite")) { set-CsTenantNetworkSite @params -ErrorAction Stop }} 
                elseif ($NetworkSiteID.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.NetworkSiteId)", "Creating TenantNetworkSite")) { New-CsTenantNetworkSite @params -ErrorAction Stop }}
                else { throw "Unknown Network Site for $($Item.networksiteid)" }}
            catch { write-warning "[Error] $item.networksiteid $($_.exception.message)" -WarningAction continue }
        } 
    }
    End {}
}
