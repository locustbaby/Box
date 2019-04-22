##### ./templates/index.html

```html
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>TOOS</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim 和 Respond.js 是为了让 IE8 支持 HTML5 元素和媒体查询（media queries）功能 -->
    <!-- 警告：通过 file:// 协议（就是直接将 html 页面拖拽到浏览器中）访问页面时 Respond.js 不起作用 -->
    <!--[if lt IE 9]>
      <script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>

    <div class="container">
      <h1>你好，世界！</h1>
      <div class="row">
        <div class="bs-example" data-example-id="hoverable-table">
         <table class="table table-hover">
      <thead>
        <tr>
          <th>#</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Username</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th scope="row">1</th>
          <td>Mark</td>
          <td>Otto</td>
          <td>@mdo</td>
        </tr>
      </tbody>
    </table>
  </div>   
  <textarea class="form-control" id="form-control" rows="3"></textarea>
  <button type="button" class="btn btn-default">submit</button>
      </div>
    </div>

    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <script type="text/javascript"> 
      //var value=document.getElementByClassName("form-control")
      $(document).ready(function(){
        $("button").click(function(){
          var value=$("#form-control").val();
          $.post("/input.html",{user:value},function(data){
              alert(data)})
          });
        });
    </script>
    
  </body>
</html>
```

##### flask.py

```python
#!/bin/env python
# -*- coding:utf-8 -*-
from flask import Flask,render_template,request,redirect,session
import json
app = Flask(__name__)

@app.route('/')
def hello_world():
    return render_template('index.html')

@app.route('/input.html',methods=['POST','GET'])
def input():
    if request.method=='POST':
        testInfo = {}
        testInfo['name'] = request.form.get('user')
        testInfo['age'] = '28'
    return json.dumps(testInfo)

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=8080,debug=True)
```

