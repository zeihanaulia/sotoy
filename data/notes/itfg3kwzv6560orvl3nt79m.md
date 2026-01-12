
## Percobaan Gagal


```go
// You can edit this code!
// Click here and start typing.
package main

import "fmt"

func main() {
	fmt.Println(maximumSubarraySum([]int{9, 9, 9, 1, 2, 3}, 3))
	// fmt.Println(isDuplicate([]int{2, 9, 9}))
}

var subarray = [][]int{}

func maximumSubarraySum(nums []int, k int) int64 {
	for x := range nums {
		sub := k + x
		if sub <= len(nums) {
			// fmt.Println(x, k+x, nums[x:k+x])
			subarray = append(subarray, nums[x:k+x])
		}
	}

	sums := []int{}
	for _, subs := range subarray {

		// fmt.Println(subs, isDuplicate(subs))
		if isDuplicate(subs) {
			continue
		}

		result := 0
		for i := 0; i < len(subs); i++ {
			result += subs[i]
		}
		sums = append(sums, result)
		fmt.Println(sums, result)
	}

	max := 0
	for _, v := range sums {
		if max < v {
			max = v
		}
	}

	return int64(max)
}

func isDuplicate(subs []int) bool {
	temp := make(map[int]int)
	for _, v := range subs {
		_, ok := temp[v]
		if ok {
			return true
		}
		temp[v] = 0
	}
	return false
}


```

## Fixed Pake sliding window

```go
func maximumSubarraySum(nums []int, k int) int64 {
	n := len(nums)
	if n < k {
		return 0
	}

	max := 0
	currentSum := 0
	left := 0
	seen := make(map[int]bool)

	for right := 0; right < n; right++ {

		for seen[nums[right]] {
			seen[nums[left]] = false
			currentSum -= nums[left]
			left++
		}

		seen[nums[right]] = true
		currentSum += nums[right]

		if right-left+1 == k {
			if currentSum > max {
				max = currentSum
			}

			seen[nums[left]] = false
			currentSum -= nums[left]
			left++
		}
	}

	return int64(max)
}
```