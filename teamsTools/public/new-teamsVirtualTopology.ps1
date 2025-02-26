Function new-teamsVirtualTopology {
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DomainName
    )


    if ($PSCmdlet.ShouldProcess("Creating virtual topology for domain $DomainName")) {
        if ($Script:VirtualTopology) {
            $Script:VirtualTopology = [VirtualTopology]::new($DomainName)
            return $Script:VirtualTopology
        } else {
            $confirmPreference = 'High'
            Write-Host "Resetting new Virtual Topology for domain $DomainName"
            $Script:VirtualTopology = [VirtualTopology]::new($DomainName)
            return $Script:VirtualTopology
        }
    } else {
        if ($Script:VirtualTopology) {
            Write-Host "Virtual Topology for domain $DomainName already exists and will be overwritten"
        } else {
            Write-Host "Virtual Topology for domain $DomainName will be created"
        }
    }

}
