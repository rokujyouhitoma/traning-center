cdef extern from "stdlib.h":
  void *malloc(size_t size)
  void free(void *ptr)
  void qsort(void *array, size_t count, size_t size, int (*compare)(const void *, const void *))
