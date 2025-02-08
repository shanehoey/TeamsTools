class VoiceNormalisationRule {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.]{1,32}$")]
    [string]$identity

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(global|[A-Z]{2})$")]
    [string]$countryCode

    [ValidateNotNullOrEmpty()]
    [ValidateSet("Emergency", "Internal", "Local", "National", "Service", "International")]
    [string]$type
    
    [ValidateNotNullOrEmpty()]
    [string]$pattern

    [ValidateNotNullOrEmpty()]
    [string]$translation

    [AllowNull()]
    [string]$areaCode

    VoiceNormalisationRule([string]$identity, [string]$countryCode, [string]$type, [string]$pattern, [string]$translation, [string]$areaCode) {
        $this.identity = $identity
        $this.countryCode = $countryCode
        $this.type = $type
        $this.pattern = $pattern
        $this.translation = $translation
        $this.areaCode = $areaCode
    }

    VoiceNormalisationRule([string]$identity, [string]$countryCode, [string]$type, [string]$pattern, [string]$translation) {
        $this.identity = $identity
        $this.countryCode = $countryCode
        $this.type = $type
        $this.pattern = $pattern
        $this.translation = $translation
        $this.areaCode = $null
    }
}

class voiceRoute {

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^[a-zA-Z0-9_.]{1,32}$")]
    [string]$identity

    [ValidateNotNullOrEmpty()]
    [ValidatePattern("^(global|[A-Z]{2})$")]
    [string]$countryCode

    [ValidateNotNullOrEmpty()]
    [ValidateSet("Emergency", "Internal", "Local", "National", "Service", "International")]
    [string]$type
    
    [ValidateNotNullOrEmpty()]
    [string]$pattern

    voiceRoute([string]$identity, [string]$countryCode, [string]$type, [string]$pattern) {
        $this.identity = $identity
        $this.countryCode = $countryCode
        $this.Type = $type
        $this.Pattern = $pattern
    }
}
