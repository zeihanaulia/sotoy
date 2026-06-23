
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