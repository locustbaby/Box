#### C

Hello world

```c
#include <stdio.h>
/* first c */
main()
{
  printf("hello world\n");
}
/* 编译： cc hello.c */
```

代码实例

```c
#include <stdio.h>
#define LOWER 0	 /* 符号常量 */
#define UPPER 100
#define STEP 20
main()
{
  int lower, upper, step;/* 声明 */
  /* float,char,short,long,double */
  lower = 0;
  upper = 10;
  while (lower  <= upper) {
    lower = lower + 1
    printf("%3d\t%6d", lower, upper); /* %宽度类型 */
    printg("%3.0f\t%6.1f", "4.1", "2.333"); /* 0位小数、1位小数 */
  }
  /* getchar;putchar */
  int c;
  long nc;
  nc = 0;
  c = getchar();
  while ((c = getchar()) != EOF) {
    ++nc;
    putchar(c);
  }
}
/* wc主体：统计行数、单词数、字符数 */
#include <stdio.h>

#define IN 1		/* 在单词内 */
#define OUT 0		/* 在单词外 */
/* 统计输入的行数、单词数、字符数 */
main()
{
  int c, nl, nw, nc, state;
  state = OUT;
  nl = nw = nc = 0;
  while ((c = getchar()) != EOF) {
    ++nc;
    if (c == '\n')
      ++nl;
    if (c == ' ' || c == '\n' || c == '\t')
      state = OUT;
    else if (state == OUT) {
      state = IN;
      ++nw;
    }
  }
  printf("%d %d %d\n", nl, nw, nc);
}
int power(int m, int )/* 参数名可选 */
{
  printf("A")
}
/* 终极实例 */
#include <stdio.h>

#define MAXLINE 1000

int max;
char line[MAXLINE];
char longest[MAXLINE];

int getline(void);
void copy(void);

/* 打印最长的行 */
main()
{
  int len;
  extern int max;
  extern char longest[];
  max = 0;
  while ((len = getline()) > 0)
    if (len > max) {
      max = len;
      copy();
    }
  if (max > 0)
    printf("%s", longest);
  return 0;
}
/*  */
int getline(void)
{
  int c, i;
  extern char line[];
  for (i=0; i < MAXLINE-1
      && (c=getchar()) != EOF && c != '\n'; ++i)
    line[i] = c;
  if (c == '\n') {
    line[i] = c;
    ++i;
  }
  line[i] = '\0';
  return i;
}
/*  */
void copy(void)
{
  int i;
  extern char line[], longest[];
  i = 0;
  while ((longest[i] = line[i]) != '\0')
    ++i;
}

```

##### C  now start

```c
/* 变量名： 数字字母下划线 */
/* 数据类型及长度 */
char /* signed unsigned */
int  /* 默认整数自然长度 short（16位） long（32位）（int 可省略）|signed unsigned */
float
double
/* 常量： 字符常量 => 整数 */
/* 声明 */
/* 关系运算符&逻辑运算符 */
/* 类型转换 */
/* 自增&自减运算符 */
/* 按位运算符 */
/* 赋值运算符&表达式 */
/* 条件表达式 */
/* 运算符优先级&求值次序 */
```

##### 函数和程序结构

```c
/* main */
#include <stdio.h>
#include <stdlib.h>

#define MAXOP 100
#define NUMBER '0'
int getop(char []);
void push(double);
double pop(void);

main()
{
  int type;
  double op2;
  char s[MAXOP];
  
  while ((type = getop(s)) != EOF) {
    switch (type) {
      case NUMBER:
        push(atof(s));
        break;
      case '+':
        push(pop() + pop());
        break;
      case '*':
        push(pop() * pop());
        break;
      case '-':
        op2 = pop();
        push(pop() - op2);
        break;
      case '/':
        op2 = pop();
        if (op2 != 0.0)
          push(pop() / op2);
        else
          printf("error: zero divisor\n");
        break;
      case '\n':
        printf("\t%.8g\n", pop());
        break;
      default:
        printf("error: unknown command %s\n", s):
        break;
    }
  }
  return 0;
}
/* push & pop */
#define MAXVAL 100

int sp = 0;
double val[MAXVAL];
void push(double f)
{
  if (sp < MAXVAL)
    val[sp++] = f;
  else
    printf("error: stack full, can't push %g\n", f);
}

double pop(void)
{
  if (sp > 0)
    return val[--sp];
  else {
    printf("error: stack empty\n");
    return 0.0;
  }
}
/* getops */
#include <ctype.h>

int getch(void);
void ungetch(int);

int getops(char s[])
{
  int i, c;
  
  while ((s[0] = c = getch()) == '' || c == '/t')
    ;
  s[1] = '\0';
  if (!isdigit(c) && c != '.')
    return c;
  i = 0;
  if (isdigit(c))
    while (isdigit(s[++i] = c = getch()))
      ;
  if (c == '.')
    while (isdigit(s[++i] = c = getch()))
      ;
  s[i] = '\0';
  if (c != EOF)
    ungetch(c);
  return NUMBER;
}
/* 作用域规则:从声明到所在的文件结束 */
extern int sp;
int sp = 0;
/* 头文件 */
#include "c.h"
/* 静态变量：将其声明的对象的作用域限定为被编译源文件的剩余部分 */
static int bufp = 0;
/* 寄存器变量 */
register int x;
/* 程序块结构 */
/* 初始化 */
int low = 0;
char pattern[] = "ould"; /* 等价于：char pattern[] = { 'o','u','l','d','\0' }; */
/* 递归 */
/* c预处理器 */
/* 1,文件包含 */
#include "file" or #include <file>
/* 2,宏替换 */
#define name 'word'
```

##### 指针与数组

```c
p = &c /* &取一个对象的地址;*间接寻址,作用于指针时,取指针指向的对象 */
void swap(int *px, int *py)
{
  int temp;
  temp = *px;
  *px = *py;
  *py = temp;
  /* 指针与数组 */
  int a[10];
  int *pa;
  pa = &a[0];
  x = *pa; /* x = a[0] ; *(pa+i) = a[i] */
}
/* strlen */
int strlen(char *s)
{
  int n;
  for (n=0; *s != '\0'; s++)
    n++;
  return n;
}
```

##### 结构

```c

```

##### 输入输出

```c

```

#####Unix接口

