# Apache Tomcat on Azure App Service

This repository contains Docker images for Apache Tomcat for running on Azure App Service.

## Build
```
cd 8.5-jre8
docker build -t tomcat .
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

