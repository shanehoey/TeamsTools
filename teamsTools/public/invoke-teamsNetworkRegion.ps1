# DOC Documentation invoke-teamsNetworkRegion

Function invoke-teamsNetworkRegion {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualNetworkRegion]]$VirtualNetworkRegion
    )
    Begin { }
    Process { 
        foreach ($Item in $VirtualNetworkRegion) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.NetworkRegionId)
                if($item.Description){$params.Add("Description", $Item.Description)}
                $NetworkRegion = Get-CsTenantNetworkRegion -Identity $($Item.NetworkRegionId) -ErrorAction SilentlyContinue 
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$NetworkRegion} | Convertto-json -depth 10)
                if ($NetworkRegion.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.NetworkRegionId)", "Updating TenantNetworkRegion")) { Set-csTenantNetworkRegion @params -ErrorAction Stop }}
                elseif ($NetworkRegion.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.NetworkRegionId)", "Creating TenantNetworkRegion")) { New-cstenantnetworkregion @params -ErrorAction Stop }}
                else { throw "Unknown Network Region for $($Item.NetworkRegionId)" }}
            catch { write-warning -Message "[Error] $($Item.networkregionid) -> $($_.exception.message)" } 
        }
    }
    end { }
}