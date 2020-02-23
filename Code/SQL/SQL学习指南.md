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

