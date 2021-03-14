一层只能一个package



```bash
go mod init test.com/user/hello
go mod tidy
```



```go
package main

import (
	"fmt"

	"github.com/golang/protobuf/proto"
	"test.com/user/hello/test"
)

func main() {
	s := &test.Student{
		Id:   1,
		Name: "Mike",
		Sex:  test.Sex_Female,
	}
	fmt.Println(s) // id:1 name:"Mike" sex:Female
	data, _ := proto.Marshal(s)
	fmt.Println(data) // [8 1 18 4 77 105 107 101 24 1]
	ss := new(test.Student)
	err := proto.Unmarshal(data, ss)
	if err == nil {
		fmt.Println(ss) // id:1 name:"Mike" sex:Female
	}
}
```



```protobuf
syntax = "proto3";

package test;

enum Sex{
   Male = 0;
   Female = 1;
}

message Student{
   int32 id = 1;
   string name = 2;
   Sex sex = 3;
}
```

