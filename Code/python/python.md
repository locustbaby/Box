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
    tuple:	//有序 不可变
        T = ('s','d'),T = (1,)//单元素,T = ('a',['s','d']) ；tuple()函数
    dict:  //无序
        d = {	//无序 关键字
            'a':'s'
        }
        d['key'] = 'v'(新增) //key不可变 ; if 'key' in d:  // ;d.get('value') ; for key in d: ; d = (d1, **d2) //dict合并  for k, v in a.items(): pass //遍历键值
		字典的格式化字符： phone = {'a':'1111'};"a's number's %(a)s" % phone
		方法：clear copy fromkeys get has_key items iteritems keys iterkeys pop popitem//返回键值对 setdefault update values itervalues
		函数： items = [('', ''), ('', '')] ;d = dict(items); del d[key]
    set: //无序
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
class A(self):
	def __fact(n):
    	'fact __doc__属性可以查看 '	//文档化函数
    	if n==1:
        	return 1
    	return n * fact(n - 1)
s._A__fact
默认参数	：//简化调用 默认参数只能定义在必需参数的后面：
可变参数	：*args //positional arguments tuple | **kwargs //keyword arguments dict
超类	（基类）：__bases__ ; issubclass ; isinstance ; __class__
多基类	：class A(cal, sss) //多重继承  注意：先继承的类中的方法会覆盖后继承的类中方法 （MRO顺序）
匿名函数 ：lambda x: x * x
    			参数 ： 表达式 （不写return）

内省	：
hasattr（tc, 'talk'） // （类， 方法）
callable(getattr(tc, 'talk', None))	//3.0 hasattr(x.'__call__')代替callable（x）
setattr(tc, 'name', 'Mr. Gumby')	//设置对象的特性
__dict__ 特性查看对象内所有储存的值
```

##### 高阶函数

```python
函数也可作为参数
map(func,[1,2,3])
reduce(func,[1,2,3,4],100)	//func, list, 初始值
filter(func,[1,2,3]) 	//filter根据判断结果自动过滤掉不符合条件的元素
sorted（list）
```

###### 异常

```python
内建异常	:
Exception :
AttributeError :
IOError :
IndexError :
KeyError :
NameError ：
SyntaError :
TypeError :
ValueError :
ZeroDivisionError :

捕捉异常 ：
class muffledcalculator：
	muffled= False
    def calc(self. expr):
        try:
            return eval(expr)
        except (ZeroDivisionError, NamwError):
            if self.muffled:
                print '0 is illegal'
            else:
                raise
        except (TypeError), e:
            print e
        except:
            print 'something broken'
        else:
            print 'runs ok'
        finally：
        	print 'cleaning up'
            del x
```

###### 模块

```python
# 动态引入模块
try:
    import json
except ImportError:
    import simplejson as json

# 使用 __future__
from __future__ import unicode_literals
# 测试
if __name__ == '__main__':
    test()
# 包
必须有 __init__.py

# 常用
# dir
[n for n in dir(copy) if not n.startwith('_')]
# __all__
# __doc__
# __file__
```

##### 标准库

```python
# sys
# os
# fileinput
# 集合、堆、双端序列
# time
# random
# shelve
# functools
https://mp.weixin.qq.com/s/SdVMhiCwAdmU9uVBbK13jQ
# difflib
# hashlib
# csv
# timeit、profile、trace
# datetime
# itertools
https://mp.weixin.qq.com/s/jKIGcsaMe5FtOxUs6x5WXw
# logging
# getopt
# optparse
# cmd
```

##### re

```python
r/R 字符串前：非转义的原始字符串
#	re
https://docs.python.org/3/library/re.html
import re
re.sub(r'.baidu.com', '', addr[0])
request_compile = (r'<input type="hidden" name="lt".*?value="(.*?)"')
lt_value = re.search(request_compile, res.text).group(1)
```

##### getopt

```python
import getopt
try:
    opts, args = getopt.getopt(sys.argv[1:], "c:f:i:t:n:u:h", ["help"])
except getopt.GetoptError:
    print("wrong!!")
for opt, arg in opts:
    if opt in ('-h', '--help'):
        Usage()
    elif opt in ('-c'):
        Func = arg
    elif opt in ('-f'):
        HostsFile = arg
    elif opt in ('-i'):
        Host = arg
    elif opt in ('-t'):
        Tag = arg
    elif opt in ('-n'):
        Num = arg
    elif opt in ('-C'):
        Target_Cluster = arg
    elif opt in ('-P'):
        Target_Pool = arg
    elif opt in ('-r'):
        reason = arg
    else:
        print('no such option: {}'.format(opt))
```

