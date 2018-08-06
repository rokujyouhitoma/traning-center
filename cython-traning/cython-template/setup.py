from distutils.core import setup, Extension
from Cython.Build import cythonize

sources = ['sample.py']

include_dirs = []

libraries = []

CFLAGS = ['-Wall', '-std=c99', '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=64', '-O3', '-g']

ext = Extension('main',
                sources=['main.py'] + sources,
                include_dirs=include_dirs,
                libraries=libraries,
                language='c',
                extra_compile_args=CFLAGS)

setup(name='main',
      ext_modules=cythonize([ext]))
