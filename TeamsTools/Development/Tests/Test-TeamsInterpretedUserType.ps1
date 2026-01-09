#                    if (($user.InterpretedUserType -ne "HybridOnlineTeamsOnlyUser") -and  ($user.InterpretedUserType -ne "PureOnlineTeamsOnlyUser")) { Write-warning -message "[Warning] $($Item.Identity) InterpretedUserType is $($user.InterpretedUserType)" -ErrorAction continue }   

Write-warning "Not Implemented: $($PSCommandPath ?? $MyInvocation.MyCommand.Path)"