function get-teamsDomainConfigurationRecord {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
      [Parameter(Mandatory=$false)]
      [string[]]$domains
    )
    
    if (-not $domains) {
      $domains = (Get-MgDomain).Id
    }
    
    $results = @()
    
    foreach ($domain in $domains) {
      if ($domain -notlike "*.onmicrosoft.com") {
        try {

        $ServiceConfigurationRecords = Get-MgDomainServiceConfigurationRecord -DomainId $domain |select-object SupportedService,RecordType,label,ttl,AdditionalProperties
      
        foreach ($record in $ServiceConfigurationRecords ){
                $results += [PSCustomObject]@{
                    DomainID = $domain
                    ServiceConfiguration = @(Get-MgDomainServiceConfigurationRecord -DomainId $domain | sort-object SupportedService | select-object SupportedService,RecordType,label,ttl,AdditionalProperties)
                    SupportedService = $record.SupportedService
                    RecordType =$record.RecordType
                    Label = $record.label
                    TTL = $record.ttl
                    type = $record.AdditionalProperties."@odata.RecordType"

                  }
          }

        } catch {
          Write-Warning "Domain '$domain' does not exist or an error occurred:"
        }
      }
    }
    
    return $results
  }
  


 