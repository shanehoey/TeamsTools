# if ($user.UsageLocation -ne $Item.UsageLocation) { Write-warning -message "[Warning] $($Item.Identity) Location is $($user.UsageLocation) should be $($Item.UsageLocation)" -ErrorAction continue }

Write-warning "Not Implemented: $($PSCommandPath ?? $MyInvocation.MyCommand.Path)"