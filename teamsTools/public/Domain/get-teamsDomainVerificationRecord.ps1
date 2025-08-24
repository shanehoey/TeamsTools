function get-teamsDomainVerificiationRecord {
  [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'low')]
  param (
    [Parameter(Mandatory=$false)]
    [Alias("domain")]
    [string[]]$domainName
  )

  if (-not $domainName) {
    $domainName = (Get-MgDomain).Id
  }
  
  $results = @()

  foreach ($domain in $domainName) {
    if ($domain -notlike "*.onmicrosoft.com") {
      try {
        $results += [PSCustomObject]@{
          DomainID = (Get-MgDomain -DomainId $domain -erroraction stop).Id
          AdditionalPropertiesText = (Get-MgDomainVerificationDnsRecord -DomainId $domain | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text
        }
      } catch {
        Write-Warning "Domain '$domain' does not exist or an error occurred:"
      }
    }
  }
  
  return $results
}
