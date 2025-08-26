Function Remove-TeamsDomain {
  [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'high')]
  param (
    [Parameter(Mandatory=$true)]
    [Alias("domain")]
    [string[]]$domainName
  )

  if ($PSCmdlet.ShouldProcess("Domain: $domainName", "Removing Teams Domain")) {

    $results = @()

    foreach ($domain in $domainName) {
      try {
        $result = [PSCustomObject]@{
            DomainID = (Remove-MgDomain -DomainId $domain -ErrorAction Stop).I
        }
        $results += $result
      } catch {
        Write-Error "Failed to remove Domain $domain : $_.Exception.Message"
      }
    }
        
    return $results
  }
}
