# kafka集群

执行kafka-config.sh,创建目录并启动kafaka集群环境容器，容器列表：

1. kafka_zookeeper_1
2. kafka_kafka1_1
3. kafka_kafka2_1
4. kafka_kafka3_1

## 1. 创建topic

docker exec -it kafka_kafka1_1 kafka-topics.sh --create --topic first --zookeeper zookeeper:2181 --partitions 3 --replication-factor 2

docker exec -it kafka_kafka1_1 kafka-topics.sh --list

## 2. 创建一个生产者，向 topic 中发送消息

docker exec -it kafka_kafka1_1 kafka-console-producer.sh --topic first --broker-list kafka1:9092,kafka2:9092,kafka3:9092

## 3. 创建两个消费者，向 topic 中接受消息

docker exec -it kafka_kafka2_1 kafka-console-consumer.sh --topic first --bootstrap-server kafka1:9092 --from-beginning
docker exec -it kafka_kafka2_1 kafka-console-consumer.sh --topic first --bootstrap-server kafka1:9092 --from-beginning

## 4. 查看某个topic对应的消息数量

docker exec -it kafka_kafka3_1 kafka-run-class.sh  kafka.tools.GetOffsetShell --topic first --time -1 --broker-list kafka1:9092

## 5. 查看所有消费者组

docker exec -it kafka_kafka3_1 kafka-consumer-groups.sh --bootstrap-server kafka1:9092 --list

## 参考资料

[docker-compose 搭建 kafka 集群](https://www.cnblogs.com/xuwenjin/p/14917360.html)
[Kafka 设计解析](https://www.infoq.cn/news/kafka-analysis-part-1)