---
id: o073b4homigwo9s7lsjw411
title: Code
desc: ''
updated: 1742351973142
created: 1742351928076
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