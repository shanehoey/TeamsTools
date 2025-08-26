Function Confirm-TeamsDomainVerificationRecord {
    param (
        [Parameter(Mandatory=$false, ValueFromPipeline=$true)]
        [Alias("domain")]
        [string[]]$domainName
    )

    if (-not $domainName) {
        $domainName = Get-MgDomain | Where-Object { -not $_.IsVerified } | Select-Object -ExpandProperty Id
    }

    if (-not $domainName) {
        Write-Warning "No domains provided. All domains are already verified."
    } else {
        foreach ($domain in $domainName) {
            try {
                $result = confirm-MgDomain -DomainId $domain -ErrorAction stop

            } catch {
                Write-Error "Failed to confirm domain: $domain. $_.exception.message"
            }
        }

    }
}
