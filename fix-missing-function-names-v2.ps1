#!/usr/bin/env pwsh

# Script to restore missing function names that got stripped during automated processing

$TeamsToolsPath = "/home/shane/Development/TeamsTools/TeamsTools"

# Get all .ps1 files that have function declarations with missing or incomplete names
$FilesToFix = Get-ChildItem -Path $TeamsToolsPath -Recurse -Filter "*.ps1" | Where-Object {
    $Content = Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue
    if ($Content) {
        # Check for patterns like "Function  " or "Function { " or "Function \n"
        $Content -match "Function\s*\n" -or $Content -match "Function\s+\s*[\{\n]"
    }
}

Write-Host "Found $($FilesToFix.Count) files to check/fix"

foreach ($File in $FilesToFix) {
    $FileName = [System.IO.Path]::GetFileNameWithoutExtension($File.Name)
    $Content = Get-Content $File.FullName -Raw
    $NeedsUpdate = $false
    
    Write-Host "Checking: $($File.Name)"
    
    # Pattern 1: Function followed by whitespace and newline
    if ($Content -match "Function\s+\s*\n") {
        Write-Host "  Fixing pattern: Function + whitespace + newline"
        $Content = $Content -replace "Function\s+\s*\n", "Function $FileName {`n"
        $NeedsUpdate = $true
    }
    
    # Pattern 2: Function followed by whitespace and opening brace
    if ($Content -match "Function\s+\s*\{") {
        Write-Host "  Fixing pattern: Function + whitespace + {"
        $Content = $Content -replace "Function\s+\s*\{", "Function $FileName {"
        $NeedsUpdate = $true
    }
    
    # Pattern 3: Function followed by just newline
    if ($Content -match "Function\s*\n") {
        Write-Host "  Fixing pattern: Function + newline"
        $Content = $Content -replace "Function\s*\n", "Function $FileName {`n"
        $NeedsUpdate = $true
    }
    
    if ($NeedsUpdate) {
        Write-Host "  Updated function name to: $FileName"
        $Content | Set-Content $File.FullName -NoNewline
    } else {
        Write-Host "  No changes needed"
    }
}

Write-Host "Completed fixing function names"
