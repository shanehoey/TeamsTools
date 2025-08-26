# DOC Documentation invoke-teamsPstnUsage

Function invoke-teamsPstnUsage {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Generic.List[VirtualPstnUsage]]$VirtualPSTNusage
    )
    Begin { }
    Process {
        foreach ($Item in $VirtualPSTNusage) {
            try {
                $PstnUsage = (Get-CsOnlinePSTNUsage -ErrorAction SilentlyContinue).usage
                Write-Information -MessageData (@{ "Virtual"=$item;"Tenant"=$PstnUsage} | Convertto-json -depth 10)
                if (!( $PstnUsage | where-object { $_ -contains $Item.pstnusage })) {
                    if ($PSCmdlet.ShouldProcess("$($Item.pstnusage)", "Creating PstnUsage")){ Set-CsOnlinePstnUsage -Identity global -Usage @{add="$($Item.pstnusage)"} -erroraction stop }
                } else {
                    Write-Warning -message "PstnUsage $($Item.pstnusage) already exists"
                }
            } catch { Write-Warning -Message "[Error] PstnUsage $($Item.pstnusage)" }
        }
    }
    End { }    
}