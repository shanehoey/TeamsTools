Function Get-TeamsDomainConfigurationRecord {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param (
      [Parameter(Mandatory=$false)]
      [Alias('domain')]
      [string[]]$domainName
    )

    if ($PSCmdlet -and -not $PSCmdlet.ShouldProcess('Domains', 'Retrieve domain configuration records')) {
        Write-Verbose "Skipping retrieval of domain configuration records because ShouldProcess returned false."
        return
    }

    if (-not $domainName) {
      $domainName = (Get-MgDomain).Id
      }
    
    $results = @()

    foreach ($domain in $domainName) { 
      if ($domain -notlike "*.onmicrosoft.com") {
        try {

              $records = Get-MgDomainServiceConfigurationRecord -DomainId $domain | Select-Object Label,RecordType,SupportedService,Ttl,AdditionalProperties

              foreach ($record in $records ){
                      switch ($record.RecordType) {
                        "MX" { $results += [DnsRecord]::new($record.SupportedService, $record.RecordType, $record.label, $record.AdditionalProperties.mailExchange,$record.Ttl,$record.AdditionalProperties.preference )}
                        "SRV" { $results += [DnsRecord]::new($record.SupportedService,$record.RecordType, $record.label, $record.AdditionalProperties.nameTarget,$record.Ttl,$record.AdditionalProperties.priority,$record.AdditionalProperties.port,$record.AdditionalProperties.service,$record.AdditionalProperties.protocol,$record.AdditionalProperties.weight ) }
                        "CNAME" { $results += [DnsRecord]::new($record.SupportedService,$record.RecordType, $record.label, $record.AdditionalProperties.canonicalName,$record.Ttl) }
                        "TXT" { $results += [DnsRecord]::new($record.SupportedService,$record.RecordType, $record.label, $record.AdditionalProperties.text,$record.Ttl) }
                        default { $results += [DnsRecord]::new($record.SupportedService,$record.RecordType, $record.label, $record.AdditionalProperties,$record.Ttl) }
                      }
                }

          } catch {
          Write-Warning "Domain '$domain' does not exist or an error occurred:"
        }
    }
  }
  
  return $results
}
