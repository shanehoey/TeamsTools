# DOC Documentation get-teamsvirtualphonepolicy
# TODO Add support for SupportsShouldProcess

Function get-teamsVirtualPhonePolicy {
    
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [string] $Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        $Item = $script:VirtualTopology.PhonePolicy | where-object {$_.Identity -like $Identity}
        return $Item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
