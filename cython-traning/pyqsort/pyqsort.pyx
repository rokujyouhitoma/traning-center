ctypedef int (*qsort_cmp)(const void *, const void *)

def pyqsort(list x, reverse=False):
    cdef int *array
    cdef int i, N
    cdef qsort_cmp cmp_callback

    N = len(x)
    array = <int*>malloc(sizeof(int) * N)
    if array == NULL:
        raise MemoryError()

    for i in range(N):
        array[i] = x[i]

    if reverse:
        cmp_callback = reverse_int_compare
    else:
        cmp_callback = int_compare

    qsort(<void*>array, <size_t>N, sizeof(int), cmp_callback)

    for i in range(N):
        x[i] = array[i]
    free(array)

cdef int int_compare(const void *a, const void *b):
    cdef int ia, ib
    ia = (<int*>a)[0]
    ib = (<int*>b)[0]
    return ia - ib

cdef int reverse_int_compare(const void *a, const void *b):
    return -int_compare(a, b)
