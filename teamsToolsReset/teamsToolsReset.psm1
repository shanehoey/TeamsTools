#Requires -Modules @{ ModuleName="MicrosoftTeams"; ModuleVersion="6.7.0" }
#Requires -Modules @{ ModuleName="Microsoft.Graph.authentication"; ModuleVersion="2.25.0" }
#Requires -Modules @{ ModuleName="Microsoft.Graph.Groups"; ModuleVersion="2.25.0" }
#Requires -Modules @{ ModuleName="Microsoft.Graph.Users"; ModuleVersion="2.25.0" }
#Requires -version 5.0

#Set-StrictMode -Version Latest 

<#
    Copyright (c) 2016-2025 Shane Hoey

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#>


# .source the classes Folder
$files = @( Get-ChildItem -Path $PSScriptRoot\classes\*.ps1 -Recurse -ErrorAction SilentlyContinue )
foreach ($file in $files) {
    try {
        . $file.FullName
    } catch {
        Write-Error -Message "Failed to import class $($class.FullName)"
    }
}

# .source the private Folder
$files = @( Get-ChildItem -Path $PSScriptRoot\private\*.ps1 -Recurse -ErrorAction SilentlyContinue )
foreach ($file in $files) {
    try {
        . $file.FullName
    } catch {
        Write-Error -Message "Failed to import function $($file.FullName)"
    }
}


# .source the public Folder
$files = @( Get-ChildItem -Path $PSScriptRoot\public\*.ps1 -Recurse -ErrorAction SilentlyContinue )
foreach ($file in $files) {
    try {
        . $file.FullName
    } catch {
        Write-Error -Message "Failed to import function $($file.FullName)"
    }
}

Export-ModuleMember -Function *



Export-ModuleMember -Function * -Variable * 
