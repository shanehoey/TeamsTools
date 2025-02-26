# DOC Documentation initialize-teamsVirtualNetworkSubnet
Function initialize-teamsVirtualNetworkSubnet {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param(
    [Parameter(Mandatory = $true)]
    [string]$SubnetId,
    [string]$Mask,
    [string]$NetworkSiteId,
    [string]$Description,
    [string]$source
    )
    try {

    

    $Item = [VirtualNetworkSubnet]::new($NetworkSiteId, $SubnetId, $Mask)
    if ($Description){$item.Description = $Description}

    return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
