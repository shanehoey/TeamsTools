function Get-TeamsDomain{
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Low')]
    param (
        [Parameter(Mandatory=$false, ValueFromPipeline=$true)]
        [Alias("domain")]
        [string[]]$domainName
    )

    process {
        if ($PSCmdlet.ShouldProcess("Domains: $domainName", "Checking Teams Domain")) {
            try {
                $result = @()
                if ($domainName) {
                    foreach ($domain in $domainName) {
                        Write-Verbose "Checking domain: $domain"
                        try {
                            $result = Get-MgDomain -DomainId $domain -ErrorAction Stop
                        } catch {
                            Write-Warning "Domain '$domain' does not exist."
                        }
                    }
                } else {
                    Write-Verbose "Checking all domains"
                    $result = Get-MgDomain -ErrorAction Stop
                }
            } catch {
                Write-Error "Failed to find Domain: $_"
            }
            return $result
        }
    }
}
