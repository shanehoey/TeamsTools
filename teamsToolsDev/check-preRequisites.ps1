#Requires -Modules @{ ModuleName="MicrosoftTeams"; ModuleVersion="6.7.0" }
#Requires -Modules @{ ModuleName="Microsoft.Graph.authentication"; ModuleVersion="2.25.0" }
#Requires -Modules @{ ModuleName="Microsoft.Graph.Identity.DirectoryManagement"; ModuleVersion="2.25.0" }
#Requires -Modules @{ ModuleName="Microsoft.Graph.Groups"; ModuleVersion="2.25.0" }
#Requires -Modules @{ ModuleName="Microsoft.Graph.Users"; ModuleVersion="2.25.0" }
#Requires -Modules @{ ModuleName="ExchangeOnlineManagement"; ModuleVersion="2.0.4" }
# Requires -Modules @{ ModuleName="TeamsTools"; ModuleVersion="1.0.1" }
# Requires -Modules @{ ModuleName="TeamsToolsDefaults"; ModuleVersion="1.0.1" }
# Requires -Modules @{ ModuleName="TeamsToolsReset"; ModuleVersion="1.0.1" }cd..
# Requires -Modules @{ ModuleName="TeamsToolsDev"; ModuleVersion="1.0.1" }

#Pre-requisites

<#
Install-Module -Name Microsoft.Graph -Force -AllowClobber -Scope AllUsers
Install-Module -Name Microsoft.Graph.Authentication -Force -AllowClobber -Scope AllUsers
Install-Module -Name Microsoft.Graph.Domains -Force -AllowClobber -Scope AllUsers
Install-Module -Name Microsoft.Graph.Groups -Force -AllowClobber -Scope AllUsers
Install-Module -Name Microsoft.Graph.Users -Force -AllowClobber -Scope AllUsers
Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber -Scope AllUsers

Install-Module -Name TeamsTools -Force -AllowClobber -Scope AllUsers
Install-Module -Name TeamsToolsDefaults -Force -AllowClobber -Scope AllUsers
Install-Module -Name TeamsToolsReset -Force -AllowClobber -Scope AllUsers
Install-Module -Name TeamsToolsDev -Force -AllowClobber -Scope AllUsers
#>