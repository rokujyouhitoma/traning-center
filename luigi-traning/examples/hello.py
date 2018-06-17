import luigi

class HelloWorldTask(luigi.Task):
    task_namespace = 'examples'

    def requires(self):
        return SecondWorldTask()

    def run(self):
        print("{task} says: Hello world!".format(task=self.__class__.__name__))

class SecondWorldTask(luigi.Task):
    task_namespace = 'examples'

    def run(self):
        with self.output().open('w') as output:
            output.write('{task} says: Second world!\n'.format(task=self.__class__.__name__))

    def output(self):
        return luigi.LocalTarget('second_world.txt')
