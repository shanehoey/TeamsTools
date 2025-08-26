$HelperCandidate = Get-ChildItem -Path $PSScriptRoot -Recurse -Include Write-TeamsToolsError.ps1 -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $HelperCandidate) { throw "Write-TeamsToolsError helper not found under $PSScriptRoot" }

Describe 'Write-TeamsToolsError' {
    It 'Throws when -Terminate is provided' {
        . $HelperCandidate.FullName
        { Write-TeamsToolsError -Message 'fatal' -Terminate } | Should -Throw
    }

    It 'Writes an error record when not terminating' {
        . $HelperCandidate.FullName
        # Clear any existing error
        $global:Error.Clear()
        Write-TeamsToolsError -Message 'nonfatal'
        $global:Error[0].Exception.Message | Should -Be 'nonfatal'
    }
}
