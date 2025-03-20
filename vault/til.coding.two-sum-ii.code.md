---
id: 7ujwboqgqdxln6skhdzne9h
title: Code
desc: ''
updated: 1742353016584
created: 1742346503084
---

Playground: https://go.dev/play/p/V9SQqDEmpzx

## Maps

```go
func twoSum(numbers []int, target int) []int {
  hash := make(map[int]int)
  for x := range numbers {
    tt := target - nums[x]
    if i, ok := hash[tt]; ok {
        return []int{i+1, x+1}
    }
    hash[numbers[x]] = x
  }
  return []int{}
}
```


## Two Pointer

```go
func twoSum(numbers []int, target int) []int {
    left, right := 0, len(numbers)-1
    for left < right {
        sum := numbers[left] + numbers[right]
        if sum == target {
            return []int{left+1, right+1}
        } else if sum > target {
            right--
        } else {
            left++
        }
    }
    return []int{}
}
```