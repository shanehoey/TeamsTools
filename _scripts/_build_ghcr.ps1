exit

set-location $env:USERPROFILE\code\shanehoey\TeamsTools

docker build -t ghcr.io/shanehoey/teamstools:latest -f Dockerfile .

docker login ghcr.io -u shanehoey

docker push ghcr.io/shanehoey/teamstools:latest
