server

```go
package main

import (
	//"fmt"
	"log"
	"net"
	"net/http"
	"net/rpc"

	//"os"
	//"time"
	"errors"
)

type Args struct {
	A, B int
}
type Quotient struct {
	Quo, Rem int
}

type Arith int

//乘
func (t *Arith) Multiply(args *Args, reply *int) error {
	*reply = args.A * args.B
	return nil
}

//除
func (t *Arith) Divide(args *Args, quo *Quotient) error {

	if args.B == 0 {
		return errors.New("divide by zero")
	}
	quo.Quo = args.A / args.B
	quo.Rem = args.A % args.B

	return nil
}

func main() {

	arith := new(Arith)

	rpc.Register(arith)

	rpc.HandleHTTP()

	l, e := net.Listen("tcp", ":1234")

	if e != nil {
		log.Fatal("listen error:", e)
	}

	http.Serve(l, nil)

}
```

Client

```go
package main

import (
	"fmt"
	"log"
	"net/rpc"
	//"time"
)

type Args struct {
	A, B int
}

func main() {

	client, err := rpc.DialHTTP("tcp", "127.0.0.1:1234")
	if err != nil {
		log.Fatal("dialing:", err)
	}

	// Synchronous call
	args := &Args{7, 8}
	var reply int
	err = client.Call("Arith.Multiply", args, &reply)
	if err != nil {
		log.Fatal("arith error:", err)
	}
	fmt.Printf("Arith: %d*%d=%d", args.A, args.B, reply)

}
```

