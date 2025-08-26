Function Add-TeamsDomain {
  [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'medium')]
  param (
    [Parameter(Mandatory=$true)]
    [Alias("domain")]
    [string[]]$domainName
  )

  if ($PSCmdlet.ShouldProcess("Domain: $domainName", "Adding Teams Domain")) {

    $results = @()

    foreach ($domain in $domainName) {
      try {
        $result = [PSCustomObject]@{
          DomainID = (New-MgDomain -AuthenticationType Managed -id $domain -IsAdminManaged -IsDefault -ErrorAction Stop).Id
          AdditionalPropertiesText = (Get-MgDomainVerificationDnsRecord -DomainId $domain -erroraction stop | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text
        }
        $results += $result
      } catch {
        # Generic catch all
        Write-Error "Unexpected error adding domain $domain : $($_.Exception.Message)"
      }
    }
        
    return $results
  }
}
