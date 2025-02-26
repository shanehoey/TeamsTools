# DOC Documentation invoke-teamsSurvivableBranchAppliancePolicy

Function Invoke-TeamsSurvivableBranchAppliancePolicy {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (    
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualSurvivableBranchAppliancePolicy]]$VirtualSurvivableBranchAppliancePolicy
    )
 
    Begin { }
    Process {
        foreach ($Item in $VirtualSurvivableBranchAppliancePolicy) {
            try {
                $params = @{ }
                $params.Add("Identity", $Item.Identity)
                if($item.BranchApplianceFqdns){$params.Add("BranchApplianceFqdns", $Item.BranchApplianceFqdns)}


                $tenant = Get-CsTeamsSurvivableBranchAppliancePolicy -Identity $($Item.Identity) -ErrorAction SilentlyContinue

                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$tenant} | Convertto-json -depth 10)

                if ($tenant.count -eq 1) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Updating TeamsSurvivableBranchAppliancePolicy")) { Set-CsTeamsSurvivableBranchAppliancePolicy @params -ErrorAction Stop }} 
                elseif ($tenant.count -eq 0) { if ($PSCmdlet.ShouldProcess("$($Item.identity)", "Creating TeamsSurvivableBranchAppliancePolicy")) { New-CsTeamsSurvivableBranchAppliancePolicy @params -ErrorAction Stop }}
                else { throw "Unknown SBA Policy for $($Item.identity)" }}
            catch { write-warning "[Error] $item.identity $($_.exception.message)" -WarningAction continue }
        } 
    }
    End {}
}

