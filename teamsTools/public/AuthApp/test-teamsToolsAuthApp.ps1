function test-teamsToolsAuthApp {
    param ()
    try {
        $result = get-MGapplication -Filter "displayName eq 'TeamsToolsAuth'" -ErrorAction Stop
        if ($result) {
            return $true
        } else {
            return $false
        }
    }
    catch {
        if ($_.Exception.Message -match "Authentication needed") {
            Write-Error -Message "Authentication is required, Please authenticate with Connect-TeamsToolsMSGraph."
        } else {
            $false
        }
    }
}