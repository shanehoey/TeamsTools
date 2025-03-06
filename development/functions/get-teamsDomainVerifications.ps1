function get-teamsDomainVerification {
  [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
  param (
    [Parameter(Mandatory=$true)]
    [string[]]$domain
  )
  
  $results = @()
  
  foreach ($d in $domain) {
    $result = [PSCustomObject]@{
      DomainID = (New-MgDomain -AuthenticationType Managed -id $d -IsAdminManaged -IsDefault).Id
      AdditionalPropertiesText = (Get-MgDomainVerificationDnsRecord -DomainId $d | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text
    }
    $results += $result
  }
  
  return $results
}
