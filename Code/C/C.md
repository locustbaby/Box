#### C

Hello world

```c
#include <stdio.h>
/* first c */
main()
{
  printf("hello world\n");
}
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

