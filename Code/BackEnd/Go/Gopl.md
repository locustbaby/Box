#### Gopl

##### 程序结构

> 名称

```go
//关键字 25个
//预声明
```

> 声明

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

> 变量

```go
var name type = value
name := value //短变量声明，类型由expression决定
```

> 赋值

```go

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

