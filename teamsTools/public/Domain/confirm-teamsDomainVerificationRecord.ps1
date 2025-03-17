function confirm-teamsDomainVerificationRecord {
    param (
        [Parameter(Mandatory=$false, ValueFromPipeline=$true)]
        [Alias("Domain")]
        [string[]]$domains
    )

    if (-not $domains) {
        $domains = Get-MgDomain | Where-Object { -not $_.IsVerified } | Select-Object -ExpandProperty Id
    }

    if (-not $domains) {
        Write-Warning "No domains provided. All domains are already verified."
    } else {
        foreach ($domain in $domains) {
            try {
                $result = confirm-MgDomain -DomainId $domain -ErrorAction stop

            } catch {
                Write-Error "Failed to confirm domain: $domain. $_.exception.message"
            }
        }

    }
}
