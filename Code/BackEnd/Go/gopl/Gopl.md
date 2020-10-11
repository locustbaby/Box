#### Gopl

https://books.studygolang.com/gopl-zh/

#### 基础概念

###### 环境变量

```shell
GOROOT:
	Go语言的当前安装目录
GOPATH:
	Go语言工作区集合
	export GOPATH=~/golib:~/goproject
GOBIN:
	Go程序的可执行文件的目录
	export GOBIN=~/gobin
PATH:
	追加PATH
```

###### 概念

```shell
工作区:放置Go源码文件的目录
目录结构：
golib：
	src/	#用于存放源码文件，以代码包为组织形式
	pkg/	#用于存放归档文件（.a后缀），所有归档文件都会被放在该目录下的平台相关目录下，以代码包为组织形式
				#平台相关目录
				# 隐含Go语言环境变量：GOOS GOARCH
	bin/	# 用于存放当前工作区中的Go程序的可执行文件（GOBIN存在时，目录无效/GOPATH中包含多个工作区的路径时，必须设置GOBIN，否则无法成功安装Go程序可执行文件）
```

###### 源码文件

```shell
# 命令源码文件
声明自己属于main代码包、包含无参数声明和结果声明的main函数
被安装后，相应的可执行文件会被存放到GOBIN指向的目录或<当前工作区目录>/bin下
# 库源码文件
不具备命令源码文件的两个特征的源码文件
被安装后，相应的归档文件被存放到<当前工作区目录>/bin/<平台相关目录>
# 测试源码文件
至少有一个函数的名称以Test或Benchmark为前缀的，接受一个类型为*testing.T（对应Test）或*testing.B（对应Benchmark）的参数
```

###### 代码包

```go
// 代码包声明语句中的包名称是 导入路径的最右子路径
// hyperming.cn/pkgtool
package pkgtool
// 代码包的导入
// 代码包导入语句中使用的包名称与导入的代码包一致
import (
	"flag"
  "fmt"
  "strings"
)
// 别名
import str "strings"
// 本地化导入
import. "strings" //调用时不写前缀
// 仅初始化
import_ "strings"
// 代码包初始化
// 代码包初始化函数：无参数声明和结果声明的init函数
// init函数执行时机--单一代码包内
// 对所有全局变量求值 -- 执行所有init函数
```

###### 命令基础

```go
go run //跟唯一命令源码文件 + 多个包文件
go build
go install
go get
```

#### 程序结构

##### 名称

```go
//关键字 25个
//预声明
```

##### 声明

```go
package main
import "fmt"
const boilingF = 212.0
func main() {
  var f = boilingF
  var c = (f - 32) * 5 / 9
  fmt.Printf("boiling point = %g F or %g C\n", f, c)
}
```

##### 变量

```go
var name type = value
name := value //短变量声明，类型由expression决定
```

###### 指针

```go
x := 1
p := &x
fmt.Println(*p) //"1"
*p = 2
fmt.Println(x) //2
```

```go
//gopl.io/ch2/echo4
package main

import (
	"flag"
  "fmt"
  "strings"
)

var n = flag.Bool("n", false, "omit trailing newline")
var sep = flag.String("s", " ", "separator")

func main() {
  flag.Parse()
  fmt.Print(strings.Join(flag.Args(), *sep))
  if !*n {
    fmt.Println()
  }
}
```

###### new函数

```go
// new(T) 创建一个未命名的 T 类型变量
p := new(int)		//int类型
fmt.Println(*p)
*p = 2
fmt.Println(*p)
```

###### 变量的生命周期

```go

```

##### 赋值

```go
//斐波那契数列第n个数
func fib(n int) int {
  x,y := 0,1
  for i := 0; i < n; i++ {
    x, y = y, x+y
  }
  return x
}
_, err = io.Copy(dst, src) //丢弃不需要的值
```

> 类型

```go

```

> 包和文件

```shell

```

> 作用域

```go

```

##### 基础数据类型

```go

```

##### 复合数据类型

###### list :定长 [0,n)

```go
var a [3]int
var q [3]int = [3]int{1,2}	//无赋值则初始化为对应零值
q := [...]int[1,2,3]	//数组长度是数组的一部分，因此 [3]int和[4]int是两种不同数组类型，数组的长度（不是常量表达式）需要在编译阶段确定

for i, v := range 1 {
    fmt.Printf("%d %d\n", i, v)
}
for _, v := range a {
    fmt.Printf("%d\n", v)
}
//	指定索引
type Currency int
const (
	USD Currency = iota // 美元
	EUR // 欧元
	GBP // 英镑
	RMB // 人民币
)
symbol := [...]string{USD: "$", EUR: "€", GBP: "￡", RMB: "￥"}
fmt.Println(RMB, symbol[RMB]) // "3 ￥"
//	
r := [...]int{99: -1}
```

###### slice (不能比较)	[)

```go
Q2 := months[4:7]
summer := months[6:9]
s := []int{0, 1, 2, 3, 4, 5}
//	compare
func equal(x, y []string) bool {
	if len(x) != len(y) {
		return false
	}
	for i := range x {
		if x[i] != y[i] {
			return false
		}
	}
	return true
}
//	唯一合法比较
if summer == nil { /* ... */ }
//	空定义
var s []int // len(s) == 0, s == nil
s = nil // len(s) == 0, s == nil
s = []int(nil) // len(s) == 0, s == nil
s = []int{} // len(s) == 0, s != nil
//	make函数
make([]T, len)
make([]T, len, cap) // same as make([]T, cap)[:len]
```

> append

```go
var runes []rune
for _, r := range "Hello, 世界" {
	runes = append(runes, r)
}
fmt.Printf("%q\n", runes) // "['H' 'e' 'l' 'l' 'o' ',' ' ' '世' '界']"
```

###### map

```go
//	make语法
ages := make(map[string]int) // mapping from strings to ints
//	对比
ages := map[string]int{
	"alice": 31,
	"charlie": 34,
}	//	相当于
ages := make(map[string]int)
ages["alice"] = 31
ages["charlie"] = 34
//	创建空的map
map[string]int{}
//	通过key对应下标访问
ages["alice"] = 32
//	内置delete函数可以删除元素	所有操作是安全的，查找失败将返回value对应零值
delete(ages, "alice") // remove element ages["alice"]
//	遍历
for name, age := range ages {
	fmt.Printf("%s\t%d\n", name, age)
}
//	map类型零值nil，map上的大部分操作，包括查找、删除、len和range循环都可以安全工作在nil值的map上，它们的行为和一个空的map类似。但是向一个nil值的map存入元素将导致一个panic异常。

```

###### struct

```go

```

###### json

```go

```

###### 文本和html模板

```go

```

##### 函数

```go

```

##### 方法

```go

```

##### 接口

```shell

```

##### grpc

```
http://doc.oschina.net/grpc?t=60133
```

