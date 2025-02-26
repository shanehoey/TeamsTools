function initialize-teamsVirtualTopology {
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DomainName
    )

    if ($PSCmdlet.ShouldProcess("$DomainName")) {
            $Script:VirtualTopology = [VirtualTopology]::new($DomainName)
            return $Script:VirtualTopology      
    } else {
            Write-Host "Virtual Topology for domain $DomainName will be created"
    }

}
