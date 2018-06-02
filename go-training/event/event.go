package event

type IEvent interface {
	Name() string
}

type Event struct {
	name string
}

func (event Event) Name() string {
	return event.name
}

type EventInfo struct {
	event    IEvent
	target   *EventTarget
	listener *EventListener
}

func (info *EventInfo) wrapper(event interface{}) {
	info.listener.handleEvent(event)
}

type EventTarget struct {
	eventInfos []EventInfo
}

func (target *EventTarget) addEventListener(event IEvent, listener *EventListener) {
	info := EventInfo{event, target, listener}
	target.eventInfos = append(target.eventInfos, info)
}

func (target *EventTarget) removeEventListener(event IEvent, listener *EventListener) {
	removeIndexes := []int{}
	for i, eventInfo := range target.eventInfos {
		if (eventInfo.event.Name() == event.Name()) && (eventInfo.target == target) && (eventInfo.listener == listener) {
			removeIndexes = append(removeIndexes, i)
		}
	}
	for i := len(removeIndexes) - 1; 0 <= i; i-- {
		target.eventInfos = append(target.eventInfos[:i], target.eventInfos[i+1:]...)
	}
}

func (target *EventTarget) dispatchEvent(event interface{}) {
	for _, eventInfo := range target.eventInfos {
		if event, ok := event.(IEvent); ok {
			if (eventInfo.event.Name() == event.Name()) && (eventInfo.target == target) {
				eventInfo.wrapper(event)
			}
		}
	}
}

type EventListener struct {
	callback func(interface{})
}

func (listener *EventListener) handleEvent(event interface{}) {
	listener.callback(event)
}
