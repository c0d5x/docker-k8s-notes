# What is Docker:

*Platform for building, sharing and running applications*

It is like having a VM ready for you to setup your application and libraries.

# What is a Container
A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another.

# What is a Container Image
A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

## Simplifying concepts
**Think of a container image as a class**

**Think of a container as an instance**

## VMs vs Docker

### VMs
![Virtual Machine architecture](https://github.com/c0d5x/docker-k8s-notes/blob/master/docker/imgs/arch-vms.png?raw=true)

### Docker containers
![Docker Container architecture](https://github.com/c0d5x/docker-k8s-notes/blob/master/docker/imgs/arch-docker.png?raw=true)

# Installation on MacOS
[https://hub.docker.com/editions/community/docker-ce-desktop-mac/](https://hub.docker.com/editions/community/docker-ce-desktop-mac/)

# The Registry
In docker the **registry** is where images are stored. Is the git server for container images.

There are many *registries*, but the most important one is [Docker Hub](https://hub.docker.com/)

Each **Image** in a registry has a *Repository* just like an App has a git repo.

Each **Image** has multiple *tags* like branches.

[Maven Images](https://hub.docker.com/_/maven)

[Ruby Images](https://hub.docker.com/_/ruby)

# Run containers without changes

```docker run hello-world```

```docker run -it ubuntu /bin/bash```

```docker run -it python:3.8```

## Running flags

First you can run it without tags, but it only prints to stdout/stderr and doesn't detach:

```docker run jenkins/jenkins```

So we add the **-d** flag to send it to the background:

```docker run -d jenkins/jenkins```

Now we have it running in the background, but we don't have a port to reach it, so we add the *port*, **-p** flag:

```docker run -d -p 8080:8080 jenkins/jenkins```


# How to build a container image
You build an image on top of another image. In docker images are made of layers that you stack one over the other.
First you have to choose a base image to build from.

## Choose a base image from catalog
[Maven](https://hub.docker.com/_/maven)

For example: **maven:3.6.3-jdk-11**


## Write a *Dockerfile*
```
FROM maven:3.6.3-jdk-11
CMD ["mvn", "-v"]
```

## Run the build command, and tag it so you can identify it later
`docker build -t mymaven .`

## List, review, inspect our images
```
docker images
docker history mymaven
docker inspect mymaven
```

## Run our new image
`docker run mymaven`

## Run commands inside the container
```
docker run mymaven hostname
docker run mymaven mvn -v
docker run mymaven mvn -V
```
Run our image in the background:
```
docker run -d mymaven sleep 300
```


## Run a container interactively
`docker run -it mymaven /bin/bash`

## Get inside a running container
`docker exec -it "containerid" /bin/bash`

## Check running containers
Now check the running containers with:
`docker ps`

### Check containers that ran previously
`docker ps -a`
