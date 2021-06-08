Write-Verbose "TeamsTools" -verbose
if ($PSVersionTable.platform -eq 'Unix'){ write-warning "Have you configured wsman ? ie install-module PSWSMan & install-wsman" }
if ($PSVersionTable.platform -eq 'Unix'){if (!(get-module PSWSMAN -ListAvailable)) {install-module -name pswsman -scope AllUsers -force ; install-wsman}}


