#!/bin/sh

docker run -p 3306:3306 --name mysql57 \
	-v $PWD/conf:/etc/mysql/conf.d \
	-v $PWD/logs:/logs \
	-v $PWD/data:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=root \
	-d mysql:5.7 \
         --character-set-server=utf8 \
         --collation-server=utf8_general_ci
