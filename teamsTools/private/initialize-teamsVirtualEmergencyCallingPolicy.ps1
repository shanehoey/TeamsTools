# DOC Documentation initialize-teamsVirtualEmergencyCallingPolicy
Function initialize-teamsVirtualEmergencyCallingPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity	,
    [ValidateNotNullOrEmpty()][string] $Description
    )

    try {

        $Item = [VirtualEmergencyCallingPolicy]::new($Identity)
        if ($Description){$item.Description = $Description}

        return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}


