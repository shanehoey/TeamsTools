#                    if (($user.InterpretedUserType -ne "HybridOnlineTeamsOnlyUser") -and  ($user.InterpretedUserType -ne "PureOnlineTeamsOnlyUser")) { Write-warning -message "[Warning] $($Item.Identity) InterpretedUserType is $($user.InterpretedUserType)" -ErrorAction continue }   


Write-Warning "$MyInvocation.MyCommand.Name is not implemented"