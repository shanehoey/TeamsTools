Function Get-TeamsToolsMSGraph {
    [CmdletBinding(SupportsShouldProcess=$false, ConfirmImpact = 'low',DefaultParameterSetName = 'default')]

    param (
        [Parameter(Mandatory=$false, ParameterSetName='ByDomain')]
        [string]$domain,

        [Parameter(Mandatory=$false, ParameterSetName='ByTenantID')]
        [string]$tenantID,

        [Parameter(Mandatory=$false, ParameterSetName='ByDomain')]
        [Parameter(Mandatory=$false, ParameterSetName='ByTenantID')]
        [Parameter(Mandatory=$false, ParameterSetName='default')]
        [switch]$quiet

    )
    
    try {

        if ($domain) {
            $result = Get-MgDomain -Filter "id eq '$domain'" -ErrorAction stop | Select-Object @{Name='TenantID';Expression={$_.id}}, @{Name='Domains';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}
            if (-not $result) {
                if ($quiet) {
                    return $false
                } else {
                    throw "No organization found with the specified domain: $domain"
                }
            } else { 
                if ($quiet) {
                    return $true
                } else {
                    Get-MgOrganization | Select-Object @{Name='TenantID';Expression={$_.id}}, @{Name='Tenant';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}
                }
            }

        } elseif ($tenantID) {
            $result = Get-MgOrganization -ErrorAction stop | Where-Object { $_.Id -eq $tenantID }
            if (-not $result) {
                if ($quiet) {
                    return $false
                } else {
                    throw "No organization found with the specified tenant ID: $tenantID"
                }
            } else { 

                if ($quiet) {
                    return $true
                } else {
                    $result | Select-Object @{Name='TenantID';Expression={$_.id}}, @{Name='Tenant';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}
                } 
            }

        } else {
            $result = Get-MgOrganization  -ErrorAction stop | Select-Object @{Name='TenantID';Expression={$_.id}}, @{Name='Tenant';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}
            if (-not $result) {
                throw "No organizations found"
            } else { 
                $result
            }
        }
    } catch {
        Write-Error -message "Error occurred confirming the organisation"
    }
}