#### 类

```python
类，实例化，实例属性  
//类是模板，而实例则是根据类创建的对象。实例属性每个实例各自拥有，互相独立，而类属性有且只有一份。
class Person(object):
    def __init__(self, name, gender, birth, job):
        self.name = name
        self.gender = gender
        self.birth = gender
        self.job = job

xiaoming = Person('Xiao Ming', 'Male', '1990-1-1', job='Student')

print xiaoming.name
print xiaoming.job

访问限制
class Person(object):
    def __init__(self, name, score):
        self.name = name
        self.__score = score	//私有  _score 单下划线也可被访问，但不应该被访问
    def get_name(self):
        return self.__score

p = Person('Bob', 59)

print p.name
try :
    print p.__score
except AttributeError:
    print 'attributeerror'
print p.get_name //返回的是函数对象
print p.get_name //返回的是方法调用

类属性 //实例属性 和 类属性重名时，实例属性优先级高
class Person(object):
    count=0
    def __init__(self,name):
        self.name=name
        Person.count=Person.count+1
        
p1 = Person('Bob')
print Person.count  //1

p2 = Person('Alice')
print Person.count  //2

p3 = Person('Tim')
print Person.count   #3

添加方法到实例上 //types.MethodType() 
import types
def fn_get_grade(self):
    if self.score >= 80:
        return 'A'
    if self.score >= 60:
        return 'B'
    return 'C'

class Person(object):
    def __init__(self, name, score):
        self.name = name
        self.score = score

p1 = Person('Bob', 90)
p1.get_grade = types.MethodType(fn_get_grade, p1, Person)
print p1.get_grade()
# => A
p2 = Person('Alice', 65)
print p2.get_grade()
# ERROR: AttributeError: 'Person' object has no attribute 'get_grade'
# 因为p2实例并没有绑定get_grade
### 给一个实例动态添加方法并不常见，直接在class中定义要更直观。

定义类方法 @classmethod
class Person(object):
    count = 0
    @classmethod
    def how_many(cls):
        return cls.count
    def __init__(self, name):
        self.name = name
        Person.count = Person.count + 1

print Person.how_many()
p1 = Person('Bob')
print Person.how_many()
```

类 继承 

```python
Person —— 父类，基类，超类
student —— 子类，派生类，继承类
class Person(object):
    def __init__(self, name, gender):	//构造函数
        self.name = name
        self.gender = gender
class Student(Person):
    def __init__(self, name, gender, score):
        super(Student, self).__init__(name, gender)
        self.score = score
# 一定要用 super(Student, self).__init__(name, gender) 去初始化父类，否则，继承自 Person 的 Student 将没有 name 和 gender。self参数已在super()中传入，在__init__()中将隐式传递，不需要写出（也不能写）。
```

类 多态

```python
import json

class Students(object):
    def read(self):	#任何对象，只要有read()方法，就称为File-like Object,都可以传给json.load
        return r'["Tim", "Bob", "Alice"]'

s = Students()

print json.load(s)
```

类 多重继承

```python
class A(object):
    def __init__(self, a):
        print 'init A...'
        self.a = a

class B(A):
    def __init__(self, a):
        super(B, self).__init__(a)
        print 'init B...'

class C(A):
    def __init__(self, a):
        super(C, self).__init__(a)
        print 'init C...'

class D(B, C):
    def __init__(self, a):
        super(D, self).__init__(a)
        print 'init D...'
                
A-> B,C -> D
```

##### 获取对象信息

```python
type()
dir()
getattr()
setattr( )
class Person(object):

    def __init__(self, name, gender, **kw):
        self.name = name
        self.gender = gender
        for k, v in kw.iteritems():
            setattr(self, k, v)

p = Person('Bob', 'Male', age=18, course='Python')
print p.age
print p.course
```

##### python 特殊（魔法）方法

```python
# __str__ 和 __repr__
class Person(object):
    def __init__(self, name, gender):
        self.name = name
        self.gender = gender

class Student(Person):
    def __init__(self, name, gender, score):
        super(Student, self).__init__(name, gender)
        self.score = score
    def __str__(self):
        return '(Student: %s, %s, %s)' % (self.name, self.gender, self.score)
    __repr__ = __str__

s = Student('Bob', 'male', 88)
print s
# __len__
class Students(object):
    def __init__(self, *args):
        self.names = args
    def __len__(self):
        return len(self.names)
print len(ss)
# __getitem__
# __setitem__
# __deltiem__
```

