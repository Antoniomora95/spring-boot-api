#!/bin/zsh
echo 'About to start the spring-api-container'
## -tag or -t helps you assign a name to the container, [.] means you are building the container from a local dockerfile, i think
docker build -t spring-api-image . ##image build with friendly name
docker run -p 8080:8080 --name spring-api-container -d spring-api-image  ## start container using previous image, and using --name for friendly name
docker container logs spring-api-container