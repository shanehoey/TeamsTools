# Checks that FunctionsToExport in TeamsTools.psd1 matches exported functions
$manifest = Join-Path $PSScriptRoot '..' '..' 'TeamsTools' 'TeamsTools.psd1'
$modulePath = Join-Path $PSScriptRoot '..' '..' 'TeamsTools'

Write-Host "Loading manifest: $manifest"

# Load manifest as hashtable
$manifestHash = (Get-Content $manifest -Raw) -replace "`r`n", "`n"
# Evaluate the hashtable by invoking PowerShell to parse
$psData = Invoke-Expression $manifestHash

$functionsFromManifest = $psData.FunctionsToExport

Import-Module "$modulePath/TeamsTools.psd1" -Force | Out-Null
$exported = Get-Command -Module TeamsTools | Where-Object { $_.CommandType -eq 'Function' } | Select-Object -ExpandProperty Name

$missing = $functionsFromManifest | Where-Object { $_ -notin $exported }
$extra = $exported | Where-Object { $_ -notin $functionsFromManifest }

if ($missing.Count -gt 0) {
    Write-Error "Functions listed in manifest but not exported: $($missing -join ', ')"
    exit 2
}

if ($extra.Count -gt 0) {
    Write-Error "Functions exported but not listed in manifest: $($extra -join ', ')"
    exit 3
}

Write-Host "FunctionsToExport matches exported function list"; exit 0
