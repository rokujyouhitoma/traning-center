import pyximport
pyximport.install();

from random import shuffle
from pyqsort import pyqsort

if __name__ == '__main__':
    intlist = range(10)
    shuffle(intlist)
    print(intlist)
    pyqsort(intlist)
    print(intlist)
