<#
.SYNOPSIS
Disconnects from Microsoft Graph.

.DESCRIPTION
The Disconnect-TeamsToolsGraph function disconnects the current session from Microsoft Graph. 
If there is no active connection, it will provide a warning message.

.PARAMETERS
This function does not take any parameters.

.EXAMPLES
Example 1:
PS C:\> Disconnect-TeamsToolsGraph
Disconnects the current session from Microsoft Graph.

.NOTES

#>
Function Disconnect-TeamsToolsGraph {
    [CmdletBinding(SupportsShouldProcess=$false, ConfirmImpact = 'low')]
    param ()
    
    try {
        Disconnect-MgGraph -ErrorAction Stop | out-null
        Write-Verbose -Message "Disconnected from Microsoft Graph" -verbose    
    }
    catch {
        if ($_.Exception.Message -eq "No application to sign out from.") {
            Write-Warning -Message "Disconnection not required: No active connection to Microsoft Graph."
        } else {
            Write-Error -Message "Failed to disconnect from Microsoft Graph:  $_"
        }
    }

}