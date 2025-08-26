# DOC Documentation get-teamsVirtualTopology
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualTopology {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param ()

    Try{

        if (-not $script:VirtualTopology) {
            Write-TeamsToolsError -Message "Teams VirtualTopology not found. Please create new VirtualTopology with New-TeamsVirtualTopology." -Terminate
        }

        return $Script:VirtualTopology

    }
    Catch {
        Write-TeamsToolsError -Message "$_.Exception.Message" -Exception $_.Exception -Terminate
    }
}