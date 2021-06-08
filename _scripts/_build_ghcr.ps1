exit

set-location $env:USERPROFILE\github\TeamsTools

docker build -t ghcr.io/shanehoey/teamstools:latest -f Dockerfile .

docker login ghcr.io -u USERNAME

docker push ghcr.io/shanehoey/teamstools:latest