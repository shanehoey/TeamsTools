# if ($user.UsageLocation -ne $Item.UsageLocation) { Write-warning -message "[Warning] $($Item.Identity) Location is $($user.UsageLocation) should be $($Item.UsageLocation)" -ErrorAction continue }

Write-Warning "$MyInvocation.MyCommand.Name is not implemented"