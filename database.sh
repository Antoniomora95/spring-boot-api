#!/bin/zsh
# https://www.tutorialworks.com/container-networking/
# always check the existent containers, all of them --> docker container ls -all
docker pull mysql:latest

docker run -p 3306:3306 --name mysql-container  -e MYSQL_ROOT_PASSWORD=root-pwd -e MYSQL_USER=antonio -e MYSQL_PASSWORD=w3lcome -d mysql:latest
echo 'Starting container'


docker exec -i mysql-container bash <<EOF
  mysql -uroot -proot-pwd
  CREATE DATABASE IF NOT EXISTS spring_api_db;
  grant all on spring_api_db.* to 'antonio'@'%';
  USE spring_api_db;
  CREATE TABLE IF NOT EXISTS USERS_API ( id INT(11) NOT NULL,
                                       	name VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                                       	email VARCHAR(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                                       	PRIMARY KEY (id)
                                       );
  DESCRIBE USERS_API;
  SHOW TABLES;
  SHOW DATABASES;
EOF
echo 'mysql-container is up and running'
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