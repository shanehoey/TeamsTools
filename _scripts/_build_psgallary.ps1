exit

set-location $env:USERPROFILE\github\TeamsTools

$NuGetApiKey = $NuGetApiKey
$NuGetApiKey

$cert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert
$cert | format-table subject,issuer
$cert

$version = "0.1.0"

Update-ModuleManifest -Path ".\TeamsTools\TeamsTools.psd1" -ModuleVersion $version

Set-AuthenticodeSignature -filepath ".\TeamsTools\TeamsTools.psd1" -Certificate $cert
(Get-AuthenticodeSignature -FilePath ".\TeamsTools\TeamsTools.psd1").Status

Set-AuthenticodeSignature -filepath ".\TeamsTools\TeamsTools.psm1" -Certificate $cert
(Get-AuthenticodeSignature -FilePath ".\TeamsTools\TeamsTools.psm1").Status

Test-ModuleManifest -path ".\TeamsTools\TeamsTools.psd1"

Remove-Module DirectRoutingTools -ErrorAction SilentlyContinue
Import-Module .\TeamsTools\TeamsTools.psm1

get-command -Module TeamsTools | Select-Object name,version

#Manually run these 


### MANUAL GitHUB Commit to master

### IMPORTANT ONLY RUN AFTER ALL ABOVE IS COMPLETED
pause
Publish-Module -path .\TeamsTools -NuGetApiKey $NuGetApiKey