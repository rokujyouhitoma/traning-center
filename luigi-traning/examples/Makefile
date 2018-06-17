hello:
	PYTHONPATH='.' luigi --module hello examples.HelloWorldTask --local-scheduler

wordcount:
	PYTHONPATH='.' luigi --module wordcount WordCount --date-interval 2015-03 --local-scheduler
