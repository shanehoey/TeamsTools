function get-teamsDomain {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
        [string]$domain
    )

    if ($PSCmdlet.ShouldProcess("Domain: $domain", "Adding Teams Domain")) {
      
        try {

            if ($domain) {
                $result = Get-MgDomain -DomainId $domain -erroraction Stop
            } else {
                $result = Get-MgDomain -erroraction Stop
            }
  
        } catch {
            Write-Error "Failed to add Teams Domain: $_.Exception.Message"
        }

        if ($result -is [array]) {
            return $result | ForEach-Object {
            [pscustomobject]@{
                Id                = $_.Id
                IsDefault         = $_.IsDefault
                SupportedServices = $_.SupportedServices
            }
            }
        } else {
            return [pscustomobject]@{
            Id                = $result.Id
            IsDefault         = $result.IsDefault
            SupportedServices = $result.SupportedServices
            }
        }

    }
}
