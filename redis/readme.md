# redis 高可用部署

## 集群模式

### Redis集群介绍

Redis 集群是一个提供在多个Redis间节点间共享数据的程序集。

Redis集群并不支持处理多个keys的命令,因为这需要在不同的节点间移动数据,从而达不到像Redis那样的性能,在高负载的情况下可能会导致不可预料的错误.

Redis 集群通过分区来提供一定程度的可用性,在实际环境中当某个节点宕机或者不可达的情况下继续处理命令. Redis 集群的优势:

* 自动分割数据到不同的节点上。
* 整个集群的部分节点失败或者不可达的情况下能够继续处理命令。

### Redis 集群的数据分片

> Redis 集群没有使用一致性hash, 而是引入了 哈希槽的概念.
>  
> Redis 集群有16384个哈希槽,每个key通过CRC16校验后对16384取模来决定放置哪个槽.集群的每个节点负责一部分hash槽,

### 客户端支持

> Jedis 最近添加了对集群的支持, 详细请查看项目README中Jedis Cluster部分

### 参考文档

1. [redis集群介绍]{<http://www.redis.cn/topics/cluster-tutorial.html>}
2. [redis集群规范]{<http://www.redis.cn/topics/cluster-spec.html>}

## 主从哨兵模式

1. [详解Redis哨兵技术]{<http://www.redis.cn/articles/20181020001.html>}
2. [一文把Redis主从复制、哨兵、Cluster三种模式摸透]{<https://mp.weixin.qq.com/s/GlqoafdmC4Xjf7DACN3srQ>}