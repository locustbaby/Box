##### python 装饰器

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

