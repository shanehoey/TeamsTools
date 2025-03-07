function get-teamsToolsAuthApp {
    param (
        [switch]$quiet
    )
    try {
        $result = get-MGapplication -Filter "displayName eq 'TeamsToolsAuth'" -ErrorAction SilentlyContinue
        if ($quiet) {
            if($result) {return $true } else { return $false }  
        } else {
            if($result) { $result | select-object -Property displayName,appId,@{Name="SecretID";Expression={$_.PasswordCredentials.KeyID}} } else { throw "Error: Unable to get TeamsToolsAuthApp" }
        }
        
    } catch {
           Write-warning "Unable to access TeamsToolsAuthApp"
   }

}