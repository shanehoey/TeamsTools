function add-teamsM365Domain {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
      [Parameter(Mandatory=$true)]
      [string[]]$domain
    )

    if ($PSCmdlet.ShouldProcess("Domain: $domain", "Adding Teams Domain")) {
        $ErrorActionPreference = "Stop"

        try {
            $results = @()

            foreach ($d in $domain) {
            $result = [PSCustomObject]@{
              DomainID = (New-MgDomain -AuthenticationType Managed -id $d -IsAdminManaged -IsDefault -ErrorAction Stop).Id
              AdditionalPropertiesText = (Get-MgDomainVerificationDnsRecord -DomainId $d -erroraction stop | Where-Object {$_.RecordType -eq "Txt"}).AdditionalProperties.text
            }
            $results += $result
              }
              
              return $results

        } catch {

            Write-Error "Failed to add Domain to M365 : $_.Exception.Message"
            
        }

    }
}
