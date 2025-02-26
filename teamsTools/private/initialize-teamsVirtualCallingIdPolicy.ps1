# DOC Docmentation initialize-teamsVirtualCallingIdPolicy
# TODO  Needs to also do testing 



Function initialize-teamsVirtualCallingIdPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [Boolean] $BlockIncomingPstnCallerID,
    [String] $CallingIDSubstitute,
    [String] $CompanyName,	
    [Boolean] $EnableUserOverride,	
    [String] $ResourceAccount,
    [String] $ServiceNumber,
    [string] $Description
    )

    try {

        $Item = [CallingIDPolicy]::new($Identity)
        
        if ($BlockIncomingPstnCallerID){$item.BlockIncomingPstnCallerID = $BlockIncomingPstnCallerID}
        if ($CallingIDSubstitute){$item.CallingIDSubstitute = $CallingIDSubstitute}
        if ($CompanyName){$item.CompanyName = $CompanyName}
        if ($Description){$item.Description = $Description}
        if ($EnableUserOverride){$item.EnableUserOverride = $EnableUserOverride}
        if ($ResourceAccount){$item.ResourceAccount = $ResourceAccount}
        if ($ServiceNumber){$item.ServiceNumber = $ServiceNumber}
        if ($Description){$item.Description = $Description}

        return $item

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
