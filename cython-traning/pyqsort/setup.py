from distutils.core import setup, Extension
from Cython.Build import cythonize

ext = Extension(
    name="pyqsort",
    sources=["pyqsort.pyx"],
    extra_compile_args=["-O3"]
    #language="c++",
)

setup(ext_modules=cythonize(ext))
