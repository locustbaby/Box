##### 创建数据库

```mysql
creat database bank;
grant all privileges on bank.* to 'userabc'@'localhost' identified by 'xyz';/*创建用户赋予权限bank*/
```

##### 数据类型

```mysql
/* 字符型数据 */
char(20) /* fixed-length 255 */
varchar(20) /* variable-length 65535 */
/* 文本数据 */
tinytext /* 255 */
text /* 65536 */
mediumtext /* 16777215 */
longtext /* 4294967295 */
/* 数值型 */
/* 整数 */
tinyint
smallint
mediumint
int
bigint
/* 浮点数 */
float
double
/* 时间 */
date /* YYYY-MM-DD */
datetime /* YYYY-MM-DD HH:MI:SS */
timestamp /* YYYY-MM-DD HH:MI:SS */
year /* YY */
time /* HHH:MI:SS */
```

##### 正则表达式

```mysql
select emp_id from example where lname regexp '^[FG]';
```

##### null

```mysql
/* 表达式可以为null 但不能等于null；两个null值不能判断为相等 */
```

##### 连接

```mysql
/* 旧的连接语法 */
select e.fname, e.lname, d.name
from employee e, department d
where e.dept_id = d.dept_id;
/* SQL92 */
select a.account_id, a.cust_id, a.open_date, a.product_cd
from account a INNER JOIN employee e
on a.open_emp_id = e.emp_id
INNER JOIN branch b
on e.assigned_branch_id = b.branch_id
where e.start_date < '2007-01-01'
and (e.title = 'Teller' OR e.title = 'Head Teller')
and b.name = 'Woburn Branch'
/* 将子查询结果作为查询表 */
select a.account_id, a.cust_id, a.open_date, a.product_cd
from account a inner join 
(select emp_id, assigned_branch_id
 from employee
 where start_date < '2007-01-01'
 and (title = 'Teller' or title = 'Head Teller')) e
 on a.open_emp_id = e.emp_id
 inner join
 (select branch_id
 from branch
 where name = 'Woburn Branch') b
 on e.assigned_branch_id = b.branch_id
```

##### 集合

```mysql
/* 并：union;union all */
/* 
union:并集 并排序去除重复项
union all:保留重复项
*/
select 1 num, 'abc' str
union
select 9 num, 'bcd' str

/* 交：intersect;intersect all */
select emp_id
from employee
intersect
select emp_id
from individual

/* 差：except;except all */
select emp_id
from employee
except
select open_emp_id
from account
```

##### 字符串

```mysql
/* 字符集 */
select char(128,129);
/* 根据字符查 acsii */
select ascii('a');
/* 连接字符串 concat() 或 || */
select 'dan' || 'ke';
select concat('dan','ke');
/* 字符串函数：length() position() locate() strcmp()[只有mysql有] */
select length(char_fld) char_length
from tb1;
select position('ca' in vchar_fld) /* 起始位置1 */
from string_tb1;
select locate('is',vchar_fld,5)
from string_tbl;
/* 比较字符串：like regexp;结果为1（true）或0（false） */
select name, name like '%ns' ends_in_ns
from department;
select cust_id, cust_type_cd, fed_id, fed_id
regexp '.{3}-.{2}-.{4}' is_ss_no_format
from customer;
```

##### 数值

```mysql
select (37 * 59) / (8 * 6);
/* mod */
select mod(10,4);
/* 限制浮点数精度：ceil() floor() round() truncate() */

/* 处理有符号数 */
select account_id, sign(avail_balance), ABS(avail_balance)
from account;
```

##### 时间

```mysql
/* 产生时间的函数 */
select current_date(), current_time(), current_timestamp();
/* 操作时间数据 */
select date_add(current_date(), interval 5 day);
```

##### 分组

```mysql
select open_emp_id
from account
group by open_emp_id
/* 聚集函数：Max() Min() Avg() Sum() Count() */

/* 隐式或显式分组 */
select max(avail_balance) max_balance
from account
where product_cd = 'CHK';/* 隐式 */
select product_cd,
max(avail_balance) max_balance
from account
group by product_cd;/* 显式 */
/* 对单列的分组 */
select product_cd, sum(avail_balance) prod_balance
from account
group by product_cd;
/* 对多列的分组 */
select product_cd, open_branch_id, sum(avail_balance) tot_balance
from account
group by product_cd, open_branch_id;
/* 根据表达式分组 */
select extract(YEAR FROM start_date) year, count(*) how_many
from employee
group by extract(YEAR FROM start_date);
/* 分组过滤条件 */
select product_cd, sum(avail_balance) prod_balance
from account
where status = 'ACTIVE'
group by product_cd
having sum(avail_balance) >= 10000;
```

##### 子查询

```mysql
/* 子查询通常在包含语句之前 */
/* 返回结果集：单列单行，单列多行，多列多行 */
select account_id, product_cd, cust_id, avail_balance
from account
where account_id = (select max(account_id) from account);
/* 多行单列子查询 */
/* in,not in,all,any */
select emp_id, fname, lname, title
from employee
where emp_id in (select superior_emp_id
                from employee);
/* all (需要与 =,<>,<,>) */
select emp_id, fname, lname, title
from employee
where emp_id <> all (select superior_emp_id
                    from employee
                    where superior_emp_id IS NOT NULL);
/* any */
select account_id, cust_id, product_cd, avail_balance
from account
where avail_balance > ANY (select a.avail_balance
                          from account a inner join individual i
                          on a.cust_id = i.cust_id
                          where i.fname = 'Frank' and i.lname = 'Tucker');
/* 多列子查询 */
select account_id, product_cd, cust_id
from account
where open_branch_id = (select branch_id
                       from branch
                       where name = 'Woburn Branch')
                       and open_emp_id in (select emp_id
                                          from employee
                                          where title = 'Teller' or title = 'Head Teller');
/* 关联子查询 */
select c.cust_id, c.cust_type_cd, c.city
from customer c
where 2 = (select count(*)
          from account a 
          where a.cust_id = c.cust_id);
```

