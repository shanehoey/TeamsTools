# DOC Documentation get-teamVirtualDialPlan
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualDialPlan {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
    [string] $Identity = "*",
    [string] $SimpleName = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if (-not $PSCmdlet.ShouldProcess("VirtualTopology DialPlan", "Retrieve items matching '$Identity' and simple name '$SimpleName'")) {
            Write-Verbose "Skipping retrieval of DialPlan matching '$Identity' and simple name '$SimpleName' (ShouldProcess declined)."
            return
        }

        $Item = $script:VirtualTopology.DialPlan | where-object {$_.Identity -like $Identity -and $_.SimpleName -like $SimpleName}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
} 

