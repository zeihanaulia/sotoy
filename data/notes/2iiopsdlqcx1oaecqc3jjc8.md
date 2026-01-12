
## Brute Force

```go
func twoSum(nums []int, target int) []int {
    arr := []int{}
    for x := range nums {
        for j := range arr {
            if nums[x] == arr[j] {
                return []int{j, x}
            }
        }
       arr =  append(arr, target - nums[x])
    }
    return []int{}
}
```

## Maps

```go
func twoSum(nums []int, target int) []int {
  hash := make(map[int]int)
  for x := range nums {
    tt := target - nums[x]
    if i, ok := hash[tt]; ok {
        return []int{i, x}
    }
    hash[nums[x]] = x
  }
  return []int{}
}
```