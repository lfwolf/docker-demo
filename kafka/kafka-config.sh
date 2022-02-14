#!/bin/sh

mkdir -p ./zk-server/data

for port in `seq 9001 9003`; do \
  mkdir -p ./kafka-server/${port}/kafka-logs
done

# docker-compose -f docker-compose-kafka.yml down
docker-compose -f docker-compose-kafka.yml up -d

echo "===> sleep 3s"
sleep 3



