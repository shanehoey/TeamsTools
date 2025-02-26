# DOC Documentation set-teamsvirtualvoiceNormalisation
Function set-teamsVirtualCallingIdPolicy {

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'low')]
    param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string] $Identity,
    [Boolean] $BlockIncomingPstnCallerID,
    [String] $CallingIDSubstitute,
    [String] $CompanyName,	
    [Boolean] $EnableUserOverride ,	
    [String] $ResourceAccount 	,
    [String] $ServiceNumber ,
    [string] $Description
    )

    try {
        if (-not $script:VirtualTopology) {
            throw "Teams VirtualTopology not found."
        }

        if ($script:VirtualTopology.CallingLineIdentity.Identity -notcontains $Identity) {
            throw "Identity $Identity not found in VirtualTopology."
        }

        $Item = $script:VirtualTopology.CallingLineIdentity | where-object {$_.Identity -eq $Identity}
        if ($BlockIncomingPstnCallerID){$item.BlockIncomingPstnCallerID = $BlockIncomingPstnCallerID}
        if ($CallingIDSubstitute){$item.CallingIDSubstitute = $CallingIDSubstitute}
        if ($CompanyName){$item.CompanyName = $CompanyName}
        if ($Description){$item.Description = $Description}
        if ($EnableUserOverride){$item.EnableUserOverride = $EnableUserOverride}
        if ($ResourceAccount){$item.ResourceAccount = $ResourceAccount}
        if ($ServiceNumber){$item.ServiceNumber = $ServiceNumber}
        if ($Description){$item.Description = $Description}

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
