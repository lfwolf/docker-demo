#!/bin/sh

for port in `seq 7101 7103`; do \
  mkdir -p ./redis-sentinel/${port}/conf \
  && PORT=${port} envsubst < ./redis.tmpl > ./redis-sentinel/${port}/conf/redis.conf \
  && mkdir -p ./redis-sentinel/${port}/data; \
done

for port in `seq 7201 7203`; do \
  mkdir -p ./redis-sentinel/${port}/conf \
  && PORT=${port} envsubst < ./redis-sentinel.tmpl > ./redis-sentinel/${port}/conf/sentinel.conf \
  && mkdir -p ./redis-sentinel/${port}/tmp; \
done

# docker-compose -f docker-compose-redis-sentinel.yml down
docker-compose -f docker-compose-redis-sentinel.yml up -d
echo "===> wait 2s"
sleep 2
echo "===> info replication"
docker exec -it redis7101 redis-cli  -p 7101 info replication
echo "===> SENTINEL get-master-addr-by-name mymaster"
docker exec -it redis7201 redis-cli  -p 7201 SENTINEL get-master-addr-by-name mymaster