
# Run a container
docker run hello-world:latest
docker run -it ubuntu bash

# List running containers
docker ps

# List all containers including stopped
docker ps -a

# Get into a running container
docker exec -it "container" /bin/bash

# Run a command
docker exec "container" cat /etc/passwd

# Stop a container
docker stop "container"

# Create a network
docker network create mynetwork

# Create volumes
docker volume create my-data
docker volume create postgres-data
docker volume create home

# run a container in a network with a volume
docker container run --name appname --rm --detach \
  --privileged --network mynetwork --network-alias dnsname \
  --env SOMEENV=SOMEVAL \
  --volume home:/home \
  --volume my-data:/var/my-data \
  --volume "$HOME":/home \
  appimagename:tag
