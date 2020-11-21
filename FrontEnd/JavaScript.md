#### JavaScript

##### js基础语法

```javascript
操作符之间的优先级（高到低）:
算术操作符 → 比较操作符 → 逻辑操作符 → "="赋值符号
```

##### Array //变长

```javascript
<script type="text/javascript">
 var myarr=new Array(); //定义数组 可指定长度 new Array(8) 无意义
 myarr[0]=80; 
 myarr[1]=60;
 myarr[2]=99;
</script>
//空数组显示为
undefined
//数组赋值
var myarray = new Array(66,80,90,77,59);//创建数组同时赋值
var myarray = [66,80,90,77,59];//直接输入一个数组（称 “字面量数组”）
//length
myarray.length
//二维数组
//定义方法一
var myarr=new Array();  //先声明一维 
for(var i=0;i<2;i++){   //一维长度为2
   myarr[i]=new Array();  //再声明二维 
   for(var j=0;j<3;j++){   //二维长度为3
   myarr[i][j]=i+j;   // 赋值，每个数组元素的值为i+j
   }
 }
//定义方法二 行列
var Myarr = [[0 , 1 , 2 ],[1 , 2 , 3]]
```

