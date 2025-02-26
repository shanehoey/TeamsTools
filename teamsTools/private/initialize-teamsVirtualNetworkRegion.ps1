# DOC Documentation initialize-teamsVirtualNetworkRegion
Function initialize-teamsVirtualNetworkRegion {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string]$NetworkRegionID,
        [Parameter(ValueFromPipeline)][string]$Description,
        [Parameter(ValueFromPipeline)][source]$source
    )
    
   try { 
    

    $item = [VirtualNetworkRegion]::new($NetworkRegionID)
    
    if ($Description){$item.Description = $Description}
    if ($source){$item.Source = $source}
    
    return $item

    } Catch {
        Write-Error -Message "$_.Exception.Message"
    }

}
