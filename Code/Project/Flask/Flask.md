##### Flask

```python
#!/bin/env python
# -*- coding:utf-8 -*-
import json
import flask
from flask import Flask,render_template,request,redirect,session

app = Flask(__name__)
app.jinja_env.variable_start_string = '{['
app.jinja_env.variable_end_string = ']}'

@app.route('/')
def hello_world():
    return render_template('index.html',all=all)

@app.route('/input',methods=['POST','GET'])
def input():
    if request.method == 'POST':
        testInfo = {}
        testInfo['name'] = request.get_json()['user']
        print(type(testInfo['name']))
        testInfo['age'] = '28'
        return json.dumps(testInfo)
    elif request.method == 'GET':
        return render_template('input.html')

@app.route('/show')
def show():
    return render_template('show.html')

@app.route('/transform/<host>',methods=['GET'])
def trans(host):
    theShy=Draven.Nox()
    theShy.transform(host)
    return theShy.Hostname

@app.route('/rms', methods=['GET','POST'])
def RMS():
    if request.method == 'POST':
        return 's'
    elif request.method == 'GET':
        return render_template('RMS.html')

@app.errorhandler(404)
def not_found(e):
    return "CANT FOUND THE PAGE !!"
    

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=8080,debug=True)
```

