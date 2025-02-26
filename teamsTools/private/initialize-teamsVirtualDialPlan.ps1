# DOC Documentation initialize-teamsVirtualDialPlan
Function initialize-teamsVirtualDialPlan {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [String] $SimpleName = $identity,
    [String] $ExternalAccessPrefix,
    [String] $OptimizeDeviceDialing,	
    [string] $Description
    )

    try {
       
        $Item = [VirtualDialPlan]::new($Identity)
       
        if ($SimpleName){$item.SimpleName = $SimpleName}
        if ($ExternalAccessPrefix){$item.ExternalAccessPrefix = $ExternalAccessPrefix}
        if ($OptimizeDeviceDialing){$item.OptimizeDeviceDialing = $OptimizeDeviceDialing}
        if ($Description){$item.Description = $Description}

        return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

