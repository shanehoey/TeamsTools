function Get-TeamsDomain{
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Low')]
    param (
        [Parameter(Mandatory=$false, ValueFromPipeline=$true)]
        [Alias("Domain")]
        [string[]]$Domains
    )

    process {
        if ($PSCmdlet.ShouldProcess("Domains: $Domains", "Checking Teams Domain")) {
            try {
                $result = @()
                if ($Domains) {
                    foreach ($domain in $Domains) {
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
