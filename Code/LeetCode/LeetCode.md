##### LeetCode by PY3

> 排序数组中删除重复项

```python
class Solution:
    def removeDuplicates(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """  
        # set(nums)
        i=0
        while i < len(nums)-1:
            if nums[i] == nums[i+1]:
                nums.remove(nums[i])
            else:
                i=i+1
```

> 买卖股票的最佳时机

```python
class Solution:
    def maxProfit(self, prices):
        """
        :type prices: List[int]
        :rtype: int
        """
        i=0			# list index
        flag=0		# box state
        now=0		# now sum
        SUM=0		# SUM
        for i in range(0,len(prices)-1):
            if flag==0 and prices[i]<prices[i+1]:
                now=now-prices[i]
                flag=1

            elif flag==1 and prices[i]>prices[i+1]:
                sale=prices[i]
                SUM=now=now+prices[i]
                flag=0
            else:
                continue    
        if flag == 1:SUM=now+prices[-1]
        return SUM
```

> 两数之和	（950ms）

```python
class Solution:	
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        for i in range(len(nums)):
            a=nums.pop(0)
            if target-a in nums:
                return [i, nums.index(target-a)+i+1]
                break
            else:
                continue
```

