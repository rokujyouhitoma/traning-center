=======
Cython
=======

IPythonでCython

.. code-block:: python
   
   %load_ext cythonmagic

   %%cython
   def fib(long n):
   cdef long a=0, b=1, i
   for i in range(n):
       a, b = a+b, a
       return a


==================
ε( v ﾟωﾟ)  < TODO
==================

そもそも基本的な知識なさすぎワロエナイ

- nm
- readelf
- lld
- objedump

nm
===

.. code-block:: bash

   $ nm wrap_fib.so -a
