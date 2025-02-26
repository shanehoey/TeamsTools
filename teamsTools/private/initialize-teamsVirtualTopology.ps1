# DOC Documentation initialize-teamsVirtualTopology
function initialize-teamsVirtualTopology {
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DomainName
    )

    if ($PSCmdlet.ShouldProcess("$DomainName")) {
            $item = [VirtualTopology]::new($DomainName)
            return $item  
    } else {
            Write-Host "Virtual Topology for domain $DomainName will be created"
    }

}
