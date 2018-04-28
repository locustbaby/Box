#### python

###### 基本数据类型

```python
整数 ： 十六进制 0xff00 
浮点数 : 小数点位置可以改变
字符串 ： ''和""相同 转义 'Bob said \"I\'m OK\".'	可切片 不可变
布尔值 ： true和flase , 运算： and or not
空值 ： None

print : , + //结尾加 ','前后会同行打印
注释 ：
字符串操作 ：find join lower replace spilt strip translate
```

###### 数据结构

```python
变量：动态类型
	赋值魔法： x,y,z = 1,2,3 ; x,y = y,x ; 当函数或方法返回元组时，key, value = s.popitem()
Sequence :
    list:	//有序 索引
        L = [] ;L[1];L[-2];L.append('Paul');L.insert(0,'Paul');L.pop();L.pop(2);
        方法：append,insert,pop,count,index,remove,reverse,sort
        切片 ：L[::2]	//起 终 间隔 半闭包[) 	L[::2] L[-4:-1:2] 插入：L[1:1] = L1	删除：L[1:4] = []; L[:] 复制列表
        内建函数	：len min max
    tuple:	//不可变
        T = ('s','d'),T = (1,)//单元素,T = ('a',['s','d']) ；tuple()函数
    dict:
        d = {	//无序 关键字
            'a':'s'
        }
        d['key'] = 'v'(新增) //key不可变 ; if 'key' in d:  // ;d.get('value') ; for key in d: ; d = (d1, **d2) //dict合并
		字典的格式化字符： phone = {'a':'1111'};"a's number's %(a)s" % phone
		方法：clear copy fromkeys get has_key items iteritems keys iterkeys pop popitem//返回键值对 setdefault update values itervalues
		函数： items = [('', ''), ('', '')] ;d = dict(items); del d[key]
    set:
        s = set(['A', 'C', 'B']) //内部无序 不可重复 ； 'A' in s :True ; s.add() ;s.remove(4) //4必须在 set中，不然会报错
```

###### 列表生成式

```python
列表生成式 ： [x * x for x in range(1, 11)] range(1, 100, 2) 可以生成list [1, 3, 5, 7, 9,...]
复杂表达式	dict :
tds = ['<tr><td>%s</td><td>%s</td></tr>' % (name, score) for name, score in d.iteritems()]
print '<table>'
print '<tr><th>Name</th><th>Score</th><tr>'
print '\n'.join(tds)	//join将list拼接成string
print '</table>'
条件过滤	：
[x * x for x in range(1, 11) if x % 2 == 0]
多层表达式（嵌套）：[m + n for m in 'ABC' for n in '123']
```

###### 流程控制

```python
if	:
    if score >= 90:
        //
    elif score >= 80:
        //
    else:
布尔值 : False None 0 "" () [] {} 
比较 :== != is//是同一个对象 is not;in;not in ；
布尔运算符 :
| x or y | if x is false,then y,else x |
| :--- | :--- |
| x and y | if x is false,then x,else y |
| :--- | :--- |
| not x | if x is false,then True,else Flase |
断言 ： assert 

for	:
    for name in L: //L list
        //
while	:
    while x < N:
        //
如果 能用for循环，尽量不用 while循环		xrange区别于range：range一次创建整个序列，xrange一次只创建一个数
break
continue
```

###### 函数

```python
def my_abs(x):
    return nx, ny	//多返回值返回的是 tuple
递归	：
def fact(n):
    if n==1:
        return 1
    return n * fact(n - 1)
默认参数	：//简化调用 默认参数只能定义在必需参数的后面：
可变参数	：*args //positional arguments tuple | **kwargs //keyword arguments dict
```

###### 模块

###### 类

