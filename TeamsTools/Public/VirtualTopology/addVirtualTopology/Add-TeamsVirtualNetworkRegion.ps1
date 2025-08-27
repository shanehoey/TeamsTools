# DOC Documentation add-teamsVirtualNetworkRegion
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualNetworkRegion {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
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
    
    if ($PSCmdlet.ShouldProcess("VirtualTopology NetworkRegion '$NetworkRegionID'", "Add")) {
        $Script:VirtualTopology.NetworkRegion.Add($item)
        return $item
    } else {
        Write-Verbose "Skipping add of NetworkRegion '$NetworkRegionID' (ShouldProcess declined)."
        return $null
    }

    } Catch {
        Write-Error -Message "$_.Exception.Message"
    }

}
