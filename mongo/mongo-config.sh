#!/bin/sh

for port in `seq 1 3`; do \
  mkdir -p ./mongo-server/db${port}/mongo
done

# docker-compose -f docker-compose-mongo.yml down
docker-compose -f docker-compose-mongo.yml up -d

echo "===> sleep 3s"
sleep 3

# Initialize the replica sets (config servers and shards) and routers
docker-compose exec configsvr01 sh -c "mongo < /scripts/init-configserver.js"

docker-compose exec shard01-a sh -c "mongo < /scripts/init-shard01.js"
docker-compose exec shard02-a sh -c "mongo < /scripts/init-shard02.js"
docker-compose exec shard03-a sh -c "mongo < /scripts/init-shard03.js"

# Initializing the router
docker-compose exec router01 sh -c "mongo < /scripts/init-router.js"

# Verify
docker-compose exec router01 mongo --port 27017 sh.status()

# Verify status of replica set for each shard
docker exec -it shard-01-node-a bash -c "echo 'rs.status()' | mongo --port 27017" 
docker exec -it shard-02-node-a bash -c "echo 'rs.status()' | mongo --port 27017" 
docker exec -it shard-03-node-a bash -c "echo 'rs.status()' | mongo --port 27017" 


# Enable sharding and setup sharding-key
docker-compose exec router01 mongo --port 27017

// Enable sharding for database `MyDatabase`
sh.enableSharding("MyDatabase")

// Setup shardingKey for collection `MyCollection`**
db.adminCommand( { shardCollection: "MyDatabase.MyCollection", key: { supplierId: "hashed" } } )





