#!/bin/sh

# 启动reids
# docker run -itd --name redis-test -p 6379:6379 redis

host=127.0.0.1
bigkey="bigkeyhash"

if [ "$#" == "0" ]
then
  echo "======info======="
  echo "input [dealBigKey.sh gen 10 prekey] to gen 10w field with prekey in hashkey[$bigkey]"
  echo "input [dealBigKey.sh del 10] to del 10w field in hashkey[$bigkey]"
  echo "input [dealBigKey.sh info] to show hashkey[$bigkey] length"
  echo "================="
  exit 0
fi

type=$1
echo "optype:"$type

date
if [ $type == "gen" ]
then
  loop=$2
  prekey=$3
  for i in $(seq 1 $loop)
  do
    echo pre-$i
    redis-cli -h $host --eval ./genBigKey.lua $bigkey "$prekey$i" "val$i"
    redis-cli -h $host hlen $bigkey
    sleep 0.2
  done
elif [ $type == "del" ]
then
  loop=$2
  cursor=0
  for i in $(seq 1 $loop)
  do
    cursor=$(redis-cli -h $host --eval ./delBigKey.lua $bigkey $cursor)
    redis-cli -h $host hlen $bigkey
    sleep 0.1
  done
elif [ $type == "info" ]
then
  redis-cli -h $host info | grep role
  redis-cli -h $host hlen $bigkey
fi
date
