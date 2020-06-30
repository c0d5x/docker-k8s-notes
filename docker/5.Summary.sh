
# Run a container
docker run hello-world:latest
docker run -it ubuntu bash

# limit the resources, generate oom
docker run --rm -it --cpus 2 --memory 128M progrium/stress \
  --cpu 3 --io 1 --vm 2 --vm-bytes 68M

# more options
# privileged: can run docker inside docker
docker container run --name appname --rm --detach \
  --privileged --network mynetwork --network-alias dnsname \
  --env SOMEENV=SOMEVAL \
  --volume my-data:/var/my-data \
  appimagename:tag

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
docker kill "container"

# Logs
docker logs "container"
docker logs -f "container"

# Stats
docker stats "container"

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

# export / dump the contents of a container
docker export -o container-fs.tar "containerid"
mkdir container-fs-root
tar -C container-fs-root -xvf container-fs.tar

# Clean up
docker system prune
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
docker rm $(docker ps -a -q --filter 'exited!=0')

# Disk space
docker system df

# Info
docker version
docker system info

# Event monitoring
docker events
-> open another terminal
docker run ....
<- close/stop the new container

# cAdvisor, web interface to monitor cpu and memory, open http://localhost:8080
docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --name=cadvisor \
  google/cadvisor:latest
