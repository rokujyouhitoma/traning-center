from distutils.core import setup, Extension
from Cython.Build import cythonize

ext = Extension(
    name="echo_server",
    sources=["echo_server.pyx"],
    extra_compile_args=["-O3"]
    #language="c++",
)

setup(ext_modules=cythonize(ext))
