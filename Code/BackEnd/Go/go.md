#### Go

#### go数据类型

##### 程序实体和关键字

```shell
程序实体（标识符）：（变量、常量、函数、结构体、接口）
	名字首字母为大写的程序实体可以被任何代码包中的代码访问。
	首字母为小写的程序实体则只能被同一代码包中的代码访问。
关键字：不可用作标识符。
程序声明	import，package
程序实体声明和定义	chan,const,func,interface,map,struct,type,var
程序流程控制		go,select,break,case,continue,default,defer,else,fallthrough,for,goto,if,range,return,switch
```

###### 变量与常量

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
//	常量必须赋值：
const num1 int = 1
```

##### 数字

###### 整数

| 类型宽度（byte/B） | 数值范围（有符号）  | 数值范围（无符号） |
| ------------------ | ------------------- | ------------------ |
| 8                  | -128～127           | 0～255             |
| 16                 | -32768～32767       | 0-65535            |
| 32                 | 约-21.47亿～21.47亿 | 约0～42.94亿       |
| 64                 | 约-922亿亿～922亿亿 | 约0～1844亿        |

浮点数（只能10进制表示）`var num2 = 5.89E-4 //0.000589`

复数

```go
// complex64(8字节)（两个 float32分别表示实数和虚数） & complex128（16字节）（两个 float64分别表示实数和虚数）
var num3 = 3.7E+1 + 5.98E-2i //37.000000+0.059800i
```

##### 字符

```go
//	byte(uint8) 与 rune(int32);都属于别名类型
var char1 rune = '赞'
fmt.Printf("%c %s \n", char1,("U+*D5E"))
```

##### 字符串（不可变）

```go
//字符串：字符序列
// 原生表示法`` & 解释表示法""
var str1 string = `sjkfljfj\nssd`
var str2 string = "fjlsjdfj\nsjlfjf"
```

##### 数组

```go
//索引表达式 由字符串、数组、切片或字典类型的值（或者代表此类值的变量或常量）和由方括号包裹的索引值组成。
type MyNumbers [3]int
var numbers = [3]int{1,2,3}
var numbers = [...]int{1,2,3}	//自动识别长度
numbers[0]//索引范围[0,3)
var length = len(numbers)
```

##### 切片(空值nil)

```go 
[]int	//切片表示
var numbers3 = [5]int{1,2,3,4,5}
var slice3 = numbers[1:4]	//容量：｜1-5｜=4
var cap_slice3 = cap(slice3)
//切片容量为：切片第一个元素在其底层数组中的索引值 与 该数组的长度 的差值的 绝对值
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

##### 函数

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

##### 包

```go
package xx	//包
import "xx" //导入路径
func f() int { /*...*/ }//包初始化
```

##### 作用域

```go
// 声明的作用域是指用到声明时所声明名字的源代码片段
// 语法块是由大括号围起来的一个语句序列
```

