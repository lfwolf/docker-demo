#!/bin/sh

# 启动reids
# docker run -itd --name redis-test -p 6379:6379 redis

type=$1
echo "optype:"$type
host=127.0.0.1
bigkey=bigkeyhash
date
if [ $type == "gen" ]
then
  loop=$2
  for i in $(seq 1 $loop)
  do
    echo pre-$i
    redis-cli -h $host --eval ./genBigKey.lua "key"$i "val"$i
    redis-cli -h $host hlen $bigkey
    sleep 0.2
  done
elif [ $type == "del" ]
then
  loop=$2
  cursor=0
  for i in $(seq 1 $loop)
  do
    cursor=$(redis-cli -h $host --eval ./delBigKey.lua $cursor)
    #redis-cli -h $host hlen $bigkey
    sleep 0.1
  done
elif [ $type == "info" ]
then
  redis-cli -h $host info | grep role
fi
date
