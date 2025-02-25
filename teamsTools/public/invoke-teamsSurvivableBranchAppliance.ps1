Function invoke-teamsSurvivableBranchAppliance {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (    
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualSurvivableBranchAppliance]]$VirtualSurvivableBranchAppliance
    )
 
    Begin { }
    Process {
        foreach ($Item in $VirtualSurvivableBranchAppliance) {
            try {
                $params = @{ }
                $params.Add("identity", $Item.identity)
                if($item.site){$params.Add("site", $Item.site)}
                if($item.description){$params.Add("description", $Item.description)}
       
                $tenant = Get-CsTeamsSurvivableBranchAppliance -Identity $($Item.identity) -ErrorAction SilentlyContinue

                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$tenant} | Convertto-json -depth 10)

                if ($tenant.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating TeamsSurvivableBranchAppliance")) { Set-CsTeamsSurvivableBranchAppliance @params -ErrorAction Stop }} 
                elseif ($tenant.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating TeamsSurvivableBranchAppliance")) { New-CsTeamsSurvivableBranchAppliance @params -ErrorAction Stop }}
                else { throw "Unknown SBA for $($Item.identity)" }}
            catch { write-warning "[Error] $item.identity $($_.exception.message)" -WarningAction continue }
        } 
    }
    End {}
}

