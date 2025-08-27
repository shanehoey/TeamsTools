# DOC Documentation get-teamsVirtualTopology
# IMPROVEMENT Add support for SupportsShouldProcess
Function Get-TeamsVirtualTopology {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param ()

    Try{

        if (-not $script:VirtualTopology) {
            Write-TeamsToolsError -Message "Teams VirtualTopology not found. Please create new VirtualTopology with New-TeamsVirtualTopology." -Terminate
        }

        if (-not $PSCmdlet.ShouldProcess("VirtualTopology", "Retrieve current virtual topology")) {
            Write-Verbose "Skipping retrieval of VirtualTopology (ShouldProcess declined)."
            return
        }

        return $Script:VirtualTopology

    }
    Catch {
        Write-TeamsToolsError -Message "$_.Exception.Message" -Exception $_.Exception -Terminate
    }
}