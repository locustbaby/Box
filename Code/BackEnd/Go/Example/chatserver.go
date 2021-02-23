package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"time"
)

type Message struct {
	// format
	User string
	Text string
}

var Chanmessage = make(chan Message)

type Line struct {
	// format line
	Timestamp float64
	User      string
	Text      string
}

// check user
var User_contain = make(map[string]string)

// contain user
var Users = make(map[string][]string)

// contain message
var Messages = make(map[string][]Line)

func status(c http.ResponseWriter, req *http.Request) {
	c.Write([]byte("alive"))
}

func stor_message(mess Message) {
	_, ok := User_contain[mess.User]
	if !ok {
		User_contain[mess.User] = ""
		Users["users"] = append(Users["users"], mess.User)
	}
	var line Line
	line.Timestamp, _ = strconv.ParseFloat(fmt.Sprintf("%.2f", float64(time.Now().UnixNano())/1000000000), 64)
	line.User = mess.User
	line.Text = mess.Text
	Messages["messages"] = append(Messages["messages"], line)
}

func message(c http.ResponseWriter, req *http.Request) {
	if req.Method == "POST" {
		var mess Message
		// Chanmessage <- mess
		if err := json.NewDecoder(req.Body).Decode(&mess); err == nil {
			// mess := <-Chanmessage
			go stor_message(mess)
			c.Header().Set("content-type", "text/json")
			res := map[string]bool{"ok": true}
			json, _ := json.MarshalIndent(res, "", "    ")
			c.Write(json)
		}
	}
}

func messages(c http.ResponseWriter, req *http.Request) {
	if req.Method == "GET" {
		res := Messages
		json, _ := json.MarshalIndent(res, "", "    ")
		c.Write(json)
	}
}

func users(c http.ResponseWriter, req *http.Request) {
	if req.Method == "GET" {
		res := Users
		json, _ := json.MarshalIndent(res, "", "    ")
		c.Write(json)
	}
}
func notfound(c http.ResponseWriter, req *http.Request) {
	c.Write([]byte("404"))
}

func main() {
	http.HandleFunc("/status", status)
	http.HandleFunc("/message", message)
	http.HandleFunc("/messages", messages)
	http.HandleFunc("/users", users)
	http.HandleFunc("/", notfound)

	err := http.ListenAndServe(":8081", nil)
	panic(err)
}
