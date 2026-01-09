#  if ($user.TeamsUpgradeEffectiveMode -ne "TeamsOnly") { Write-warning -message "[Warning] $($item.Identity) is $($user.TeamsUpgradeEffectiveMode)" }

Write-warning "Not Implemented: $($PSCommandPath ?? $MyInvocation.MyCommand.Path)"