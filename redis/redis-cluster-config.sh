#!/bin/sh

for port in `seq 7001 7006`; do \
  mkdir -p ./redis-cluster/${port}/conf \
  && PORT=${port} envsubst < ./redis-cluster.tmpl > ./redis-cluster/${port}/conf/redis.conf \
  && mkdir -p ./redis-cluster/${port}/data; \
done

# docker-compose -f docker-compose-redis-cluster.yml down
docker-compose -f docker-compose-redis-cluster.yml up -d
docker exec -it redis7001 redis-cli -p 7001 --cluster create 192.168.3.35:7001 192.168.3.35:7002 192.168.3.35:7003 192.168.3.35:7004 192.168.3.35:7005 192.168.3.35:7006 --cluster-replicas 1
echo "===> wait 2s"
sleep 2
echo "===> cluster nodes"
docker exec -it redis7001 redis-cli -p 7001 cluster nodes