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
    const a string = "s"
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

###### 判断

```go
if condition {
    //} else if condition { } else {
}
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
    for _, arg := range os.Args[1:] {	// _ 空白符，被用作任何类型的任何值
        s += seq + arg
        sep := " "
        //break continue
    }
    fmt.Println(s)
}
```

###### switch

```go
switch finger {
    case 1, 2, 3: //不允许重复选项
    	fallthrough	//移交下一case
    default：
}
```

###### 数组和切片

```go
一维
func main() {
    var a [3]int
    a[0] = 12
    a[1] = 78
    a := [3]int{12, 78, 50}	//数组的长度 是类型的一部分
    a := [...]int{12, 78, 20}
    b := a //copy
    fmt.Println(len(a))
    for i,v := range a {
        fmt.Printf(i,v) //只能打印格式化字符
    }
}
多维
func printarray(a [3][2]string) {
    for _, v1 := range a {
        for _, v2 := range v1 {
            fmt.Printf("%s ", v2)
        }
        fmt.Printf("\n")
    }
}

func main() {
    a := [3][2]string{
        {"lion", "tiger"},
        {"cat", "dog"},
        {"pigeon", "peacock"}, // this comma is necessary. The compiler will complain if you omit this comma
    }
    printarray(a)
    var b [3][2]string
    b[0][0] = "apple"
    b[0][1] = "samsung"
    b[1][0] = "microsoft"
    b[1][1] = "google"
    b[2][0] = "AT&T"
    b[2][1] = "T-Mobile"
    fmt.Printf("\n")
    printarray(b)
}
切片：
func main() {
    a := [5]int{76, 77, 78, 79, 80}
    var b []int = a[1:4] // creates a slice from a[1] to a[3]
    fmt.Println(b)
}
func main() {  //创建一个有 3 个整型元素的数组，并返回一个存储在 c 中的切片引用
    c := []int{6, 7, 8} // creates and array and returns a slice reference
    fmt.Println(c)
}
func main() {	//对切片所做的任何修改都会反映在底层数组中。
    darr := [...]int{57, 89, 90, 82, 100, 78, 67, 69, 59}
    dslice := darr[2:5]
    fmt.Println("array before", darr)
    for i := range dslice {
        dslice[i]++
    }
    fmt.Println("array after", darr)
}
```

###### 函数

```go
func functionname(parametername type) returntype {
    //
}
func calculateBill(price, no int) ( area, permeter int) {
    //参数类型若一致，只需最后 附类型
    area = price * no
    permeter = (price + width) * 2
    return //默认返回 area,permeter
}
```

