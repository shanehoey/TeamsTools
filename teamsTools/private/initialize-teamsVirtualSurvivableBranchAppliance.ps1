# DOC Documentation initialize-VirtualSurvivableBranchAppliance
# INVESTIGATE  should these function do any cross checking or just create the new object ? 

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

