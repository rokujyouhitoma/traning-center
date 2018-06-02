package main

import (
    "fmt"
    "math/rand"
)

func main() {
    arr := []string{"a", "b", "c", "d", "e"}
    fmt.Println(arr)
    shuffle(arr)
    fmt.Println(arr)
}

func shuffle(list []string) {
    // Fisher–Yates shuffle
    l := len(list)
    for i := l - 1; 0 <= i; i-- {
		r := rand.Intn(i + 1)
		list[i], list[r] = list[r], list[i]
	}
}
