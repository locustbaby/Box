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
```

######作用域

```go
package main
import (
	"fmt"
	"os"
)
var cwd string
func main() {
	cwd, err := os.Getwd()
	fmt.Println(cwd, err)
	if err != nil {
		fmt.Println(cwd)
	}
}
```

