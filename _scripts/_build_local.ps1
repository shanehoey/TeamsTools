exit

##IMPORTANT - Docker hub should be built from docker hub

set-location $env:USERPROFILE\github\shanehoey\TeamsTools

docker build -t shanehoey/teamstools:latest -f Dockerfile .
