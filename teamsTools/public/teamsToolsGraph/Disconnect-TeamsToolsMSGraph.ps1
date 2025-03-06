Function Disconnect-TeamsToolsMSGraph {
    [CmdletBinding(SupportsShouldProcess=$false, ConfirmImpact = 'low')]
    param ()
    
    try {
        Disconnect-MgGraph -ErrorAction Stop | Out-Null
        Write-Verbose -Message "Disconnected from Microsoft Graph" -verbose    
    }
    catch {
        Write-Error -Message "Failed to disconnect from Microsoft Graph:  $_"
    }

}