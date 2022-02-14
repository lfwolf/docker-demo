--切换倒目标数据库
redis.call('select',0)
redis.replicate_commands()
--需要删除的hash集合名称
local mapName=KEYS[1]
local myCursor=tonumber(KEYS[2])
local loop=1
while(loop>0)
do
  print("myCursor".. myCursor)
    --日志输出到redis的日志文件中
    redis.log(redis.LOG_WARNING,"myCursor   ".. myCursor)
    local iterator=redis.call('hscan',mapName,myCursor,'count',10000)
    for index,keyOrValue in pairs(iterator) do
      redis.log(redis.LOG_WARNING,"index   "..index)
      --redis.log(redis.LOG_WARNING,"v"..v)
      if (index==1)
      then
			  myCursor=tonumber(keyOrValue)
      end
      if (index==2)
        then
        for subIndex,subKeyOrValue in pairs(keyOrValue) do
          redis.call('hdel',mapName,subKeyOrValue)
          loop=loop-1
        end
      end
    end
    --如果所有的数据都跑完了,那么写一次cursor会重新变成0
    if(myCursor==0)
    then
        break
    end
end
return myCursor