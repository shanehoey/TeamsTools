#!/usr/bin/env pwsh

# Script to restore missing function names that got stripped during automated processing

$TeamsToolsPath = "/home/shane/Development/TeamsTools/TeamsTools"

# Get all .ps1 files that have empty function declarations
$FilesToFix = Get-ChildItem -Path $TeamsToolsPath -Recurse -Filter "*.ps1" | Where-Object {
    $Content = Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue
    $Content -match "^Function\s+\s*\n"
}

Write-Host "Found $($FilesToFix.Count) files to fix"

foreach ($File in $FilesToFix) {
    $FileName = [System.IO.Path]::GetFileNameWithoutExtension($File.Name)
    $Content = Get-Content $File.FullName -Raw
    
    Write-Host "Fixing: $($File.FullName)"
    Write-Host "  Function name: $FileName"
    
    # Replace "Function  " with "Function FunctionName {"
    $UpdatedContent = $Content -replace "^Function\s+\s*\n", "Function $FileName {`n"
    
    # Write the updated content back
    $UpdatedContent | Set-Content $File.FullName -NoNewline
}

Write-Host "Completed fixing function names"
