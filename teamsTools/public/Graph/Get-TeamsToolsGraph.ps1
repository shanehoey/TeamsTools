<#
.SYNOPSIS
Retrieves information about Microsoft 365 organizations using Microsoft Graph.

.DESCRIPTION
The Get-TeamsToolsGraph function retrieves information about Microsoft 365 organizations based on the specified domain or tenant ID. If no parameters are provided, it retrieves information about the current organization.

.PARAMETER domain
Specifies the domain of the organization to retrieve information for. This parameter is optional.

.PARAMETER tenantID
Specifies the tenant ID of the organization to retrieve information for. This parameter is optional.

.PARAMETER default
Specifies whether to use the default parameter set. This parameter is optional.

.EXAMPLE
Get-TeamsToolsGraph -domain "example.com"
Retrieves information about the organization with the specified domain.

.EXAMPLE
Get-TeamsToolsGraph -tenantID "12345678-1234-1234-1234-123456789012"
Retrieves information about the organization with the specified tenant ID.

.EXAMPLE
Get-TeamsToolsGraph
Retrieves information about the current organization.

.NOTES
This function requires the Microsoft Graph PowerShell module to be installed and authenticated.

#>
Function Get-TeamsToolsGraph {
    [CmdletBinding(SupportsShouldProcess=$false, ConfirmImpact = 'low',DefaultParameterSetName = 'default')]

    param (
        [Parameter(Mandatory=$false, ParameterSetName='ByDomain')]
        [string]$domain,

        [Parameter(Mandatory=$false, ParameterSetName='ByTenantID')]
        [string]$tenantID,

        [Parameter(Mandatory=$false, ParameterSetName='default')]
        [switch]$default

    )
    
    try {

        if ($domain) {
            try {
                
                if (Get-MgDomain -Filter "id eq '$domain'" -ErrorAction stop) {
                    $result = Get-MgOrganization -ErrorAction Stop | Select-Object @{Name='TenantID';Expression={$_.id}}, @{Name='Tenant';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}
                } 
            
            } catch {
                if ($_.Exception.Message -match "Authentication needed") {
                    Write-Error -Message "Authentication is required, Please authenticate with Connect-TeamsToolsMSGraph."
                } else {
                    Write-Error -Message "No organization found with the specified domain: $domain "
                }
            }

        } elseif ($tenantID) {

            try {
                $result = Get-MgOrganization -ErrorAction Stop | Where-Object { $_.Id -eq $tenantID } | Select-Object @{Name='TenantID';Expression={$_.id}}, @{Name='Tenant';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}
            } catch {
                if ($_.Exception.Message -match "Authentication needed") {
                    Write-Error -Message "Authentication is required, Please authenticate with Connect-TeamsToolsMSGraph."
                } else {
                    Write-Error -Message "No organization found with the specified tenant ID: ${$tenantID}: $_"
                }
            }
  
        } else {

            try {
                $result = Get-MgOrganization -ErrorAction Stop | Select-Object @{Name='TenantID';Expression={$_.id}}, @{Name='Tenant';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}
            } catch {
                if ($_.Exception.Message -match "Authentication needed") {
                    Write-Error -Message "Authentication is required, Please authenticate with Connect-TeamsToolsMSGraph."
                } else {
                    Write-Error -Message "Error occurred confirming the connection: $_"
                }

            } 
            
        }
    } catch {
            Write-Error -Message "$_"
    }
    return $result
}