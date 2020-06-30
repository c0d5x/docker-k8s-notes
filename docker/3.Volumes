
# List
docker volume ls

# map a local folder to a container folder
docker run -d --rm -it \
  -v /tmp/containerdata:/data/app \
  projectX


# create persistent volumes
docker volume create projectxdata
docker volume create jenkins_data

# run the container with a persistent volume
docker run -d --rm -it \
  -v projectxdata:/data/app \
  projectX


# driver settings
docker volume create --driver local \
    --opt type=tmpfs \
    --opt device=tmpfs \
    --opt o=size=100m,uid=1000 \
    foo

docker volume create --driver local \
    --opt type=btrfs \
    --opt device=/dev/sda2 \
    foo

docker volume create --driver local \
    --opt type=nfs \
    --opt o=addr=192.168.1.1,rw \
    --opt device=:/path/to/dir \
    foo

# Labels
docker volume create projectx --label feature=pythonupgrade
docker volume ls --filter 'feature=pythonupgrade'
