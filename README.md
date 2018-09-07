# Apache Tomcat on Azure App Service

This repository contains Docker images for Apache Tomcat for running on Azure App Service.

## Build
```
./setup.sh
cd <directory> # example: cd 8.5-jre8
docker build -t tomcat .
```
To change the base image that is used, you can run:
```
docker build --no-cache --build-arg BASE_IMAGE=<base image name> -t tomcat .
```

## Run

```
docker run tomcat
```

## SSH to the Docker container

```
container_ip=IP_OF_THE_DOCKER_CONTAINER
ssh root@$container_ip -p 2222
```

The username is `root` and password is `Docker!`. For detailed documentation, refer https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image.

## Known issues
Currently, due to line ending issues, building and running on a Windows machine causes issues during the container startup. This will be fixed soon.
