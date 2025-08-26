# if ($user.OnPremHostingProvider -eq "SRV:") { Write-warning -message "[Warning] $($Item.Identity) OnPremHostingProvider is $($user.OnPremHostingProvider)" -ErrorAction continue }   

Write-Warning "$MyInvocation.MyCommand.Name is not implemented"