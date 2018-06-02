from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize

ext_modules = cythonize([Extension("tinysegmenter", ["tinysegmenter.pyx"])],
#                        annotate=True
                        )

setup(
  name = 'Tiny Segmenter',
  cmdclass = {'build_ext': build_ext},
  ext_modules = ext_modules)
