package util

import (
	"math/rand"
	"strings"
)

const alpha = "abcdefghjklmnopqrstuvwxyz"

// randomInt generates a random integer between min and max
func RandomInt(min, max int64) int64 {
    if max < min {
        min, max = max, min // swap if needed
    }
    return rand.Int63n(max-min+1) + min
}

// randomString generates a random string of length n
func RandomString(n int) string {
	var sb strings.Builder	
	k := len(alpha)

	for range n {
		c := alpha[rand.Intn(k)]
		sb.WriteByte(c)
	}

	return sb.String()
}

// RandomOwner generates a random owner name
func RandomOwner() string {
	return RandomString(6)
}

// randomMoney generates a random money
func RandomMoney() int64 {
	return RandomInt(0, 1000)
}

// randomCurrency generates a random currency
func RandomCurrency() string {
	currencies := []string{
		"USD",
		"EURO",
		"CAD",
	}

	n := len(currencies)
	return currencies[rand.Intn(n)]
}
