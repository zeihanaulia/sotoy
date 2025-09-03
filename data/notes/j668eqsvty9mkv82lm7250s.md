
## Brute Force


```go

func isPalindrome(s string) bool {
	forward := strings.ToLower(strings.ReplaceAll(cleanString(s), " ", ""))
	var backward []string
	for right := len(forward) - 1; right >= 0; right-- {
		backward = append(backward, fmt.Sprintf("%c", forward[right]))
	}
	backwardString := strings.Join(backward, "")
	if backwardString == forward {
		return true
	}
	return false
}

var nonAlphanumericRegex = regexp.MustCompile(`[^a-zA-Z0-9 ]+`)

func cleanString(str string) string {
	return nonAlphanumericRegex.ReplaceAllString(str, "")
}
```


## Two Pointer


```go
func isPalindrome(s string) bool {
	left := 0
	right := len(s) - 1

	for left < right {
		for left < right && !isAlphanumeric(rune(s[left])) {
			left++
		}

		for left < right && !isAlphanumeric(rune(s[right])) {
			right--
		}

		if unicode.ToLower(rune(s[left])) != unicode.ToLower(rune(s[right])) {
			return false
		}

		right--
		left++
	}
	return true
}

func isAlphanumeric(c rune) bool {
	return ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || ('0' <= c && c <= '9')
}
```