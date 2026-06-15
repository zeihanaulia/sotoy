---
id: til.coding.remove-duplicates-from-sorted-array.Code
title: Code
desc: ''
updated: 1776324693737
created: 1743493116028
---

## Two Pointer

```go
func removeDuplicates(nums []int) int {
    left := 0
    for right:=1; right < len(nums); right++ {
        if nums[left] != nums[right] {
            left++
            nums[left] = nums[right]
        }
    }
    return left + 1
}
```