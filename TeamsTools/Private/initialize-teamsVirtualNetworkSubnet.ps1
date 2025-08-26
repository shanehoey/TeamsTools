# DOC Documentation initialize-teamsVirtualNetworkSubnet
# INVESTIGATE  should these function do any cross checking or just create the new object ? 

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
