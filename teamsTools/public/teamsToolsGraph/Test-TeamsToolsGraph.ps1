<#
.SYNOPSIS
    Tests the connection to Microsoft Graph for Teams Tools.

.DESCRIPTION
    This function tests the connection to Microsoft Graph for Teams Tools by checking the specified domain or tenant ID, or by performing a default check if no parameters are provided.

.PARAMETER domain
    The domain to check against Microsoft Graph.

.PARAMETER tenantID
    The tenant ID to check against Microsoft Graph.

.PARAMETER default
    Switch parameter to perform a default check if no domain or tenant ID is provided.

.EXAMPLE
    Test-TeamsToolsGraph -domain "example.com"
    Tests the connection to Microsoft Graph for the specified domain.

.EXAMPLE
    Test-TeamsToolsGraph -tenantID "12345678-1234-1234-1234-123456789012"
    Tests the connection to Microsoft Graph for the specified tenant ID.

.EXAMPLE
    Test-TeamsToolsGraph -default
    Performs a default check to test the connection to Microsoft Graph.

.NOTES
    This function requires the Microsoft Graph PowerShell SDK to be installed and authenticated.

#>
Function Test-TeamsToolsGraph {
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
                if(Get-MgDomain -Filter "id eq '$domain'" -ErrorAction stop){return $true}
        } elseif ($tenantID) {
                if (Get-MgOrganization -ErrorAction Stop | Where-Object { $_.Id -eq $tenantID }) { return $true}
        } else {
            if (Get-MgOrganization -ErrorAction Stop) { return $true }
        }
    } catch {
        return $false
    }

}