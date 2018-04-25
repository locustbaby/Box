#### Go

###### 基本数据类型

```Go
//注释 对包进行描述
package main
import (
    "fmt"
    "os"
)
func main() {
    fmt.Println("GoGoGo，Hello World")
    var s,sep string	//var name 类型 
    for i := 1; i < len(os.Args);i++ {
        s += sep + os.string	//+ 字符追加
        sep = " "
    }
    fmt.Pringtln(s)
}
程序声明	import，package
程序实体声明和定义	chan,const,func,interface,map,struct,type,var
程序流程控制		go,select,break,case,continue,default,defer,else,fallthrough,for,goto,if,range,return,switch
```

###### 变量

变量和常量在声明方式方面也有所不同。我们可以在声明一个变量的时候直接为它赋值，也可以只声明不赋值。变量的声明并赋值方式如下：

```Go
// 注释：普通赋值，由关键字var、变量名称、变量类型、特殊标记=，以及相应的值组成。
// 若只声明不赋值，则去除最后两个组成部分即可。 字符默认空 数字默认0
var num1 int = 1 
var num2, num3 int = 2, 3 // 注释：平行赋值
var ( // 注释：多行赋值
    num4 int = 4
    num5 int = 5
)
```

###### 循环

```go
for是Go里唯一循环
for initialization; condition; post { //三部分可以省略
    //语句
}
for condition { //传统while循环
    //...
}
for { //传统无限循环
    //...
}
//echo 2
package main
import (
	"fmt"
    "os"
)
//
func main() {
    s,sep := "",""
    for _, arg := range os.Args[1:] {
        s += seq + arg
        sep := " "
    }
    fmt.Println(s)
}
```

