
docker network ls
docker network create projectx
docker network create jenkins

# run a container in a network with a volume
docker container run --name appname --rm --detach \
  --privileged --network mynetwork --network-alias dnsname \
  --env SOMEENV=SOMEVAL \
  --volume my-data:/var/my-data \
  appimagename:tag
