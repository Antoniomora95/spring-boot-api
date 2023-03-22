#!/bin/zsh

# Check if Docker daemon is running
if ! docker info &>/dev/null; then
    echo "Docker daemon is not running"
    exit 1
fi

# Pull a specific version of MySQL image
docker pull mysql:8.0

# Check if container already exists
if docker container ls -a | grep -q mysql-container; then
    echo "mysql-container already exists"
else
    # Run container interactively and delete it when stopped
    docker run -it --rm -p 3306:3306 --name mysql-container \
    -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    -e MYSQL_USER=$MYSQL_USER \
    -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
    mysql:8.0
fi

# Connect to container and create database and table
docker exec -i mysql-container mysql -uroot -p$MYSQL_ROOT_PASSWORD <<EOF
    CREATE DATABASE IF NOT EXISTS spring_api_db;
    GRANT ALL ON spring_api_db.* TO '$MYSQL_USER'@'%';
    USE spring_api_db;
    CREATE TABLE IF NOT EXISTS USERS_API (
        id INT(11) NOT NULL,
        name VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
        email VARCHAR(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
        PRIMARY KEY (id)
    );
    SHOW TABLES;
EOF

# Output container logs
docker container logs mysql-container



## then connect to your container from command line -> docker exec -it mysql-container bash
## now log in into mysql -> mysql -uantonio -pw3lcome
## find a way to create the db



## add this to the readme
## 1.-  first set up db mysql running on container
## 2.- complete your code needed for the spring boot api
##  once done, we will run the app locally, first, and later we will run the backend and the db on containers
## 3.- to do so, be sure to have this configuration on application.properties jdbc:mysql://localhost:3306/spring_api_db
## as you can see we are pointing to our local, we will point to container later.

## 4.- it is time to build the app ./mvnw clean package, it is important to get the executable JAR
## 5.- now let's test it locally -> ./mvnw spring-boot:run
## 6.- if it is working as expected, now let's run in on the container as well
    ##