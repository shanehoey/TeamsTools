Function Confirm-TeamsDomainConfigurationRecord {
  [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
  param (
    [Parameter(Mandatory=$true)]
    [Alias("domain")]
    [string[]]$domainName
  )
  if ($PSCmdlet.ShouldProcess("Domain: $domainName", "Confirming Teams Domain Configuration")) {

    Write-warning -Message "Currently due to  limitation in the Microsoft Graph API, this function is not supported. Please use the Microsoft 365 Admin Center to verify the domain configuration."

    return $null
  } 
  else {
    Write-Verbose "No domain name provided or ShouldProcess is false. Skipping confirmation."
    return $null
  }

}