# Spark

## 概念

* RDD 弹性分布式数据集

## 优势

与Hadoop MapReduce相比，Spark的优势如下：

❑ 中间结果：基于MapReduce的计算引擎通常将中间结果输出到磁盘上，以达到存储和容错的目的。由于任务管道承接的缘故，一切查询操作都会产生很多串联的Stage，这些Stage输出的中间结果存储于HDFS。而Spark将执行操作抽象为通用的`有向无环图（DAG）`，可以将`多个Stage的任务串联或者并行执行`，而无须将Stage中间结果输出到HDFS中。

❑ 执行策略：MapReduce在数据Shuffle之前，需要花费大量时间来排序，而Spark不需要对所有情景都进行排序。由于采用了DAG的执行计划，每一次输出的中间结果都可以`缓存在内存中`。

❑ 任务调度的开销：MapReduce系统是为了处理长达数小时的批量作业而设计的，在某些极端情况下，提交任务的延迟非常高。而Spark采用了事件驱动的类库AKKA来启动任务，通过线程池复用线程来避免线程启动及切换产生的开销。

❑ 更好的`容错性`：RDD之间维护了血缘关系（lineage），一旦某个RDD失败了，就能通过父RDD自动重建，保证了容错性。

❑ 高速：基于内存的Spark计算速度大约是基于磁盘的HadoopMapReduce的100倍。

❑ 易用：相同的应用程序代码量一般比Hadoop MapReduce少50%～80%。

❑ 提供了丰富的API：与此同时，Spark支持多语言编程，如Scala、Python及Java，便于开发者在自己熟悉的环境下工作。Spark自带了80多个算子，同时允许在Spark Shell环境下进行交互式计算，开发者可以像书写单机程序一样开发分布式程序，轻松利用Spark搭建大数据内存计算平台，并利用内存计算特性，实时处理海量数据。

## 应用

Spark应用（Application）是用户提交的应用程序。Spark运行模式分为：Local、Standalone、YARN、Mesos等。根据Spark Application的Driver Program是否在集群中运行，Spark应用的运行方式又可以分为Cluster模式和Client模式。

```python
import findspark
findspark.init('/data/learn_ds/spark-2.4.4-bin-hadoop2.7')

import pyspark
from pyspark import SparkConf, SparkContext
from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .master("spark://172.168.1.169:7077") \
    .appName("Our first Python Spark SQL example") \
    .getOrCreate()

spark.sparkContext.getConf().getAll()

"""
OUT:

[('spark.app.name', 'Our first Python Spark SQL example'),
 ('spark.driver.host', 'ddkk.dk.local'),
 ('spark.rdd.compress', 'True'),
 ('spark.driver.port', '39195'),
 ('spark.serializer.objectStreamReset', '100'),
 ('spark.executor.id', 'driver'),
 ('spark.submit.deployMode', 'client'),
 ('spark.master', 'spark://172.168.1.169:7077'),
 ('spark.app.id', 'app-20200208171327-0000'),
 ('spark.ui.showConsoleProgress', 'true')]
"""

```

