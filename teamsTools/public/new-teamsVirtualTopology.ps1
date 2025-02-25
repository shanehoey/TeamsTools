Function new-teamsVirtualTopology {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$DomainName
    )
    try{
        $Script:VirtualTopology = [VirtualTopology]::new($DomainName)
    }
    Catch {
        Write-Error -Message $_.Exception.Message
    }

}

