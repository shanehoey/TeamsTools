# DOC Documentation add-teamsVirtualCallingIdPolicy
# IMPROVEMENT Add support for SupportsShouldProcess
Function Add-TeamsVirtualCallingIdPolicy {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
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

        if ($script:VirtualTopology.CallingLineIdentity.Identity -contains $Identity) {
            throw "Identity $Identity exists in VirtualTopology."
        }

        if ($PSCmdlet.ShouldProcess("VirtualTopology CallingIDPolicy '$Identity'","Add")) {
            $Item = initialize-teamsVirtualCallingIdPolicy -Identity $Identity
            if ($BlockIncomingPstnCallerID){$item.BlockIncomingPstnCallerID = $BlockIncomingPstnCallerID}
            if ($CallingIDSubstitute){$item.CallingIDSubstitute = $CallingIDSubstitute}
            if ($CompanyName){$item.CompanyName = $CompanyName}
            if ($Description){$item.Description = $Description}
            if ($EnableUserOverride){$item.EnableUserOverride = $EnableUserOverride}
            if ($ResourceAccount){$item.ResourceAccount = $ResourceAccount}
            if ($ServiceNumber){$item.ServiceNumber = $ServiceNumber}
            if ($Description){$item.Description = $Description}

            $script:VirtualTopology.CallingLineIdentity.Add($Item)
        } else {
            Write-Verbose "Skipping add of CallingIDPolicy '$Identity' (ShouldProcess declined or -WhatIf)."
        }

    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
}
