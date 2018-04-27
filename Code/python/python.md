#### python

###### 基本数据类型

```python
整数 ： 十六进制 0xff00 
浮点数 : 小数点位置可以改变
字符串 ： ''和""相同 转义 'Bob said \"I\'m OK\".'
布尔值 ： true和flase , 运算： and or not
空值 ： None

print :
注释 ：
```

###### 数据结构

```python
变量：动态类型
Sequence :
    list:	//有序 索引
        L = [] ;L[1];L[-2];L.append('Paul');L.insert(0,'Paul');L.pop();L.pop(2)
    tuple:	//有序
        T = ('s','d'),T = (1,)//单元素,T = ('a',['s','d'])
    dict:
        d = {	//无序 关键字
            'a':"s"
        }
        d['key'] //key不可变 ; if 'key' in d:  // ;d.get('value') ; for key in d:
    set:
        s = set(['A', 'C', 'B']) //内部无序 不可重复 ； 'A' in s :True ; s.add() ;s.remove(4) //4必须在 set中，不然会报错
```

###### 流程控制

```python
if	:
    if score >= 90:
        //
    elif score >= 80:
        //
    else:
for	:
    for name in L: //L list
        //
while	:
    while x < N:
        //
break
continue
```

###### 函数

```python
def my_abs(x):
```

###### 模块

###### 类

