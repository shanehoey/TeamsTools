exit

## Docker hub will build from Github

set-location $env:USERPROFILE\github\TeamsTools

docker build -t shanehoey/teamstools:latest -f Dockerfile .
