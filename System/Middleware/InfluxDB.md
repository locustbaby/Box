#### InfluxDB

```
概念				MYSQL				InfluxDB
数据库			 database		 database
表				   table			 measurement 
列					column			 tag(带索引，非必须)、field（不带索引）、timestemp

tag set：不同的每组tag key和tag value的集合
field set：每组field key和field value的集合
retention policy：数据存储策略（默认策略为autogen）influxDB没有删除数据操作，规定数据的保留时间达到清除数据的目的
series：共同 retention policy，measurement和tag set的集合
```

```
注意点
tag 只能为字符串类型
field 类型无限制
不支持join
支持连续查询操作（汇总统计数据）：CONTINUOUS QUERY
```

```
-- 查看所有的数据库
show databases;
-- 使用特定的数据库
use database_name;
-- 查看所有的measurement
show measurements;
-- 查询10条数据
select * from measurement_name limit 10;
-- 数据中的时间字段默认显示的是一个纳秒时间戳，改成可读格式
precision rfc3339; -- 之后再查询，时间就是rfc3339标准格式
-- 或可以在连接数据库的时候，直接带该参数
influx -precision rfc3339
-- 查看一个measurement中所有的tag key 
show tag keys
-- 查看一个measurement中所有的field key 
show field keys
-- 查看一个measurement中所有的保存策略(可以有多个，一个标识为default)
show retention policies;
```

