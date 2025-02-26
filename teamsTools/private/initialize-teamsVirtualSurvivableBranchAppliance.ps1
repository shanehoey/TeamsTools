# DOC Documentation initialize-VirtualSurvivableBranchAppliance

Function initialize-teamsVirtualSurvivableBranchAppliance {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (

    [string] $identity,
    [string] $Site,
    [string] $Description
    )

    try {


        $Item = [VirtualSurvivableBranchAppliance]::new($identity)
        
        if ($site) {$item.site =$site}
        if ($Description) {$item.Description = $Description}
     
        return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}

