# DOC Documentation NewteamsToolsAuth
# IMPROVEMENT Add support for SupportsShouldProcess

function Disconnect-TeamsTools {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param ()

    if ($PSCmdlet.ShouldProcess("Disconecting from Microsoft Graph and Teams")) {

        try {
            Disconnect-TeamsToolsGraph 
            Disconnect-MicrosoftTeams -confirm:$false
            Disconnect-ExchangeOnline -Confirm:$false
        } catch {
            Write-Error "Failed to disconnect from Microsoft Graph and Teams."
        }
        
}
}
