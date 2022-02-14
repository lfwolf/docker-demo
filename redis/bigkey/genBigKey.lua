local m=1
local bigkey=KEYS[1]
local kpre=KEYS[2]
local vpre=KEYS[3]

while(m>0)
do
  local n=10000
  while(n>0)
  do
    local key=kpre .. "-" .. tostring(m) .. "-" .. tostring(n)
    local val=vpre .. "-" .. tostring(m) .. "-" .. tostring(n)
    redis.call('hsetnx', $bigkey, key,val)
    n = n-1
  end
  m = m-1
end