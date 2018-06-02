cdef extern from "cfib.h":
    unsigned long _cfib "cfib"(unsigned long n)

def fib(n):
    ''' Returns the nth Fibonacci number.'''
    return _cfib(n)
