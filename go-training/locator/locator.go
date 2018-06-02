package locator

type Locator struct {
	services map[interface{}]interface{}
}

func (l *Locator) init() {
	l.services = make(map[interface{}]interface{})
}

func (l *Locator) provide(key interface{}, service interface{}) {
	l.services[key] = service
}

func (l *Locator) get(key interface{}) interface{} {
	return l.services[key]
}
