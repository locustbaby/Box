**11-13**

ELK zk 配置方式生效进度 配置 cli 控制台 平台

**11-19**

爬虫

所有中间件的理解，详细配置
nginx(apache) upstream(proxy pass) keepalive 
jboss ELK zk varnish redis 

**12-1**

[Jboss wiki](https://docs.jboss.org/author/display/WFLY9/Admin+Guide#)
python 巡检
bash -s Navicat for MySQL

update： python函数：sqlalchemy paramiko threading
在C、C++等语言中，三元表达式作为一种常用的表达式起到广泛的作用，但是在Python中却并没有这么方便直接的表达式。最近在帮公司做一个项目的时候，存在需要进行多条件查询的需求，如

user = User.query.filter(User.name.like("%"+搜索的内容+"%"), User.age.like("%"+搜索的内容+"%"))

这样做需要确保搜索的内容不得为空，且我们必须要根据搜索的内容来确定进行搜索的字段，这样子5个条件如果进行if else判断的话就有2^5，即​32种可能，这是相当麻烦的一件事情，不过我发现，filter函数如果搜索条件为空的时候，即“”的时候都能够正常的列出搜索的内容，因此便考虑可以使用三元表达式来实现判断如果表单传过来的值是控制的话搜索条件变为“”，不然的话就是User.name.like("%"+搜索的内容+"%")。

具体是这么写：

search 是存放搜索内容的变量​

user = ​User.query.filter(User.name.like("%"+search+"%") if search is not None else "", User.age.like("%"+search+"%") if search is not None else "")

这个样子，原本需要N多情况判断的模糊查询用一句话就可以了。

上传 下载 
