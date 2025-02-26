# DOC Documentation set-teamsvirtualtopologyoverride
Function Set-TeamsVirtualTopologyOverride {
    [CmdletBinding(ConfirmImpact = 'medium')]
    param (
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$PstnGateway,
        [Parameter(Position = 1, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$OverridePstnGateway,
        [Parameter(Position = 2, Mandatory = $true, ParameterSetName = "Default", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$OverridePstnGatewayPort,
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "User", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$UserIdentity,
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "User", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$OverrideUserIdentity,
        [Parameter(Position = 0, Mandatory = $true, ParameterSetName = "User", ValueFromPipeline = $False)]
        [ValidateNotNullOrEmpty()]
        [string]$OverrideUserTelephone
        )

    Begin { }
    Process {
        try 
        {
            if($PSBoundParameters.ContainsKey('PstnGateway')) {
                    foreach ($item in $topology.pstngateway) {
                        if ($item.identity -eq $pstnGateway) 
                        {  
                            $item.Identity = $OverridePstnGateway
                            $item.SipSignalingPort = $OverridePstnGatewayPort
                            Write-Information -MessageData "Updating PstnGateway $PstnGateway -> $OverridePstnGateway"
                        }
                        if ($item.proxysbc -eq $pstnGateway) 
                        {  
                            $item.proxysbc = $OverridePstnGateway
                            Write-Information -MessageData "Updating Proxy $PstnGateway -> $OverridePstnGateway"
                        }
                    }

                    foreach ($item in $topology.voiceroute){
                        if($item.PstnGatewaylist -contains $PstnGateway) {
                            $item.PstnGatewaylist = $item.PstnGatewaylist.replace($PstnGateway,$OverridePstnGateway) 
                            Write-Information -MessageData "Updating VoiceRoute $PstnGateway -> $OverridePstnGateway" 
                        }
                    }
            }
            if($PSBoundParameters.ContainsKey('UserIdentity')) {
                foreach ($item in $topology.user) {
                    if ($item.identity -eq $UserIdentity) 
                    {  
                        $item.Identity = $OverrideUserIdentity
                        $item.TelephoneNumber = $OverrideUserTelephone
                    }
                }
            }  
        }
        catch { Write-warning -Message "***** Override not successful *****" -WarningAction Continue }
    }
    End { }
}  
