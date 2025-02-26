# DOC Documentation get-teamVirtualDialPlan
# TODO Add support for SupportsShouldProcess

Function get-teamsVirtualDialPlan {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string] $Identity = "*",
    [string] $SimpleName = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.DialPlan | where-object {$_.Identity -like $Identity -and $_.SimpleName -like $SimpleName}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
} 

