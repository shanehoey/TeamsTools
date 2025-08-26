#  if ($user.TeamsUpgradeEffectiveMode -ne "TeamsOnly") { Write-warning -message "[Warning] $($item.Identity) is $($user.TeamsUpgradeEffectiveMode)" }

Write-Warning "$MyInvocation.MyCommand.Name is not implemented"