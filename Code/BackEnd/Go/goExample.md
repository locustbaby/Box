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

###### influxdb

```go
package main

import (
	"fmt"
	"net/http"
	"strings"
)

func httpPost(requestUrl string) (err error) {
	a := "cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000"
	// fmt.Println(u)
	resp, err := http.Post(requestUrl, "text/plain", strings.NewReader(a))
	fmt.Println(resp)
	defer resp.Body.Close()
	return err
}

func main() {
	var url = "http://influxdbip:8086/write?db=mydb"
	httpPost(url)
}

```

