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
```



