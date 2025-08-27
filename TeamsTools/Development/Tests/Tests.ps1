
# Standard validation function for VirtualTopology existence
function Test-VirtualTopology {
    [CmdletBinding()]
    param()
    
    if (-not $script:VirtualTopology) {
        throw "Teams VirtualTopology not found. Please create a new VirtualTopology with New-TeamsVirtualTopology."
    }
    return $true
}

# Validation function for checking if an object exists in a collection
function Test-ObjectExists {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [array]$Collection,
        
        [Parameter(Mandatory)]
        [string]$PropertyName,
        
        [Parameter(Mandatory)]
        [string]$Value,
        
        [Parameter(Mandatory)]
        [string]$ObjectType
    )
    
    $exists = $Collection.$PropertyName -contains $Value
    if (-not $exists) {
        throw "$ObjectType '$Value' not found in VirtualTopology."
    }
    return $true
}

# Validation function for checking if an object doesn't exist (for Add operations)
function Test-ObjectNotExists {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [array]$Collection,
        
        [Parameter(Mandatory)]
        [string]$PropertyName,
        
        [Parameter(Mandatory)]
        [string]$Value,
        
        [Parameter(Mandatory)]
        [string]$ObjectType
    )
    
    $exists = $Collection.$PropertyName -contains $Value
    if ($exists) {
        throw "$ObjectType '$Value' already exists in VirtualTopology."
    }
    return $true
}
