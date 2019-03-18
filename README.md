# Apache Tomcat on Azure App Service

This repository contains Docker images for Apache Tomcat for running on Azure App Service.

## Build
Run the following commands in powershell:
```powershell
.\scripts\setup.ps1 # On Linux: ./scripts/setup.sh
cd <directory> # Example: cd 8.5-jre8
docker build --no-cache -t tomcat .
```
To change the base image that is used, you can run:
```
docker build --no-cache [--build-arg BASE_IMAGE=<base image name>] -t tomcat .
```

If you are building on Windows, make sure you configure git as follows to avoid CRLF issues: `git config --global core.autocrlf false`

## Run the image locally

```
docker run tomcat
```

## Deploy and run the sample app to Azure
Run the following commands in powershell:
```powershell
cd .\samples\spring-framework-petclinic
..\..\scripts\deployAndRunApp.ps1 -imageName <imagename> [-webAppName <appname>] [-appInsightsInstrumentationKey <key>]

# Example: ..\..\scripts\deployAndRunApp.ps1 -imageName myrepo/myimage:mytag
```

## SSH to the Docker container

```
container_ip=IP_OF_THE_DOCKER_CONTAINER
ssh root@$container_ip -p 2222
```

The username is `root` and password is `Docker!`. For detailed documentation, refer https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image.

