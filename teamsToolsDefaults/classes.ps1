class defaultVoiceNormalisationRule {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(global|[A-Z]{2})$")]
    [string]$countryCode

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.\s]{1,32}$")]
    [string]$displayName

    [ValidateNotNullOrEmpty()]
    [ValidateSet("Emergency", "Internal", "Local", "National", "Service", "International")]
    [string]$type
    
    [ValidateNotNullOrEmpty()]
    [string]$pattern

    [ValidateNotNullOrEmpty()]
    [string]$translation

    [AllowNull()]
    [string]$areaCode

    defaultVoiceNormalisationRule([string]$countryCode, [string]$displayName, [string]$type, [string]$pattern, [string]$translation, [string]$areaCode) {
        $this.countryCode = $countryCode
        $this.displayName = $displayName
        $this.type = $type
        $this.pattern = $pattern
        $this.translation = $translation
        $this.areaCode = $areaCode
    }

    defaultVoiceNormalisationRule([string]$countryCode, [string]$displayName, [string]$type, [string]$pattern, [string]$translation) {
        $this.countryCode = $countryCode
        $this.displayName = $displayName
        $this.type = $type
        $this.pattern = $pattern
        $this.translation = $translation
        $this.areaCode = $null
    }
}

class defaultVoiceRoute {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(global|[A-Z]{2})$")]
    [string]$countryCode

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.\s]{1,32}$")]
    [string]$displayName

    [ValidateNotNullOrEmpty()]
    [ValidateSet("Emergency", "Internal", "Local", "National", "Service", "International")]
    [string]$type
    
    [ValidateNotNullOrEmpty()]
    [string]$pattern

    defaultVoiceRoute([string]$countryCode, [string]$displayName, [string]$type, [string]$pattern) {
        $this.countryCode = $countryCode
        $this.displayName = $displayName
        $this.type = $type
        $this.pattern = $pattern
    }

}

