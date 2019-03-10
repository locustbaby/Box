##### Django

###### virtualenv

```shell
#	安装
pip install virtualenv
#	创建virtualenv
virtualenv Doom
#	进入环境
source /path/to/bin/activate
#	安装Django
pip install django==2.0
#	退出环境
deactivate
```

###### virtualenvwrapper

```shell
#	
pip install virtualenvwrapper
#
mkvirtualenv Doom
#	切换
workon env_name
#	
rmvirtualenv env_name
#
lsvirtualenv env_name
#
cdvirtualenv env_name
#
环境变量 WORKON_HOME
#
mkvirtualenv --python=/path/to/python env_name
```

###### pymysql

```shell
安装mysql
安装pymysql
```

| Django version | python version      |
| -------------- | ------------------- |
| 1.8            | 2.7.3.2 3.3 3.4 3.5 |
| 1.9， 1.10     | 2.7， 3.4 3.5       |
| 1.11           | 2.7， 3.4 3.5 3.6   |
| 2.0            | 3.4 3.5 3.6         |
| 2.1            | 3.5 3.6 3.7         |

##### Tornado

```python
import os

import tornado.httpserver
import tornado.web
import tornado.ioloop
import tornado.options

from tornado.options import define, options
define(name='port',default=8000,help='run on the given port',type=int)

class IndexHandler(tornado.web.RequestHandler):
    def get(self):
        self.render('index.html')

# / PoemPageHandler
class PoemPageHandler(tornado.web.RequestHandler):
    def post(self):
        noun1 = self.get_argument('noun1')
        noun2 = self.get_argument('noun2')
        verb = self.get_argument('verb')
        noun3 = self.get_argument('noun3')
        self.render('poem.html', roads=noun1, wood=noun2, made=verb,
                difference=noun3)

if __name__ == '__main__':
    tornado.options.parse_command_line()
    app = tornado.web.Application(	#handlers url及页面	templates功能
        handlers=[
            (r'/',IndexHandler),
            (r'/poem',PoemPageHandler)
        ],
        templates_path = os.path.join(os.path.dirname(__file__), "templates")
    )
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()
```

##### Flask

```python
import flask
```



