# DOC Documentation initialize-teamsVirtualTopology
# INVESTIGATE  should these function do any cross checking or just create the new object ? 

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
        
        
    }

}
