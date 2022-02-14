local m=100
local kpre=KEYS[1]
local vpre=KEYS[2]

while(m>0)
do
  local n=10000
  while(n>0)
  do
    local key=kpre .. "-" .. tostring(m) .. "-" .. tostring(n)
    local val=vpre .. "-" .. tostring(m) .. "-" .. tostring(n)
    redis.call('hsetnx', 'bigkeyhash', key,val)
    n = n-1
  end
  m = m-1
end