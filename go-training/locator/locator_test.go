package locator

import (
	"testing"
)

type S struct {
	name string
}

func TestLocator(t *testing.T) {
	var locator = &Locator{}
	locator.init()
	locator.provide("x", S{"X"})
	locator.provide("y", S{"Y"})
	if x, ok := locator.get("x").(S); ok {
		if x.name != "X" {
			t.Error("")
		}
		t.Log(x.name)
	}
	var y = locator.get("y")
	if y, ok := y.(S); ok {
		if y.name != "Y" {
			t.Error("")
		}
		t.Log(y.name)
	}
}
