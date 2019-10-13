```python
''' py3 Pool 可直接调用class.func py2不可，py2需 调用ThreadPool;ThreadPool 线程共享内存'''
import multiprocessing
from multiprocessing.pool import ThreadPool as Pool
#from multiprocessing import Pool
import time

class A(object):
    def __init__(self):
        self.a=1
        pass

    def de(self,x):
        print("echo ",x)
    
    def ch(self,h):
        print("h",h)
        self.b=2
        print("start",self.a)
        if h==2:
            self.a=10
            time.sleep(3)
        else:
            self.a=h
            time.sleep(3)
        print("end {}".format(h),self.a)
        return self.a
    
    def mul(self):
        p = Pool(4)
        args=[{'h':1},{'h':2},{'h':3},{'h':4}]
        Process_res = [p.apply_async(self.ch, kwds=arg,callback=self.de) for arg in args]
        p.close()
        p.join()
        Res = [single_p.get() for single_p in Process_res]
        return Res
ins=A()
def B(h):
    line=ins.ch(h=h)
    return line

def C(x):
    print("echo",x)
p = Pool(4)
args=[{'h':1},{'h':2},{'h':3},{'h':4}]
#Process_res = [p.apply_async(B, kwds=arg) for arg in args]
Process_res=[]
for arg in args:
    p.apply_async(B, kwds=arg,callback=C)
p.close()
p.join()
```

