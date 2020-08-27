Write-Verbose "TeamsTools" -verbose

function import-teamstools {
import-module -name microsoftteams
import-module -name az
}

function connect-teamstools {
Connect-MicrosoftTeams
$session = new-csonlinesession 
import-pssession -session $session
}
