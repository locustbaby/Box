###### 类

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
    def __init__(self, name, gender):
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

获取对象信息

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

python 特殊方法

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
```

##### @property

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



