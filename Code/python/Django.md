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

