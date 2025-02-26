# DOC Documentation get-teamsVirtualTopology

Function get-teamsVirtualTopology {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param ()

    Try{

        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found. Please create new VirtualTopology with New-TeamsVirtualTopology."
        }

        return $Script:VirtualTopology

    }
    Catch {
        Write-Error -Message "$_.Exception.Message"
    }
}