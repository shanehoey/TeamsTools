# ...existing code...
function Get-TeamsToolsGraph {
    <#
    .SYNOPSIS
    Retrieve organization info from Microsoft Graph.

    .DESCRIPTION
    Returns tenant id and verified domains for a tenant. Use -Domain to find org by domain, -TenantId to find by tenant id,
    or call with no parameters to return the current organization(s).

    .PARAMETER Domain
    The domain to look up.

    .PARAMETER TenantId
    The tenant id to look up.

    .EXAMPLE
    Get-TeamsToolsGraph -Domain "example.com"
    .EXAMPLE
    Get-TeamsToolsGraph -TenantId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'ByDomain')]
        [ValidateNotNullOrEmpty()]
        [string]$Domain,

        [Parameter(Mandatory = $true, ParameterSetName = 'ByTenantId')]
        [ValidateNotNullOrEmpty()]
        [string]$TenantId
    )

    begin {
        $result = $null
    }

    process {
        try {
            switch ($PSCmdlet.ParameterSetName) {

                'ByDomain' {
                    try {
                        # Verify the domain exists (throws on auth/network errors)
                        $domainObj = Get-MgDomain -Filter "id eq '$Domain'" -ErrorAction Stop
                    } catch {
                        $errMsg = if ($_.Exception) { $_.Exception.Message } else { $_.ToString() }
                        if ($errMsg -match 'Authentication') {
                            Write-Error -Message "Authentication required. Please run Connect-TeamsToolsMSGraph." -Category AuthenticationError
                            return
                        }

                        # Domain not found or other error
                        Write-Warning -Message "No organization found for domain '$Domain': $errMsg"
                        return
                    }

                    # If domain verification succeeded, return organization(s)
                    try {
                        $result = Get-MgOrganization -ErrorAction Stop |
                                  Select-Object @{Name='TenantID';Expression={$_.Id}},
                                                @{Name='Tenant';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}
                    } catch {
                        Write-Error -Message "Failed to retrieve organization information: $($_.Exception.Message)" -Category NotSpecified
                        return
                    }
                }

                'ByTenantId' {
                    try {
                        $orgs = Get-MgOrganization -ErrorAction Stop
                    } catch {
                        if ($_.Exception.Message -match 'Authentication') {
                            Write-Error -Message "Authentication required. Please run Connect-TeamsToolsMSGraph." -Category AuthenticationError
                            return
                        }
                        Write-Error -Message "Failed to retrieve organizations: $($_.Exception.Message)" -Category NotSpecified
                        return
                    }

                    $result = $orgs | Where-Object { $_.Id -eq $TenantId } |
                              Select-Object @{Name='TenantID';Expression={$_.Id}},
                                            @{Name='Tenant';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}

                    if (-not $result) {
                        Write-Warning -Message "No organization found with tenant ID '$TenantId'."
                        return
                    }
                }

                'Default' {
                    try {
                        $result = Get-MgOrganization -ErrorAction Stop |
                                  Select-Object @{Name='TenantID';Expression={$_.Id}},
                                                @{Name='Tenant';Expression={($_.VerifiedDomains | Select-Object -ExpandProperty Name) -join ', '}}
                    } catch {
                        if ($_.Exception.Message -match 'Authentication') {
                            Write-Error -Message "Authentication required. Please run Connect-TeamsToolsMSGraph." -Category AuthenticationError
                            return
                        }
                        Write-Error -Message "Failed to retrieve organization information: $($_.Exception.Message)" -Category NotSpecified
                        return
                    }
                }
            }
        } catch {
            Write-Error -Message "Unexpected error: $($_.Exception.Message)" -Category NotSpecified
            return
        }
    }

    end {
        return $result
    }
}
# ...existing code...