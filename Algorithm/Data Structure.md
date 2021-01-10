#### 数组

---

##### 集合、列表和数组

```
集合：无序，元素类型可以不同
列表：有序，列表最常见的表现形式有数组和链表，而我们熟悉的栈和队列则是两种特殊类型的列表
数组：数组有索引（列表无索引），数组中的元素在内存中是连续存储的，且每个元素占用相同大小的内存。
```



```

```

##### 二维数组

```

```

#### 字符串

ADT（abstract data type）抽象数据类型

#### 队列

---

```

```

#### 栈

---

```

```

#### 堆

---

```

```

#### 链表

---

```

```

#### 二叉树

---

[二叉树百度百科](https://baike.baidu.com/item/%E4%BA%8C%E5%8F%89%E6%A0%91/1602879?fr=aladdin)

```
			F
	B				G
A		D				I
	C		E		H

前序(根左右):FBADCEGIH
中序(左根右):ABCDEFGHI
后序(左右根):ACEDBHIGF

```

##### 二叉搜索(查找)树

```

```

##### AVL树

##### 伸展树

##### B-树



##### 递归

```
A调用A
```

##### 迭代

```
A重复调用B
```

##### 前序遍历-迭代

```go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func preorderTraversal(root *TreeNode) (vals []int) {
    // 名 stack 实际 list
    stack := []*TreeNode{}
    node := root
    for node != nil || len(stack) > 0 {
        for node != nil {
            vals = append(vals, node.Val)
            stack = append(stack, node) //[node]
            node = node.Left    // 轮询左节点 到空：前序遍历
        }
        node = stack[len(stack)-1].Right //遍历右节点
        stack = stack[:len(stack)-1] //右节点遍历结束，删掉
    }
    return
}
```



#### N叉树

---

```

```

#### 图

---

```

```
