#!/usr/bin/env pwsh

# Simple Class Test Runner

Write-Host "TeamsTools Class Tests" -ForegroundColor Green
Write-Host "=====================" -ForegroundColor Green

# Import Pester
try {
    Import-Module Pester -Force -ErrorAction Stop
    Write-Host "✓ Pester loaded" -ForegroundColor Green
} catch {
    Write-Error "Failed to load Pester. Install with: Install-Module Pester -Force"
    exit 1
}

# Run all class tests
Write-Host "Running class tests..." -ForegroundColor Yellow
Write-Host ""

$Config = New-PesterConfiguration
$Config.Run.Path = "./tests/classes/*.Tests.ps1"
$Config.Output.Verbosity = 'Detailed'

$Result = Invoke-Pester -Configuration $Config

# Show summary
Write-Host ""
Write-Host "Class Test Results:" -ForegroundColor Green
Write-Host "==================" -ForegroundColor Green
Write-Host "Passed: $($Result.PassedCount)" -ForegroundColor Green
Write-Host "Failed: $($Result.FailedCount)" -ForegroundColor Red
Write-Host "Total:  $($Result.TotalCount)" -ForegroundColor Blue

if ($Result.FailedCount -gt 0) {
    Write-Host ""
    Write-Host "❌ Some class tests failed" -ForegroundColor Red
    exit 1
} else {
    Write-Host ""
    Write-Host "✅ All class tests passed!" -ForegroundColor Green
    exit 0
}
