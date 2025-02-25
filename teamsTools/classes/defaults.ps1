# TeamsTools
# https://github.com/shanehoey/TeamsTools

<#
    Copyright (c) 2016-2025 Shane Hoey

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#>

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

