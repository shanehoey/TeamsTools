class DnsRecord {


    [ValidateSet("Email", "OfficeCommunicationsOnline", "SharepointDefaultDomain", "OrgIdAuthentication", "Intune")]
    [string]$ServiceType  #AAAA, A, CNAME, MX, SRV, TXT

    [ValidateSet("AAAA", "A", "CNAME", "MX", "SRV", "TXT")]
    [string]$Type #AAAA, A, CNAME, MX, SRV, TXT 

    [ValidatePattern("^[a-zA-Z0-9.-_]+\.[a-zA-Z]{2,}$")]
    [string]$Name #AAAA, A, CNAME, MX, SRV, TXT

    [ValidatePattern(".*")]
    [string]$Value      #AAAA, A, CNAME, MX, SRV, TXT


    [AllowNull()]
    [ValidateRange(0, 86400)]
    [Nullable[int]]$Ttl      #AAAA, A, CNAME, MX, SRV, TXT

    [AllowNull()]
    [ValidateRange(0, 86400)]
    [Nullable[int]]$Preference  #MX

    [AllowNull()]
    [ValidateRange(0, 86400)]
    [Nullable[int]]$Port        #SRV

    [AllowNull()]
    [ValidateRange(0, 86400)]
    [Nullable[int]]$Priority  #SRV

    [ValidateSet("_sip", "_sipfederationtls", "_tls", "_tcp")]
    [string]$Service     #SRV

    [ValidateSet("_tcp", "_udp", "_tls")]
    [string]$Protocol   #SRV
    
    [AllowNull()]
    [ValidateRange(0, 86400)]
    [Nullable[int]]$Weight #SRV


    DnsRecord () { }

    DnsRecord ([string]$ServiceType,[string]$Type, [string]$Name,[string]$Value, [int]$Ttl) {

        if ($Type -notmatch "^(AAAA|A|CNAME|TXT)$") { throw "Type must be one of the following: AAAA, A, CNAME, TXT." }
        switch ($Type) {
            "AAAA" { if ($value -notmatch "^[a-fA-F0-9:]+$") {throw "Value must be a valid IPv6 address."} }
            "A" { if ($value -notmatch "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$") {throw "Value must be a valid IPv4 address."} }
            "CNAME" { if ($value -notmatch "^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") {throw "Value must be a fully qualified domain name (FQDN)."} }
            "TXT" { if ($value -notmatch ".*") {throw "Value must be a valid TXT record."} }
        }  

        $this.ServiceType = $ServiceType.toUpper()
        $this.Type = $Type.ToUpper()
        $this.Name = $Name.ToLower()
        $this.Value = $value
        $this.Ttl = $ttl
    }

    DnsRecord ([string]$ServiceType,[string]$Type,[string]$Name,  [string]$Value, [string]$Ttl, [int]$Preference) {
        
        if ($Type -notmatch "^(MX)$") { throw "Type must be one of the following: MX." }
        if ($value -notmatch "^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") {throw "Value must be a fully qualified domain name (FQDN)."} 

        $this.ServiceType = $ServiceType.toUpper()
        $this.Type = $Type.ToUpper()
        $this.Name = $Name.ToLower()
        $this.Value = $value
        $this.Ttl = $ttl
        $this.Preference = $preference
    }

    DnsRecord ([string]$ServiceType,[string]$Type,[string]$Name, [string]$Value, [string]$Ttl, [int]$Priority, [int]$Port, [string]$Service, [string]$Protocol, [string]$Weight) {
        
        if ($Type -notmatch "^(SRV)$") { throw "Type must be one of the following: SRV." }
        if ($value -notmatch "^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") {throw "Value must be a fully qualified domain name (FQDN)."}

        $this.ServiceType = $ServiceType.toUpper()
        $this.Type = $Type.ToUpper()
        $this.Name = $Name.ToLower()
        $this.Value = $value
        $this.Ttl = $ttl
        $this.Priority = $priority
        $this.Port = $port
        $this.Service = $service
        $this.Protocol = $protocol
        $this.Weight = $weight
    }

  }

