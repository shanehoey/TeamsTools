# DOC Documentation add-teamsVirtualNetworkRegion
# TODO Add support for SupportsShouldProcess

Function add-teamsVirtualNetworkRegion {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string]$NetworkRegionID,
        [Parameter(ValueFromPipeline)][string]$Description,
        [Parameter(ValueFromPipeline)][source]$source
    )
    
   try { 
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found."
    }

    if  ($script:VirtualTopology.NetworkRegion.NetworkRegionID -contains $NetworkRegionID) {
        throw "VirtualTopology already contains $NetworkRegionID."
    }

    $item = [VirtualNetworkRegion]::new($NetworkRegionID)
    if ($Description){$item.Description = $Description}
    if ($source){$item.Source = $source}
    
    $Script:VirtualTopology.NetworkRegion.Add($item) 

    } Catch {
        Write-Error -Message "$_.Exception.Message"
    }

}
