# SQL Note

## Join

* INNER JOIN：如果表中有至少一个匹配，则返回行 //注释：INNER JOIN 与 JOIN 是相同的
* LEFT JOIN：即使右表中没有匹配，也从左表返回所有的行 // LEFT OUTER JOIN
* RIGHT JOIN：即使左表中没有匹配，也从右表返回所有的行 //RIGHT OUTER JOIN
* FULL JOIN：只要其中一个表中存在匹配，则返回行 //

```sql
#inner join
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name=table2.column_name;

#left join
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name=table2.column_name;


#right join
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name=table2.column_name;

#full join

SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2
ON table1.column_name=table2.column_name;
```

## UNION

UNION 操作符用于合并两个或多个 SELECT 语句的结果集。

`请注意`，UNION 内部的每个 SELECT 语句必须拥有相同数量的列。列也必须拥有相似的数据类型。同时，每个 SELECT 语句中的列的顺序必须相同。

```sql
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;
# 注释：默认地，UNION 操作符选取不同的值。如果允许重复的值，请使用 UNION ALL。
# 即 选取唯一值

SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;
# 注释：UNION 结果集中的列名总是等于 UNION 中第一个 SELECT 语句中的列名。
# 相当于 把两个结果合并
```


## GROUP BY

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name;

-- 无效

  SELECT author, parent, COUNT(id)
  FROM `bigquery-public-data.hacker_news.comments`
  GROUP BY parent

-- because the ·author· column isn't passed to an aggregate function or a GROUP BY clause
```

## 更复杂的

### 联合查询

```sql
 WITH c AS #临时表c
 (
 SELECT parent, COUNT(*) as num_comments
 FROM `bigquery-public-data.hacker_news.comments` 
 GROUP BY parent
 )
 SELECT s.id as story_id, s.by, s.title, c.num_comments
 FROM `bigquery-public-data.hacker_news.stories` AS s #临时表s
 LEFT JOIN c
 ON s.id = c.parent 
 WHERE EXTRACT(DATE FROM s.time_ts) = '2012-01-01'
 ORDER BY c.num_comments DESC
```


## 函数

Three types of analytic functions
The example above uses only one of many analytic functions. BigQuery supports a wide variety of analytic functions, and we'll explore a few here. For a complete listing, you can take a look at the [documentation](https://cloud.google.com/bigquery/docs/reference/standard-sql/analytic-function-concepts).

1) Analytic aggregate functions

As you might recall, AVG() (from the example above) is an aggregate function. The OVER clause is what ensures that it's treated as an analytic (aggregate) function. Aggregate functions take all of the values within the window as input and return a single value.

* `MIN() (or MAX())` - Returns the minimum (or maximum) of input values
* `AVG() (or SUM())` - Returns the average (or sum) of input values
* `COUNT()` - Returns the number of rows in the input

2) Analytic navigation functions

Navigation functions assign a value based on the value in a (usually) different row than the current row.

* `FIRST_VALUE() (or LAST_VALUE())` - Returns the first (or last) value in the input

* `LEAD() (and LAG())` - Returns the value on a subsequent (or preceding) row

3) Analytic numbering functions
Numbering functions assign integer values to each row based on the ordering.

* `ROW_NUMBER()` - Returns the order in which rows appear in the input (starting with 1)
* `RANK()` - All rows with the same value in the ordering column receive the same rank value, where the next row receives a rank value which increments by the number of rows with the previous rank value.