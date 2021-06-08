FROM mcr.microsoft.com/powershell:latest

LABEL   Maintainer = "Shane Hoey"\
        Date = "4/03/2021"\
        Description = "Docker container with PowerShell Core and latest modules to manage Teams"\
        org.opencontainers.image.source = https://github.com/shanehoey/teamstools

RUN pwsh -command "install-module -name MicrosoftTeams -scope allusers -force -verbose \
                && install-module -name az -scope allusers -force -verbose \
                && install-module -name mediant -scope allusers -force -verbose \
                && install-module -name ipphone -scope allusers -force -verbose"

COPY profile.ps1 /home/.config/powershell/profile.ps1

ENV HOME /home

WORKDIR $HOME

ENTRYPOINT [ "pwsh" ]
