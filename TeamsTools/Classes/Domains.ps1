class DnsRecord {

    [ValidateSet("Email", "OfficeCommunicationsOnline", "SharepointDefaultDomain", "OrgIdAuthentication", "Intune")]
    [String]$ServiceType  #AAAA, A, CNAME, MX, SRV, TXT

    [ValidateSet("AAAA", "A", "CNAME", "MX", "SRV", "TXT")]
    [String]$Type #AAAA, A, CNAME, MX, SRV, TXT 

    [ValidatePattern("^[a-zA-Z0-9.-_]+\.[a-zA-Z]{2,}$")]
    [String]$Name #AAAA, A, CNAME, MX, SRV, TXT

    [ValidatePattern(".*")]
    [String]$Value      #AAAA, A, CNAME, MX, SRV, TXT

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
    [String]$Service     #SRV

    [ValidateSet("_tcp", "_udp", "_tls")]
    [String]$Protocol   #SRV
    
    [AllowNull()]
    [ValidateRange(0, 86400)]
    [Nullable[int]]$Weight #SRV


    DnsRecord () { }

    DnsRecord ([String]$ServiceType, [String]$Type, [String]$Name, [String]$Value, [int]$Ttl) {

        if ($Type -notmatch "^(AAAA|A|CNAME|TXT)$") { throw "Type must be one of the following: AAAA, A, CNAME, TXT." }
        switch ($Type) {
            "AAAA" { if ( $value -notmatch "^[a-fA-F0-9:]+$" ) { throw "Value must be a valid IPv6 address." } }
            "A" { if ( $value -notmatch "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$" ) { throw "Value must be a valid IPv4 address." } }
            "CNAME" { if ( $value -notmatch "^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" ) { throw "Value must be a fully qualified domain name (FQDN)." } }
            "TXT" { if ( $value -notmatch ".*" ) { throw "Value must be a valid TXT record." } }
        }  

        $this.ServiceType = $ServiceType.toUpper()
        $this.Type = $Type.ToUpper()
        $this.Name = $Name.ToLower()
        $this.Value = $Value
        $this.Ttl = $Ttl
    }

    DnsRecord ([String]$ServiceType, [String]$Type, [String]$Name, [String]$Value, [String]$Ttl, [int]$Preference) {
        
        if ($Type -notmatch "^(MX)$") { throw "Type must be one of the following: MX." }
        if ($Value -notmatch "^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") { throw "Value must be a fully qualified domain name (FQDN)." }

        $this.ServiceType = $ServiceType.toUpper()
        $this.Type = $Type.ToUpper()
        $this.Name = $Name.ToLower()
        $this.Value = $Value
        $this.Ttl = $ttl
        $this.Preference = $preference
    }

    DnsRecord ([String]$ServiceType, [String]$Type, [String]$Name, [String]$Value, [String]$Ttl, [int]$Priority, [int]$Port, [String]$Service, [String]$Protocol, [String]$Weight) {
        
        if ($Type -notmatch "^(SRV)$") { throw "Type must be one of the following: SRV." }
        if ($value -notmatch "^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") { throw "Value must be a fully qualified domain name (FQDN)." }

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

