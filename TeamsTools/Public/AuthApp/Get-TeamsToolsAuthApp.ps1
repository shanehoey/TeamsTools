# DOC Documentation update=teamsToolsAuth
Function Get-TeamsToolsAuthApp {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param ()

    if ($PSCmdlet -and -not $PSCmdlet.ShouldProcess('TeamsToolsAuth App', 'Retrieve TeamsToolsAuth application')) {
        Write-Verbose "Skipping retrieval of TeamsToolsAuth application because ShouldProcess returned false."
        return
    }

    try {
        $result = Get-MGApplication -Filter "displayName eq 'TeamsToolsAuth'" -ErrorAction Stop
        return $result | Select-Object -Property displayName,appId,@{Name='SecretID';Expression={$_.PasswordCredentials.KeyID}}
    }
    catch {
        if ($_.Exception.Message -match 'Authentication needed') {
            Write-Error -Message 'Authentication is required, Please authenticate with Connect-TeamsToolsMSGraph.'
        } else {
            Write-Error -Message "$_"
        }
    }

}