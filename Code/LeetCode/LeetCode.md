##### LeetCode by PY3

> 排序数组中删除重复项

```python
class Solution:
    def removeDuplicates(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """  
        if not nums:
            return 0

        chage = 0
        for i in range(1, len(nums)):
            if nums[i] != nums[chage]:
                chage = chage + 1
                nums[chage] = nums[i]
                
        return chage + 1
```

> 买卖股票的最佳时机

```python
class Solution:
    def maxProfit(self, prices):
        """
        :type prices: List[int]
        :rtype: int
        """
        ans = 0
        for i in range(1, len(prices)):
            if prices[i] > prices[i - 1]:
                ans += prices[i] - prices[i - 1]
        return ans
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

> 旋转数组

```python
class Solution:
    def rotate(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: void Do not return anything, modify nums in-place instead.
        """
        #nap = k%len(nums)
        #for i in range(nap):
        #    x=nums.pop()
        #    nums.insert(0,x)
        a = k%len(nums)
        nums[:] = nums[-a:]+nums[:-a]
```

