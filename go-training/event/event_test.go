package event

import (
	"testing"
)

type TestCustomEvent struct {
	name    string
	message string
}

func (event TestCustomEvent) Name() string {
	return event.name
}

func TestEvent(t *testing.T) {
	var e Event
	e.name = "hi"
	var e2 = new(Event)
	e2.name = "hi"
	var e3 = Event{"hi"}
	_ = e3
}

func TestEventTarget(t *testing.T) {
	var listener = EventListener{func(e interface{}) {
		if e, ok := e.(IEvent); ok {
			t.Log("listener: " + e.Name())
		}
	}}
	var target = EventTarget{}
	target.addEventListener(Event{"OnTest"}, &listener)
	target.dispatchEvent(Event{"OnTest"})
}

func TestEventTarget2(t *testing.T) {
	var listener = EventListener{func(e interface{}) {
		if e, ok := e.(IEvent); ok {
			t.Log("listener: " + e.Name())
		}
	}}
	var listener2 = EventListener{func(e interface{}) {
		if e, ok := e.(IEvent); ok {
			t.Log("listener2: " + e.Name())
		}
	}}
	var listener3 = EventListener{func(e interface{}) {
		if e, ok := e.(TestCustomEvent); ok {
			t.Log("listener3: " + e.message)
		}
	}}
	var target = EventTarget{}
	target.addEventListener(Event{"OnTest"}, &listener)
	target.addEventListener(Event{"OnTest"}, &listener2)
	target.addEventListener(Event{"OnTest"}, &listener3)
	target.dispatchEvent(Event{"OnTest"})
	target.dispatchEvent(TestCustomEvent{"OnTest", "hello"})
}

func TestEventTarget3(t *testing.T) {
	var listener = EventListener{func(e interface{}) {
		if e, ok := e.(IEvent); ok {
			t.Log("listener: " + e.Name())
		}
	}}
	var target = EventTarget{}
	target.addEventListener(Event{"OnTest"}, &listener)
	target.addEventListener(Event{"OnTest"}, &listener)
	target.addEventListener(Event{"OnTest"}, &listener)
	target.removeEventListener(Event{"OnTest"}, &listener)
	target.dispatchEvent(Event{"OnTest"})
}

func TestEventListener(t *testing.T) {
	var e = Event{"OnTest"}
	var listener = EventListener{func(e interface{}) {
		if e, ok := e.(IEvent); ok {
			t.Log(e.Name())
		}
	}}
	listener.handleEvent(e)
}
