FROM mcr.microsoft.com/powershell:latest

# BUG no winRM on mcr.microsoft.com/powershell:latest
# WORKAROUND install-module PSWSMAN or use mcr.microsoft.com/powershell:lts-ubuntu-18.04 or use windows containers

LABEL   Maintainer = "Shane Hoey"\
        Date = "4/03/2021"\
        Description = "Docker container with PowerShell Core and latest modules to manage Teams"\
        org.opencontainers.image.source = https://github.com/shanehoey/teamstools

RUN apt-get update \
        && apt-get clean
 
RUN pwsh -command 'install-module -name MicrosoftTeams -scope allusers -force \
                && install-module -name az -scope allusers -force \
                && install-module -name azuread -scope allusers -allowprerelease -force \
                && install-module -name mediant -scope allusers -force \
                && install-module -name Microsoft.Graph.Teams -scope allusers -force \
                && install-module -name Microsoft.Graph.Authentication -scope allusers -force \
                && install-module -name ExchangeOnlineManagement -scope allusers -force \
                && install-module -name ipphone -scope allusers -force \
                && install-module -name PSWSMAN -scope allusers -force \ 
                && install-wsman'

COPY /scripts/profile.ps1 /home/.config/powershell/profile.ps1

COPY /TeamsTools /home/.local/share/powershell/Modules/TeamsTools/

ENV HOME /home

WORKDIR $HOME

ENTRYPOINT [ "pwsh" ]
