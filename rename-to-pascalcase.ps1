#!/usr/bin/env pwsh

# Function to convert filename to PascalCase
Function  
    param([string]$FileName)
    
    # Get name without extension
    $nameOnly = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
    $extension = [System.IO.Path]::GetExtension($FileName)
    
    # Split on hyphens and convert each part to PascalCase
    $parts = $nameOnly -split '-'
    $pascalParts = @()
    
    foreach ($part in $parts) {
        if ($part.Length -gt 0) {
            # Capitalize first letter, keep rest as is (preserving existing capitalization)
            $pascalPart = $part.Substring(0,1).ToUpper() + $part.Substring(1)
            $pascalParts += $pascalPart
        }
    }
    
    return ($pascalParts -join '-') + $extension
}

# Function to process directory
Function  
    param([string]$Directory)
    
    Write-Host "Processing directory: $Directory"
    
    Get-ChildItem -Path $Directory -Filter "*.ps1" -Recurse | ForEach-Object {
        $originalName = $_.Name
        $newName = ConvertTo-PascalCase -FileName $originalName
        
        if ($originalName -ne $newName) {
            Write-Host "  Renaming: $originalName -> $newName"
            
            try {
                Rename-Item -Path $_.FullName -NewName $newName -ErrorAction Stop
            }
            catch {
                Write-Warning "Failed to rename $originalName`: $($_.Exception.Message)"
            }
        }
    }
}

# Process all directories
Write-Host "Converting all PowerShell files to PascalCase..."
Rename-FilesToPascalCase -Directory "/home/shane/Development/TeamsTools"
Write-Host "Renaming complete!"
