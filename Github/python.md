# python编程
#### 一、变量和数据类型
> 定义变量 `name`
1. 变量的命名
- 只能包含字母数字下划线，不能数字打头
- 不能包含空格
- 不能将python关键字和函数名用作变量名
- 慎用IO
2. 字符串
- 修改字符串大小
  + `name`.title()
  + `name`.upper()
  + `name`.lower()
- `name`+" "+`name`
- `\t` & `\n`
- 删除空白
  + `name`.rstrip() 尾
  + `name`.lstrip() 头
  + `name`.strip() 两头
- str()
	age = 23
	message = "Happy" + str(age)rd + "birthday!"
- 转义 \
  + \
  + r'...' & r'''...'''
- 字符编码
  print `u`'...'
3. boolean
`and` & `or` & `not`
#### 二、list
> 定义列表 `bicycle`= ['1','2']
- list 有序集合 （index 0）
  + 增
bicycle.`append`('50') 行尾加
bicycle.`insert`(0,'11')
  + 删
bicycle.`pop`(2)
  + 改
bicycle[1] = '21'
  + 查
`print` bicycle[1],bicycle[-1]
- tuple 有序 不可修改
> 定义tuple `t` = ('1','12')

