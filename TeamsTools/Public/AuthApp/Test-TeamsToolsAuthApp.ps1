
Function Test-TeamsToolsAuthApp {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param ()

    if ($PSCmdlet -and -not $PSCmdlet.ShouldProcess('TeamsToolsAuth App', 'Check presence of TeamsToolsAuth application')) {
        Write-Verbose "Skipping check for TeamsToolsAuth application because ShouldProcess returned false."
        return $false
    }

    try {
        $result = Get-MGApplication -Filter "displayName eq 'TeamsToolsAuth'" -ErrorAction Stop
        return [bool]$result
    }
    catch {
        if ($_.Exception.Message -match 'Authentication needed') {
            Write-Error -Message 'Authentication is required, Please authenticate with Connect-TeamsToolsMSGraph.'
        }
        return $false
    }
}