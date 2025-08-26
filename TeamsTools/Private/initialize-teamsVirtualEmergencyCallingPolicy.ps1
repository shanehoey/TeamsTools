# DOC Documentation initialize-teamsVirtualEmergencyCallingPolicy
# INVESTIGATE  should these function do any cross checking or just create the new object ? 

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


