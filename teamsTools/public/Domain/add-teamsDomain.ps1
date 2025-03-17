function add-teamsDomain {
  [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'medium')]
  param (
    [Parameter(Mandatory=$true)]
    [Alias("domain")]
    [string[]]$domains
  )

  if ($PSCmdlet.ShouldProcess("Domain: $domains", "Adding Teams Domain")) {
    
    $results = @()

    foreach ($domain in $domains) {
      try {
        $result = [PSCustomObject]@{
          DomainID = (New-MgDomain -AuthenticationType Managed -id $domain -IsAdminManaged -IsDefault -ErrorAction Stop).Id
          AdditionalPropertiesText = (Get-MgDomainVerificationDnsRecord -DomainId $domain -erroraction stop | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text
        }
        $results += $result
      } catch {
        Write-Error "Failed to add Domain $domain to M365"
      }
    }
        
    return $results
  }
}