##### @property （处理 属性）

```shell
class Student(object):
    def __init__(self, name, score):
        self.name = name
        self.__score = score
    @property
    def score(self):
        return self.__score
    @score.setter
    def score(self, score):
        if score < 0 or score > 100:
            raise ValueError('invalid score')
        self.__score = score
```

##### \_\_slots__

```shell
class Student(object):
    __slots__ = ('name', 'gender', 'score')
    def __init__(self, name, gender, score):
        self.name = name
        self.gender = gender
        self.score = score
```

##### \_\_call__

```shell
class Person(object):
    def __init__(self, name, gender):
        self.name = name
        self.gender = gender

    def __call__(self, friend):
        print 'My name is %s...' % self.name
        print 'My friend is %s...' % friend
```

##### 迭代器

```python
class Fibs:
    def __init__(self):
        self.a = 0
        self.b = 1
    def next(self):
        self.a, self.b = self.b, self.a + self.b
        return self.a
    def __iter__(self):
        return self

b = Fibs()
for i in b:
    print i  
    time.sleep(1)
    print '1'
# 从迭代器得到序列 list(b)
```

##### 生成器

```python
def flatten(nested):
    for sublist in nested:
        for element in sublist:
            yield element	# 任何包含yield语句的函数称为生成器
# 每一次yield 函数就冻结；等待被唤醒
# 递归生成器
def flatten(nested):
    try:
        for sublist in nested:
            for element in flatten(sublist):
                yield element
	except TypeError:
        yield nested
# 模拟生成器
```

##### python decorator

```python
LEGB : L>E>G>B
    L: local 函数内部作用域
    E: enclosing 函数内部与内嵌函数之间
    G: global 全局作用域
    B: build-in 内置作用域
        
示例：
passline = 60
def func(val):
    if val > passline:
        print("pass")
    else:
        print("faild")
    def in_func():
        print (val)
    in_func()
    
def Max(val1,val2):
    return max(val1,val2) //buildin
func(89)
print(Max(90,100))

闭包理解和使用
Closure：内部函数中对enclosing作用域的变量进行引用
def set_closure(passline):
    def cmp(val):
        if val > passline:
            print ("pass")
        else:
            print ("Faild")
        return cmp

f_100 = set_passline(60)

def dec(func):
    def in_dec(*arg):
        if len(arg) == 0:
            return 0
        for val in arg:
            if not isinstance(val, int):
                return 0
        return func(*arg)
    return in_dec

my_sum = dec(my_sum)

装饰器：
def bibao(func):
    def in_bibao():
        func() #3
        print("Im Inbibao!")
        return bibao
    print("Im bibao") #1
    return in_bibao #2
#bibao(a) -> in_bibao 
#a = in_deco
#bar() in_deco() bar()
@bibao
def a():
    print("heallo!") #3
a()

无参数decorator
def log(f):
    def fn(*args, **kw):
        print 'call ' + f.__name__ + '()...'
        return f(*args, **kw)
    return fn
@log

带参数decorator
def log(prefix):
    def log_decorator(f):
        def wrapper(*args, **kw):
            print '[%s] %s()...' % (prefix, f.__name__)
            return f(*args, **kw)
        return wrapper
    return log_decorator

@log('DEBUG')
def test():
    pass
print test()

完善decorator
import time, functools

def performance(unit):
    def fn(f):
        @functools.wraps(f)	//属性复制
        def wrapper(*args, **kw):
            t0 = time.time()
            back = f(*args, **kw)
            t1 = time.time()
            t = (t1 - t0) if unit =='s' else (t1 - t0) * 1000
            print 'call %s() in %s %s' % (f.__name__, t, unit)
            return back
        return wrapper
    return fn

@performance('ms')
def factorial(n):
    return reduce(lambda x,y: x*y, range(1, n+1))

print factorial(3)
print factorial.__name__
```

##### 偏函数

```python
def int2(x, base=2):
    return int(x, base)
int2('100010')
//偏函数
int2 = functools.partial(int, base=2)
```





