# if ($user.OnPremHostingProvider -eq "SRV:") { Write-warning -message "[Warning] $($Item.Identity) OnPremHostingProvider is $($user.OnPremHostingProvider)" -ErrorAction continue }   

Write-warning "Not Implemented: $($PSCommandPath ?? $MyInvocation.MyCommand.Path)"