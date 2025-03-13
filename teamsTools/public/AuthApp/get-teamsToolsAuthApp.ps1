function get-teamsToolsAuthApp {
    param ()
    try {
        $result = get-MGapplication -Filter "displayName eq 'TeamsToolsAuth'" -ErrorAction Stop
        return $result | select-object -Property displayName,appId,@{Name="SecretID";Expression={$_.PasswordCredentials.KeyID}} 
        }
    catch {
        if ($_.Exception.Message -match "Authentication needed") {
            Write-Error -Message "Authentication is required, Please authenticate with Connect-TeamsToolsMSGraph."
        } else {
            Write-Error -Message "$_"
        }
    }

}