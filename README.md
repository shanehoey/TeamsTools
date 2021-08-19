# TeamsTools

A PowerShell Module, that includes a collection of scripts to expand on Managing Microsoft Teams with PowerShell.

## Recommended Usage (Docker)

Using docker is the simplist and easiest method to use teams as the only prerequisite is to install docker engine. By using TeamsTools within a docker image everything comes pre-install, built from the latest official images, and latest modules from PowerShell Gallery. 

1) Install Docker Desktop from [Docker Hub](https://hub.docker.com/search?q=&type=edition&offering=community&sort=updated_at&order=desc)

```powershell

docker pull shanehoey/teamstools
docker run -it shanehoey/teamstools

```

## Manual Installation (PowerShell)

The Teams tools module can also be installed in your local PowerShell via PowerShell Gallery. 

If you choose this method of installation, you will also require to install the prequisite powwershell modules including :

1) Skype for Business Online Module
2) Teams Module
3) Azure Module
4) Mediant Module *Optional
5) IPPhone Module *Optional

```powershell

install-module -name TeamsTools

```
