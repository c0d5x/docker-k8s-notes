docker network create jenkins
docker volume create jenkins-docker-certs
docker volume create jenkins-data
# run a docker machine for jenkins, set network alias to docker
docker container run --name jenkins-docker --rm --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --volume "$HOME":/home docker:dind

# run jenkins with DOCKER_HOST pointing to the docker network alias
docker container run --name jenkins-tutorial --rm --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  --volume "$HOME":/home \
  --publish 8080:8080 jenkinsci/blueocean

# show the admin password to start jenkins
echo "And the password is..."
docker exec jenkins-tutorial cat /var/jenkins_home/secrets/initialAdminPassword
