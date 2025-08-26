#!/usr/bin/env pwsh

# Function to convert function names to PascalCase
Function  
    param([string]$FilePath)
    
    $content = Get-Content $FilePath -Raw
    
    # Pattern to match function declarations
    $pattern = '(?im)^(\s*)(function|Function)\s+([a-z][a-zA-Z0-9_-]*)\s*(\{?)(\s*)$'
    
    $newContent = $content -replace $pattern, {
        $match = $args[0]
        $indent = $match.Groups[1].Value
        $keyword = "Function"
        $functionName = $match.Groups[3].Value
        $brace = $match.Groups[4].Value
        $trailing = $match.Groups[5].Value
        
        # Convert function name to PascalCase
        $parts = $functionName -split '-'
        $pascalParts = @()
        
        foreach ($part in $parts) {
            if ($part.Length -gt 0) {
                $pascalPart = $part.Substring(0,1).ToUpper() + $part.Substring(1)
                $pascalParts += $pascalPart
            }
        }
        
        $pascalFunctionName = $pascalParts -join '-'
        
        return "$indent$keyword $pascalFunctionName $brace$trailing"
    }
    
    if ($newContent -ne $content) {
        Set-Content -Path $FilePath -Value $newContent -NoNewline
        Write-Host "Updated function names in: $FilePath"
        return $true
    }
    
    return $false
}

# Process all PowerShell files
$filesUpdated = 0
Get-ChildItem -Path "/home/shane/Development/TeamsTools" -Filter "*.ps1" -Recurse | ForEach-Object {
    if (Update-FunctionNamesToPascalCase -FilePath $_.FullName) {
        $filesUpdated++
    }
}

Write-Host "Updated $filesUpdated files with PascalCase function names."
