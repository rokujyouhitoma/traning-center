# -*- coding: utf-8 -*-
#
# Copyright 2012-2015 Spotify AB
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
from luigi import six

import luigi


class InputText(luigi.ExternalTask):
    date = luigi.DateParameter()

    def output(self):
        return luigi.LocalTarget(self.date.strftime('/var/tmp/text/%Y-%m-%d.txt'))


class WordCount(luigi.Task):
    date_interval = luigi.DateIntervalParameter()

    def requires(self):
        return [InputText(date) for date in self.date_interval.dates()]

    def output(self):
        return luigi.LocalTarget('/var/tmp/text-count/%s' % self.date_interval)

    def run(self):
        count = {}

        for f in self.input():
            for line in f.open('r'):
                for word in line.strip().split():
                    count[word] = count.get(word, 0) + 1

        # output data
        f = self.output().open('w')
        for word, count in six.iteritems(count):
            f.write("%s\t%d\n" % (word, count))
        f.close()


#if __name__ == '__main__':
#    luigi.run(['WordCount','--workers','1','--date-interval','2015-03','--local-scheduler'])

