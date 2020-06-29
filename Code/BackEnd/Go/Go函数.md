##### 函数

```go
// nil
func functionname(parametername type) returntype {
    //
}
func calculateBill(price, no int) ( area, permeter int) {
    //参数类型若一致，只需最后 附类型
    area = price * no
    permeter = (price + width) * 2
    return //默认返回 area,permeter
}
// 函数类型声明
type MyFunc func(input1 string ,input2 string) string
var myfunc1 MyFunc = func(input1 string ,input2 string) string {return "success"}
// 匿名函数声明
var splice = func(part1 string, part2 string) string {
    return part1 + part2
}   
```

##### 结构体和方法

```go
// 值类型 
// 字面量 
type Person struct {
    Name   string
    Gender string
    Age    uint8
}
// 匿名结构体 不拥有方法
p := struct {
    Name   string
    Gender string
    Age    uint8
}{"Robert", "Male", 33}
// 正式 拥有方法
//func 接受者
func (person *Person) Grow() {
    person.Age++
} 
p := Person{"Robert", "Male", 33}
p.Grow()   
```

##### 接口

```go
// 隐式实现
type Animal interface {
    Grow()
    Move(string) string
}
// 结构体
type Person struct {
    Name   string
    Gender string
    Age    uint8
}   
p := Person{"Robert", "Male", 33, "Beijing"} //Person实例
v := interface{}(&p) //类型转换
h, ok := v.(Animal)  //类型断言表达式
```

##### 指针

```go
// &p :p的指针
// p = *&p
// *Person :Person类型的指针类型，Person为基底类型

type MyInt struct {
    n int
}

func (myInt *MyInt) Increase() { //指针类型
	myInt.n++
}
```

##### 判断

```go
if condition {
    //} else if condition { } else {
}
```

##### 循环

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

##### switch

```go
switch finger {
    case 1, 2, 3: //不允许重复选项
    	fallthrough	//移交下一case
    default：
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

