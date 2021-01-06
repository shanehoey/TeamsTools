# Demo

```powershell

get-module teams -ListAvailable

get-module skype* -ListAvailable

docker pull shanehoey/teamstools

docker run -it shanehoey/teamstools

$PSVersionTable

get-module -listAvailable

get-module az -ListAvailable

get-module MicrosoftTeams -ListAvailable | FL Name,CompatiblePSEdition ,version

get-module Skype -ListAvailable get-module Skype -ListAvailable

https://www.powershellgallery.com/packages/MicrosoftTeams/

connect-MicrosoftTeams

get-command *cs* -module MicrosoftTeams

$session = new-csonlinesession
import-pssession -session $session

get-pssession  | FL *

get-module

get-command -module tmp*

$session = new-csonlinesession -
import-pssession -session $session -


$session2 = new-csonlinesession
import-pssession -session $session2 -prefix teams -name get-cs*

get-pssession  | FL *
get-command -module tmp*  | Group source

get-csonlinesession

```
