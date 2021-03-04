FROM mcr.microsoft.com/powershell:latest

LABEL   Maintainer = "Shane Hoey" \
        Date = "4/03/2021" \
        Description = "docker container with PowerShell Core and latest modules to manage Teams"

RUN pwsh -command "install-module -name MicrosoftTeams -scope allusers -force -verbose \
                && install-module -name az -scope allusers -force -verbose \
                && install-module -name mediant -scope allusers -force -verbose \
                && install-module -name ipphones -scope allusers -force -verbose "

COPY  profile.ps1 /home/.config/powershell/profile.ps1

ENV HOME /home

WORKDIR $HOME

ENTRYPOINT [ "pwsh" ]
