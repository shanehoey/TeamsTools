
Function Get-TeamsVirtualPstnGateway {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [string]$Identity = "*"
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        # Respect -WhatIf / -Confirm by calling ShouldProcess for read operations as requested
        if (-not $PSCmdlet.ShouldProcess("VirtualTopology.PstnGateway", "Retrieve items matching '$Identity'")) {
            Write-Verbose "Retrieval cancelled by ShouldProcess"
            return $null
        }

        $Item = $script:VirtualTopology.PstnGateway | Where-Object { $_.Identity -like $Identity }
        return $Item

    } catch {
        $msg = if ($_.Exception) { $_.Exception.Message } else { $_.ToString() }
        Write-Error -Message $msg
    }
}
