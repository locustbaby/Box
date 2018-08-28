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
        a = k%len(nums)
        nums[:] = nums[-a:]+nums[:-a]
```

> 存在重复

```python
class Solution:
    def containsDuplicate(self, nums):
        """
        :type nums: List[int]
        :rtype: bool
        """
        if len(set(nums)) == len(nums):
            return False
        else:
            return True
```

> 只出现一次的数字

```python
class Solution:
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        num = 0
        for i in nums:
            num ^= i
        return num
```

