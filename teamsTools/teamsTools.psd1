@{

# Script module or binary module file associated with this manifest.
RootModule = 'teamsTools.psm1'

# Version number of this module.
# Major/Minor/Build
ModuleVersion = '2.0.0'

# Supported PSEditions
CompatiblePSEditions = @('Core')

# ID used to uniquely identify this module
GUID = '89094aae-3ad4-4ee9-8367-af85f8120cf8'

# Author of this module
Author = 'Shane Hoey'

# Company or vendor of this module
# CompanyName = ''

# Copyright statement for this module
Copyright = '(c) 2016-2025 Shane Hoey. All rights reserved.'

# Description of the functionality provided by this module
Description = 'A module for managing Microsoft Teams, in particular to extend the funtionality of the Direct Routing Cmdlets'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '7.2'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(
    @{
        ModuleName = 'MicrosoftTeams'
        ModuleVersion = '6.8.0'
    },
    @{
        ModuleName = 'Microsoft.Graph.authentication'
        ModuleVersion = '2.26.1'
    },
    @{
        ModuleName = 'Microsoft.Graph.Applications'
        ModuleVersion = '2.26.1'
    },
    @{
       ModuleName = 'Microsoft.Graph.Identity.DirectoryManagement'
       ModuleVersion = '2.26.1'
    },
    @{
       ModuleName = 'Microsoft.Graph.Identity.Governance'
       ModuleVersion = '2.26.1'
    },
    @{
        ModuleName = 'Microsoft.Graph.Groups'
        ModuleVersion = '2.26.1'
    },
    @{
        ModuleName = 'Microsoft.Graph.Users'
        ModuleVersion = '2.26.1'
    },  
    @{
        ModuleName = 'ExchangeOnlineManagement'
        ModuleVersion = '3.7.1'
    }
)

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
# FunctionsToExport =  @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
# CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
# AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = @("teamsTools.psm1", "teamsTools.psd1", "LICENSE.txt")

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'shanehoey','MicrosoftTeams','DirectRouting'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/shanehoey/TeamsTools/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/shanehoey/TeamsTools/'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/shanehoey/TeamsTools/blob/master/README.md'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}
